import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:florin/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../db/database.dart';
import '../../l10n/labels.dart';
import '../../providers/providers.dart';
import '../../services/receipt_service.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_theme.dart';
import '../../widgets/async_body.dart';
import '../../widgets/detail_scaffold.dart';
import '../../widgets/feedback.dart';
import '../../widgets/notice_banner.dart';
import 'receipts_section.dart';

/// Receipts the user took off their records. Florin keeps every one: each
/// can be opened, and put back while its record exists.
class RemovedReceiptsPage extends ConsumerStatefulWidget {
  const RemovedReceiptsPage({super.key});

  @override
  ConsumerState<RemovedReceiptsPage> createState() =>
      _RemovedReceiptsPageState();
}

class _RemovedReceiptsPageState extends ConsumerState<RemovedReceiptsPage> {
  /// Why the last file could not be opened, shown above the list.
  String? _message;

  Future<void> _open(File file) async {
    final l = AppLocalizations.of(context)!;
    final ok = await launchUrl(Uri.file(file.path));
    if (!ok && mounted) {
      setState(
        () => _message = l.receiptsOpenFailed(file.uri.pathSegments.last),
      );
    }
  }

  Future<void> _putBack(Receipt r) =>
      guardSave(context, () => ref.read(receiptServiceProvider).restore(r));

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final store = ref.watch(receiptServiceProvider).store;
    return DetailScaffold(
      title: l.removedReceiptsTitle,
      onBack: () => context.pop(),
      showSave: false,
      onSave: () {},
      body: AsyncBody(
        value: ref.watch(removedReceiptsProvider),
        builder: (removed) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NoticeBanner(l.removedReceiptsNotice(store.removedFolder)),
            const SizedBox(height: AppSpacing.group),
            if (_message != null) ...[
              Text(
                _message!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
              const SizedBox(height: AppSpacing.heading),
            ],
            if (removed.isEmpty)
              Text(l.removedReceiptsNone, style: theme.textTheme.bodySmall),
            for (final r in removed)
              ReceiptTile(
                receipt: r,
                file: store.fileOf(r),
                details: l.removedReceiptsFrom(
                  r.removedFromKind!.label(l),
                  AppFormat.date(r.removedFromDate!),
                  r.removedFromName!,
                  AppFormat.date(r.removedAt!),
                ),
                onOpen: _open,
                trailing: [
                  if (ReceiptService.canPutBack(r))
                    IconButton(
                      icon: const Icon(Icons.undo, size: 18),
                      tooltip: l.removedReceiptsPutBack,
                      onPressed: () => _putBack(r),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
