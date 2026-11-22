import 'tax_year_rules.dart';

/// The zero-emission reduction in force in each year a car may have been
/// first registered. For 60 months from the first day of the month after
/// registration, the reduction of the registration year applies
/// (Wet IB 2001 art. 3.20 lid 11). Sources: `docs/legal.md`.
const Map<int, CarReduction> carReductionByRegistrationYear = {
  2021: CarReduction(0.10, 400000),
  2022: CarReduction(0.06, 210000),
  2023: CarReduction(0.06, 180000),
  2024: CarReduction(0.06, 180000),
  2025: CarReduction(0.05, 150000),
};
