import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:florin/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../db/database.dart';
import '../../l10n/labels.dart';
import '../../providers/providers.dart';
import '../../services/receipt_service.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/feedback.dart';
import '../../widgets/help.dart';
import '../../widgets/value_row.dart';

/// Files chosen for a record that is not saved yet. They are checked when
/// chosen and stored by [commit] once the record has its id.
class ReceiptDraft extends ChangeNotifier {
  final List<File> files = [];

  void add(File f) {
    files.add(f);
    notifyListeners();
  }

  void remove(File f) {
    files.remove(f);
    notifyListeners();
  }

  /// Stores the chosen files for [owner] in the folder of [year].
  Future<void> commit(
    ReceiptService service,
    ReceiptOwner owner,
    int year,
  ) async {
    for (final f in List.of(files)) {
      await service.attach(owner, f, year);
      files.remove(f);
    }
  }
}

/// The files of one expense, asset or invoice: add by choosing or dropping,
/// open in the system viewer, move to the trash with undo. With no [owner]
/// yet, files go into [draft] and are stored when the record is saved.
class ReceiptsSection extends ConsumerStatefulWidget {
  final ReceiptOwner? owner;
  final ReceiptDraft? draft;

  /// The bookkeeping year of the record, which decides the folder.
  final int year;
  final String title;
  final String help;

  /// What the keep-until row shows: a date, or a phrase for assets in use.
  final String keepUntil;

  /// Whether files can be added and removed. An issued invoice's own PDF is
  /// kept as it was sent.
  final bool editable;

  const ReceiptsSection({
    super.key,
    required this.owner,
    this.draft,
    required this.year,
    required this.title,
    required this.help,
    required this.keepUntil,
    this.editable = true,
  }) : assert(owner != null || draft != null);

  @override
  ConsumerState<ReceiptsSection> createState() => _ReceiptsSectionState();
}

class _ReceiptsSectionState extends ConsumerState<ReceiptsSection> {
  bool _dragging = false;

  /// What went wrong with the last files added, shown under the list.
  final List<String> _messages = [];

  static const _extensions = [
    'pdf',
    'jpg',
    'jpeg',
    'png',
    'heic',
    'heif',
    'tif',
    'tiff',
    'xml',
  ];

  @override
  void initState() {
    super.initState();
    widget.draft?.addListener(_redraw);
  }

  @override
  void dispose() {
    widget.draft?.removeListener(_redraw);
    super.dispose();
  }

  void _redraw() => setState(() {});

  String _rejection(ReceiptRejected e, AppLocalizations l) =>
      switch (e.reason) {
        ReceiptRejection.empty => l.receiptsRejectedEmpty(e.fileName),
        ReceiptRejection.tooLarge => l.receiptsRejectedTooLarge(
          e.fileName,
          AppFormat.fileSize(ReceiptStore.maxBytes),
        ),
        ReceiptRejection.unsupported => l.receiptsRejectedType(e.fileName),
      };

  Future<void> _pick() async {
    final l = AppLocalizations.of(context)!;
    final FilePickerResult? picked;
    try {
      picked = await FilePicker.platform.pickFiles(
        dialogTitle: l.receiptsPickDialog,
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: _extensions,
      );
    } catch (e) {
      // The system file dialog itself failed; say so where it was asked for.
      if (mounted) {
        setState(() {
          _messages
            ..clear()
            ..add(describeError(e, l));
        });
      }
      return;
    }
    final paths = picked?.paths.whereType<String>() ?? const <String>[];
    await _add([for (final path in paths) File(path)]);
  }

  Future<void> _add(List<File> files) async {
    if (files.isEmpty || !mounted) return;
    final l = AppLocalizations.of(context)!;
    final service = ref.read(receiptServiceProvider);
    final messages = <String>[];
    for (final f in files) {
      try {
        await ReceiptStore.inspect(f);
        final existing = await service.duplicateOf(f);
        if (existing != null) {
          messages.add(l.receiptsDuplicate(f.uri.pathSegments.last));
        }
        final owner = widget.owner;
        if (owner == null) {
          widget.draft!.add(f);
        } else {
          await service.attach(owner, f, widget.year);
        }
      } on ReceiptRejected catch (e) {
        messages.add(_rejection(e, l));
      } catch (e) {
        messages.add(describeError(e, l));
      }
    }
    if (mounted) {
      setState(() {
        _messages
          ..clear()
          ..addAll(messages);
      });
    }
  }

  Future<void> _open(File file) async {
    final l = AppLocalizations.of(context)!;
    final ok = await launchUrl(Uri.file(file.path));
    if (!ok && mounted) {
      setState(() {
        _messages
          ..clear()
          ..add(l.receiptsOpenFailed(file.uri.pathSegments.last));
      });
    }
  }

