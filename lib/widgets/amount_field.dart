import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'help.dart';

/// A money field in euros. It reports every valid amount as the user types,
/// so a save pressed while the field has focus stores what is shown.
class AmountField extends StatefulWidget {
  final int? initialValueCents;
  final ValueChanged<int> onChanged;
  final String label;
  final String help;
  final String? helperText;
  final bool readOnly;
  final bool required;

  /// The amount must be above zero, for a cost or price that cannot be free.
  final bool positive;
  final String? validatorMessage;

  /// An extra check on the parsed amount; returns an error message or null.
  final String? Function(int cents)? check;

  const AmountField({
    super.key,
    this.initialValueCents,
    required this.onChanged,
    required this.label,
    required this.help,
    this.helperText,
    this.readOnly = false,
    this.required = false,
    this.positive = false,
    this.validatorMessage,
    this.check,
  });

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  var _normalizationScheduled = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: _display(widget.initialValueCents),
    );
    _focusNode = FocusNode()..addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _display(int? cents) =>
      cents == null ? '' : AppFormat.cents(cents).replaceAll('€', '').trim();

  void _normalizeDisplayedTextAfterFrame() {
    if (_normalizationScheduled ||
        _focusNode.hasFocus ||
        !_controller.text.contains('€')) {
      return;
    }
    _normalizationScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _normalizationScheduled = false;
      if (!mounted || _focusNode.hasFocus) return;
      final cents = _parse(_controller.text);
      if (cents != null) {
        _controller.text = _display(cents);
      }
    });
  }

  int? _parse(String text) => AppFormat.parseCents(text);

  /// The error for [text], or null when it is a valid amount.
  String? _error(String text) {
    final l = AppLocalizations.of(context)!;
    final s = text.trim();
    if (s.isEmpty) {
      return widget.required || widget.positive
          ? widget.validatorMessage ?? l.amountRequiredError
          : null;
    }
    final parsed = _parse(s);
    if (parsed == null) return l.amountInvalidError;
    if (parsed < 0) return l.amountNegativeError;
    if (widget.positive && parsed == 0) {
      return widget.validatorMessage ?? l.amountRequiredError;
    }
    return widget.check?.call(parsed);
  }

  void _report(String text) {
    final parsed = _parse(text);
    if (parsed != null && _error(text) == null) widget.onChanged(parsed);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      final cents = _parse(_controller.text);
      _controller.text = cents != null ? AppFormat.centsInput(cents) : '';
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    } else {
      final cents = _parse(_controller.text);
      _report(_controller.text);
      if (cents != null) _controller.text = _display(cents);
    }
  }

  @override
  Widget build(BuildContext context) {
    _normalizeDisplayedTextAfterFrame();
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      readOnly: widget.readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: _report,
      textAlign: TextAlign.left,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        label: LabelWithHelp(widget.label, required: widget.required),
        suffixIcon: fieldSuffix(widget.help),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
        helperText: widget.helperText,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 12, right: 4),
          child: Text('€', style: TextStyle(fontSize: 16)),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 32),
      ),
      validator: (v) => _error(v ?? ''),
    );
  }
}
