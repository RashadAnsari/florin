import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

/// An info icon that explains a term or field on hover, focus or long press.
class HelpIcon extends StatelessWidget {
  final String message;

  const HelpIcon(this.message, {super.key});

  @override
  Widget build(BuildContext context) => Tooltip(
    message: message,
    triggerMode: TooltipTriggerMode.tap,
    showDuration: const Duration(seconds: 10),
    child: Semantics(
      label: message,
      child: Icon(
        Icons.info_outline,
        size: 15,
        color: context.colors.secondaryLabel,
      ),
    ),
  );
}

/// Text on one line that shows its full content in a tooltip when there is
/// not enough room and it ends in an ellipsis. Overflow is read from the laid
/// out paragraph after each frame, so it works inside intrinsic layouts.
class EllipsisText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int maxLines;

  const EllipsisText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines = 1,
  });

  @override
  State<EllipsisText> createState() => _EllipsisTextState();
}

class _EllipsisTextState extends State<EllipsisText> {
  final _textKey = GlobalKey();
  bool _overflows = false;

  void _check(Duration _) {
    if (!mounted) return;
    final render = _textKey.currentContext?.findRenderObject();
    final overflows = render is RenderParagraph && render.didExceedMaxLines;
    if (overflows != _overflows) setState(() => _overflows = overflows);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(_check);
    final text = Text(
      widget.text,
      key: _textKey,
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: TextOverflow.ellipsis,
    );
    return _overflows ? Tooltip(message: widget.text, child: text) : text;
  }
}

/// A field or row label with an optional required marker and help icon.
class LabelWithHelp extends StatelessWidget {
  final String text;
  final String? help;
  final bool required;
  final TextStyle? style;

  const LabelWithHelp(
    this.text, {
    super.key,
    this.help,
    this.required = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(child: EllipsisText(required ? '$text *' : text, style: style)),
      if (help != null) ...[
        const SizedBox(width: AppSpacing.tight),
        HelpIcon(help!),
      ],
    ],
  );
}

/// The help icon at the end of a field, beside any other suffix icon. A
/// field's floating label receives no pointer events, so help lives here.
Widget fieldSuffix(String help, [Widget? other]) => Padding(
  padding: const EdgeInsets.only(right: AppSpacing.heading),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (other != null) ...[other, const SizedBox(width: AppSpacing.tight)],
      HelpIcon(help),
    ],
  ),
);

/// The standard field decoration: label with required marker, and a help
/// icon at the end of the field.
InputDecoration fieldDecoration({
  required String label,
  required String help,
  bool required = false,
  String? hint,
  String? hintText,
  String? suffixText,
  String? prefixText,
  Widget? suffixIcon,
  String? helperText,
  String? counterText,
}) => InputDecoration(
  label: LabelWithHelp(label, required: required),
  hintText: hint ?? hintText,
  suffixText: suffixText,
  prefixText: prefixText,
  suffixIcon: fieldSuffix(help, suffixIcon),
  suffixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 32),
  helperText: helperText,
  counterText: counterText,
);

/// A checkbox row with the control in front and a help icon.
class HelpCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String title;
  final String help;
  final String? subtitle;

  const HelpCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    required this.help,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) => CheckboxListTile(
    value: value,
    onChanged: onChanged == null ? null : (v) => onChanged!(v ?? false),
    title: LabelWithHelp(title, help: help),
    subtitle: subtitle == null ? null : Text(subtitle!),
    controlAffinity: ListTileControlAffinity.leading,
    contentPadding: EdgeInsets.zero,
  );
}
