abstract class PrefsKeys {
  static const dbPath = 'db_path';

  static const businessName = 'business_name';
  static const businessVatNumber = 'business_vat_number';
  static const businessKvk = 'business_kvk';
  static const businessAddress = 'business_address';
  static const businessIban = 'business_iban';
  static const isStarter = 'is_starter';

  static const fiscalYear = 'fiscal_year';
  static const appLocale = 'app_locale';

  static String vatFiled(int year, String quarter) =>
      'vat_${year}_${quarter.toLowerCase()}_filed';
  static String vatPaid(int year, String quarter) =>
      'vat_${year}_${quarter.toLowerCase()}_paid';
}