  Future<void> _remove(Receipt r) async {
    final l = AppLocalizations.of(context)!;
    final service = ref.read(receiptServiceProvider);
    final messenger = ScaffoldMessenger.of(context);
    final removed = await guardSave(context, () => service.remove(r));
    if (!removed) return;
    messenger.showSnackBar(
      SnackBar(
        content: Text(l.receiptsRemoved),
        action: SnackBarAction(
          label: l.receiptsUndo,
          // A failed undo is reported like any other failed action.
          onPressed: () => service.restore(r).catchError(showUnhandledError),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final owner = widget.owner;
    final service = ref.watch(receiptServiceProvider);
    final stored = owner == null
        ? const AsyncValue<List<Receipt>>.data([])
        : ref.watch(receiptsProvider(owner));
    final staged = widget.draft?.files ?? const <File>[];
    final receipts = stored.valueOrNull ?? const <Receipt>[];
    final empty = receipts.isEmpty && staged.isEmpty;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(widget.title, help: widget.help),
        const SizedBox(height: AppSpacing.heading),
        if (stored.hasError)
          Text(
            l.genericLoadError(describeError(stored.error!, l)),
            style: TextStyle(color: theme.colorScheme.error),
          ),
        if (empty)
          Text(
            widget.editable ? l.receiptsNone : l.receiptsNotStored,
            style: theme.textTheme.bodySmall,
          ),
        for (final r in receipts)
          _ReceiptRow(
            receipt: r,
            file: service.store.fileOf(r),
            onOpen: _open,
            onRemove: widget.editable ? () => _remove(r) : null,
          ),
        for (final f in staged)
          _StagedRow(file: f, onRemove: () => widget.draft!.remove(f)),
        for (final m in _messages)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.tight),
            child: Text(
              m,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        if (widget.editable) ...[
          const SizedBox(height: AppSpacing.heading),
          OutlinedButton.icon(
            onPressed: _pick,
            icon: const Icon(Icons.attach_file, size: 16),
            label: Text(l.receiptsAdd),
          ),
        ],
        if (!empty) ...[
          const SizedBox(height: AppSpacing.heading),
          ValueRow(
            label: l.receiptsKeepUntil,
            help: l.receiptsKeepUntilHelp,
            value: widget.keepUntil,
          ),
        ],
      ],
    );

    if (!widget.editable) return content;
    // Files dropped anywhere on the section are added; the outline shows
    // where they will land while dragging.
    return DropTarget(
      onDragEntered: (_) => setState(() => _dragging = true),
      onDragExited: (_) => setState(() => _dragging = false),
      onDragDone: (details) {
        setState(() => _dragging = false);
        _add([for (final x in details.files) File(x.path)]);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.primary.withValues(
              alpha: _dragging ? 1 : 0,
            ),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: content,
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final Receipt receipt;
  final File file;
  final void Function(File) onOpen;
  final VoidCallback? onRemove;

  const _ReceiptRow({
    required this.receipt,
    required this.file,
    required this.onOpen,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final missing = !file.existsSync();
    final details = [
      receipt.type.label(l),
      AppFormat.fileSize(receipt.sizeBytes),
      l.receiptsAdded(AppFormat.date(receipt.addedAt)),
    ].join('  ');
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: _Thumbnail(type: receipt.type, file: missing ? null : file),
      title: EllipsisText(receipt.originalName),
      subtitle: missing
          ? Text(
              l.receiptsMissing,
              style: TextStyle(color: theme.colorScheme.error),
            )
          : EllipsisText(details, style: theme.textTheme.bodySmall),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.open_in_new, size: 18),
            tooltip: l.receiptsOpen,
            onPressed: missing ? null : () => onOpen(file),
          ),
          if (onRemove != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 18),
              tooltip: l.receiptsRemove,
              color: theme.colorScheme.error,
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}

class _StagedRow extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;

  const _StagedRow({required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const _Thumbnail(type: null, file: null),
      title: EllipsisText(file.uri.pathSegments.last),
      subtitle: Text(l.receiptsStaged, style: theme.textTheme.bodySmall),
      trailing: IconButton(
        icon: const Icon(Icons.close, size: 18),
        tooltip: l.receiptsUnstage,
        onPressed: onRemove,
      ),
    );
  }
}

/// A small preview for images Flutter can draw, an icon for the rest.
class _Thumbnail extends StatelessWidget {
  final ReceiptType? type;
  final File? file;

  const _Thumbnail({required this.type, required this.file});

  static const _size = 40.0;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    final icon = Icon(switch (type) {
      ReceiptType.pdf => Icons.picture_as_pdf_outlined,
      ReceiptType.xml => Icons.description_outlined,
      null => Icons.insert_drive_file_outlined,
      _ => Icons.image_outlined,
    }, color: color);
    final f = file;
    if (f == null || !(type?.isImage ?? false)) {
      return SizedBox.square(dimension: _size, child: icon);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.file(
        f,
        width: _size,
        height: _size,
        fit: BoxFit.cover,
        cacheWidth: 80,
        // HEIC and some TIFFs cannot be drawn on every platform.
        errorBuilder: (_, _, _) =>
            SizedBox.square(dimension: _size, child: icon),
      ),
    );
  }
}
