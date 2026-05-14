import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';

class AmountField extends StatefulWidget {
  final int? initialValueCents;
  final ValueChanged<int> onChanged;
  final String? label;
  final String? helperText;
  final bool readOnly;
  final bool required;
  final String? validatorMessage;

  const AmountField({
    super.key,
    this.initialValueCents,
    required this.onChanged,
    this.label,
    this.helperText,
    this.readOnly = false,
    this.required = false,
    this.validatorMessage,
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

  String _display(int? cents) {
    if (cents == null) return '';
    final formatter = NumberFormat.decimalPattern('nl_NL')
      ..minimumFractionDigits = 2
      ..maximumFractionDigits = 2;
    return formatter.format(cents / 100);
  }

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

  int? _parse(String text) {
    final cleaned = text
        .replaceAll('€', '')
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .trim();
    final v = double.tryParse(cleaned);
    return v == null ? null : (v * 100).round();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      final cents = _parse(_controller.text);
      _controller.text = cents != null
          ? (cents / 100).toStringAsFixed(2).replaceAll('.', ',')
          : '';
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    } else {
      final cents = _parse(_controller.text);
      if (cents != null) {
        widget.onChanged(cents);
        _controller.text = _display(cents);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _normalizeDisplayedTextAfterFrame();
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      readOnly: widget.readOnly,
      textAlign: TextAlign.left,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: widget.label,
        helperText: widget.helperText,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 12, right: 4),
          child: Text('€', style: TextStyle(fontSize: 16)),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 32),
      ),
      validator: (v) {
        if (widget.required && (v == null || v.isEmpty)) {
          return widget.validatorMessage;
        }
        final parsed = _parse(v ?? '');
        if (parsed != null && parsed < 0) {
          return AppLocalizations.of(context)!.amountNegativeError;
        }
        return null;
      },
    );
  }
}
