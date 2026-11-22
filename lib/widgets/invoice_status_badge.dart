import 'package:flutter/material.dart';
import 'package:florin/l10n/app_localizations.dart';
import '../db/database.dart';
import '../l10n/labels.dart';
import '../services/domain.dart';
import '../theme/app_theme.dart';
import 'tone_badge.dart';

class InvoiceStatusBadge extends StatelessWidget {
  final Invoice invoice;

  const InvoiceStatusBadge(this.invoice, {super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    if (invoice.isOverdue) {
      return ToneBadge(
        label: l.invoiceStatusOverdue,
        color: context.colors.danger,
      );
    }
    return ToneBadge(
      label: invoice.status.label(l),
      color: switch (invoice.status) {
        InvoiceStatus.draft => Theme.of(context).colorScheme.outline,
        InvoiceStatus.sent => Theme.of(context).colorScheme.primary,
        InvoiceStatus.paid => context.colors.income,
      },
    );
  }
}
