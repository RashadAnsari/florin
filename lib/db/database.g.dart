// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TaxParamsTable extends TaxParams
    with TableInfo<$TaxParamsTable, TaxParam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaxParamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _zelfstandigenaftrekMeta =
      const VerificationMeta('zelfstandigenaftrek');
  @override
  late final GeneratedColumn<int> zelfstandigenaftrek = GeneratedColumn<int>(
    'zelfstandigenaftrek',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startersaftrekMeta = const VerificationMeta(
    'startersaftrek',
  );
  @override
  late final GeneratedColumn<int> startersaftrek = GeneratedColumn<int>(
    'startersaftrek',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mkbWinstvrijstellingPctMeta =
      const VerificationMeta('mkbWinstvrijstellingPct');
  @override
  late final GeneratedColumn<double> mkbWinstvrijstellingPct =
      GeneratedColumn<double>(
        'mkb_winstvrijstelling_pct',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _bracket1RateMeta = const VerificationMeta(
    'bracket1Rate',
  );
  @override
  late final GeneratedColumn<double> bracket1Rate = GeneratedColumn<double>(
    'bracket1_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bracket1ThresholdMeta = const VerificationMeta(
    'bracket1Threshold',
  );
  @override
  late final GeneratedColumn<int> bracket1Threshold = GeneratedColumn<int>(
    'bracket1_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bracket2RateMeta = const VerificationMeta(
    'bracket2Rate',
  );
  @override
  late final GeneratedColumn<double> bracket2Rate = GeneratedColumn<double>(
    'bracket2_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bracket2ThresholdMeta = const VerificationMeta(
    'bracket2Threshold',
  );
  @override
  late final GeneratedColumn<int> bracket2Threshold = GeneratedColumn<int>(
    'bracket2_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bracket3RateMeta = const VerificationMeta(
    'bracket3Rate',
  );
  @override
  late final GeneratedColumn<double> bracket3Rate = GeneratedColumn<double>(
    'bracket3_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _algHeffingskortingMaxMeta =
      const VerificationMeta('algHeffingskortingMax');
  @override
  late final GeneratedColumn<int> algHeffingskortingMax = GeneratedColumn<int>(
    'alg_heffingskorting_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arbeidskortingMaxMeta = const VerificationMeta(
    'arbeidskortingMax',
  );
  @override
  late final GeneratedColumn<int> arbeidskortingMax = GeneratedColumn<int>(
    'arbeidskorting_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _zvwRateMeta = const VerificationMeta(
    'zvwRate',
  );
  @override
  late final GeneratedColumn<double> zvwRate = GeneratedColumn<double>(
    'zvw_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _zvwMaxMeta = const VerificationMeta('zvwMax');
  @override
  late final GeneratedColumn<int> zvwMax = GeneratedColumn<int>(
    'zvw_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mixedCostsThresholdMeta =
      const VerificationMeta('mixedCostsThreshold');
  @override
  late final GeneratedColumn<int> mixedCostsThreshold = GeneratedColumn<int>(
    'mixed_costs_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mixedCosts80PctMeta = const VerificationMeta(
    'mixedCosts80Pct',
  );
  @override
  late final GeneratedColumn<double> mixedCosts80Pct = GeneratedColumn<double>(
    'mixed_costs80_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jaarruimtePctMeta = const VerificationMeta(
    'jaarruimtePct',
  );
  @override
  late final GeneratedColumn<double> jaarruimtePct = GeneratedColumn<double>(
    'jaarruimte_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jaarruimteMaxMeta = const VerificationMeta(
    'jaarruimteMax',
  );
  @override
  late final GeneratedColumn<int> jaarruimteMax = GeneratedColumn<int>(
    'jaarruimte_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aowFranchiseMeta = const VerificationMeta(
    'aowFranchise',
  );
  @override
  late final GeneratedColumn<int> aowFranchise = GeneratedColumn<int>(
    'aow_franchise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reserveringsruimteMaxMeta =
      const VerificationMeta('reserveringsruimteMax');
  @override
  late final GeneratedColumn<int> reserveringsruimteMax = GeneratedColumn<int>(
    'reserveringsruimte_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _factorAMultiplierMeta = const VerificationMeta(
    'factorAMultiplier',
  );
  @override
  late final GeneratedColumn<double> factorAMultiplier =
      GeneratedColumn<double>(
        'factor_a_multiplier',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _kiaLowerThresholdMeta = const VerificationMeta(
    'kiaLowerThreshold',
  );
  @override
  late final GeneratedColumn<int> kiaLowerThreshold = GeneratedColumn<int>(
    'kia_lower_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kiaUpperThresholdMeta = const VerificationMeta(
    'kiaUpperThreshold',
  );
  @override
  late final GeneratedColumn<int> kiaUpperThreshold = GeneratedColumn<int>(
    'kia_upper_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kiaFlatThresholdMeta = const VerificationMeta(
    'kiaFlatThreshold',
  );
  @override
  late final GeneratedColumn<int> kiaFlatThreshold = GeneratedColumn<int>(
    'kia_flat_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kiaRateMeta = const VerificationMeta(
    'kiaRate',
  );
  @override
  late final GeneratedColumn<double> kiaRate = GeneratedColumn<double>(
    'kia_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kiaFlatAmountMeta = const VerificationMeta(
    'kiaFlatAmount',
  );
  @override
  late final GeneratedColumn<int> kiaFlatAmount = GeneratedColumn<int>(
    'kia_flat_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mileageRatePerKmMeta = const VerificationMeta(
    'mileageRatePerKm',
  );
  @override
  late final GeneratedColumn<double> mileageRatePerKm = GeneratedColumn<double>(
    'mileage_rate_per_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _korThresholdMeta = const VerificationMeta(
    'korThreshold',
  );
  @override
  late final GeneratedColumn<int> korThreshold = GeneratedColumn<int>(
    'kor_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ossThresholdMeta = const VerificationMeta(
    'ossThreshold',
  );
  @override
  late final GeneratedColumn<int> ossThreshold = GeneratedColumn<int>(
    'oss_threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _belastingrentePctMeta = const VerificationMeta(
    'belastingrentePct',
  );
  @override
  late final GeneratedColumn<double> belastingrentePct =
      GeneratedColumn<double>(
        'belastingrente_pct',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    year,
    zelfstandigenaftrek,
    startersaftrek,
    mkbWinstvrijstellingPct,
    bracket1Rate,
    bracket1Threshold,
    bracket2Rate,
    bracket2Threshold,
    bracket3Rate,
    algHeffingskortingMax,
    arbeidskortingMax,
    zvwRate,
    zvwMax,
    mixedCostsThreshold,
    mixedCosts80Pct,
    jaarruimtePct,
    jaarruimteMax,
    aowFranchise,
    reserveringsruimteMax,
    factorAMultiplier,
    kiaLowerThreshold,
    kiaUpperThreshold,
    kiaFlatThreshold,
    kiaRate,
    kiaFlatAmount,
    mileageRatePerKm,
    korThreshold,
    ossThreshold,
    belastingrentePct,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tax_params';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaxParam> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    if (data.containsKey('zelfstandigenaftrek')) {
      context.handle(
        _zelfstandigenaftrekMeta,
        zelfstandigenaftrek.isAcceptableOrUnknown(
          data['zelfstandigenaftrek']!,
          _zelfstandigenaftrekMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_zelfstandigenaftrekMeta);
    }
    if (data.containsKey('startersaftrek')) {
      context.handle(
        _startersaftrekMeta,
        startersaftrek.isAcceptableOrUnknown(
          data['startersaftrek']!,
          _startersaftrekMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startersaftrekMeta);
    }
    if (data.containsKey('mkb_winstvrijstelling_pct')) {
      context.handle(
        _mkbWinstvrijstellingPctMeta,
        mkbWinstvrijstellingPct.isAcceptableOrUnknown(
          data['mkb_winstvrijstelling_pct']!,
          _mkbWinstvrijstellingPctMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mkbWinstvrijstellingPctMeta);
    }
    if (data.containsKey('bracket1_rate')) {
      context.handle(
        _bracket1RateMeta,
        bracket1Rate.isAcceptableOrUnknown(
          data['bracket1_rate']!,
          _bracket1RateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bracket1RateMeta);
    }
    if (data.containsKey('bracket1_threshold')) {
      context.handle(
        _bracket1ThresholdMeta,
        bracket1Threshold.isAcceptableOrUnknown(
          data['bracket1_threshold']!,
          _bracket1ThresholdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bracket1ThresholdMeta);
    }
    if (data.containsKey('bracket2_rate')) {
      context.handle(
        _bracket2RateMeta,
        bracket2Rate.isAcceptableOrUnknown(
          data['bracket2_rate']!,
          _bracket2RateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bracket2RateMeta);
    }
    if (data.containsKey('bracket2_threshold')) {
      context.handle(
        _bracket2ThresholdMeta,
        bracket2Threshold.isAcceptableOrUnknown(
          data['bracket2_threshold']!,
          _bracket2ThresholdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bracket2ThresholdMeta);
    }
    if (data.containsKey('bracket3_rate')) {
      context.handle(
        _bracket3RateMeta,
        bracket3Rate.isAcceptableOrUnknown(
          data['bracket3_rate']!,
          _bracket3RateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bracket3RateMeta);
    }
    if (data.containsKey('alg_heffingskorting_max')) {
      context.handle(
        _algHeffingskortingMaxMeta,
        algHeffingskortingMax.isAcceptableOrUnknown(
          data['alg_heffingskorting_max']!,
          _algHeffingskortingMaxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_algHeffingskortingMaxMeta);
    }
    if (data.containsKey('arbeidskorting_max')) {
      context.handle(
        _arbeidskortingMaxMeta,
        arbeidskortingMax.isAcceptableOrUnknown(
          data['arbeidskorting_max']!,
          _arbeidskortingMaxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arbeidskortingMaxMeta);
    }
    if (data.containsKey('zvw_rate')) {
      context.handle(
        _zvwRateMeta,
        zvwRate.isAcceptableOrUnknown(data['zvw_rate']!, _zvwRateMeta),
      );
    } else if (isInserting) {
      context.missing(_zvwRateMeta);
    }
    if (data.containsKey('zvw_max')) {
      context.handle(
        _zvwMaxMeta,
        zvwMax.isAcceptableOrUnknown(data['zvw_max']!, _zvwMaxMeta),
      );
    } else if (isInserting) {
      context.missing(_zvwMaxMeta);
    }
    if (data.containsKey('mixed_costs_threshold')) {
      context.handle(
        _mixedCostsThresholdMeta,
        mixedCostsThreshold.isAcceptableOrUnknown(
          data['mixed_costs_threshold']!,
          _mixedCostsThresholdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mixedCostsThresholdMeta);
    }
    if (data.containsKey('mixed_costs80_pct')) {
      context.handle(
        _mixedCosts80PctMeta,
        mixedCosts80Pct.isAcceptableOrUnknown(
          data['mixed_costs80_pct']!,
          _mixedCosts80PctMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mixedCosts80PctMeta);
    }
    if (data.containsKey('jaarruimte_pct')) {
      context.handle(
        _jaarruimtePctMeta,
        jaarruimtePct.isAcceptableOrUnknown(
          data['jaarruimte_pct']!,
          _jaarruimtePctMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_jaarruimtePctMeta);
    }
    if (data.containsKey('jaarruimte_max')) {
      context.handle(
        _jaarruimteMaxMeta,
        jaarruimteMax.isAcceptableOrUnknown(
          data['jaarruimte_max']!,
          _jaarruimteMaxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_jaarruimteMaxMeta);
    }
    if (data.containsKey('aow_franchise')) {
      context.handle(
        _aowFranchiseMeta,
        aowFranchise.isAcceptableOrUnknown(
          data['aow_franchise']!,
          _aowFranchiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aowFranchiseMeta);
    }
    if (data.containsKey('reserveringsruimte_max')) {
      context.handle(
        _reserveringsruimteMaxMeta,
        reserveringsruimteMax.isAcceptableOrUnknown(
          data['reserveringsruimte_max']!,
          _reserveringsruimteMaxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reserveringsruimteMaxMeta);
    }
    if (data.containsKey('factor_a_multiplier')) {
      context.handle(
        _factorAMultiplierMeta,
        factorAMultiplier.isAcceptableOrUnknown(
          data['factor_a_multiplier']!,
          _factorAMultiplierMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_factorAMultiplierMeta);
    }
    if (data.containsKey('kia_lower_threshold')) {
      context.handle(
        _kiaLowerThresholdMeta,
        kiaLowerThreshold.isAcceptableOrUnknown(
          data['kia_lower_threshold']!,
          _kiaLowerThresholdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kiaLowerThresholdMeta);
    }
    if (data.containsKey('kia_upper_threshold')) {
      context.handle(
        _kiaUpperThresholdMeta,
        kiaUpperThreshold.isAcceptableOrUnknown(
          data['kia_upper_threshold']!,
          _kiaUpperThresholdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kiaUpperThresholdMeta);
    }
    if (data.containsKey('kia_flat_threshold')) {
      context.handle(
        _kiaFlatThresholdMeta,
        kiaFlatThreshold.isAcceptableOrUnknown(
          data['kia_flat_threshold']!,
          _kiaFlatThresholdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kiaFlatThresholdMeta);
    }
    if (data.containsKey('kia_rate')) {
      context.handle(
        _kiaRateMeta,
        kiaRate.isAcceptableOrUnknown(data['kia_rate']!, _kiaRateMeta),
      );
    } else if (isInserting) {
      context.missing(_kiaRateMeta);
    }
    if (data.containsKey('kia_flat_amount')) {
      context.handle(
        _kiaFlatAmountMeta,
        kiaFlatAmount.isAcceptableOrUnknown(
          data['kia_flat_amount']!,
          _kiaFlatAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kiaFlatAmountMeta);
    }
    if (data.containsKey('mileage_rate_per_km')) {
      context.handle(
        _mileageRatePerKmMeta,
        mileageRatePerKm.isAcceptableOrUnknown(
          data['mileage_rate_per_km']!,
          _mileageRatePerKmMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mileageRatePerKmMeta);
    }
    if (data.containsKey('kor_threshold')) {
      context.handle(
        _korThresholdMeta,
        korThreshold.isAcceptableOrUnknown(
          data['kor_threshold']!,
          _korThresholdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_korThresholdMeta);
    }
    if (data.containsKey('oss_threshold')) {
      context.handle(
        _ossThresholdMeta,
        ossThreshold.isAcceptableOrUnknown(
          data['oss_threshold']!,
          _ossThresholdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ossThresholdMeta);
    }
    if (data.containsKey('belastingrente_pct')) {
      context.handle(
        _belastingrentePctMeta,
        belastingrentePct.isAcceptableOrUnknown(
          data['belastingrente_pct']!,
          _belastingrentePctMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_belastingrentePctMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {year};
  @override
  TaxParam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaxParam(
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      zelfstandigenaftrek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}zelfstandigenaftrek'],
      )!,
      startersaftrek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}startersaftrek'],
      )!,
      mkbWinstvrijstellingPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mkb_winstvrijstelling_pct'],
      )!,
      bracket1Rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bracket1_rate'],
      )!,
      bracket1Threshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bracket1_threshold'],
      )!,
      bracket2Rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bracket2_rate'],
      )!,
      bracket2Threshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bracket2_threshold'],
      )!,
      bracket3Rate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bracket3_rate'],
      )!,
      algHeffingskortingMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alg_heffingskorting_max'],
      )!,
      arbeidskortingMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}arbeidskorting_max'],
      )!,
      zvwRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}zvw_rate'],
      )!,
      zvwMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}zvw_max'],
      )!,
      mixedCostsThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mixed_costs_threshold'],
      )!,
      mixedCosts80Pct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mixed_costs80_pct'],
      )!,
      jaarruimtePct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}jaarruimte_pct'],
      )!,
      jaarruimteMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jaarruimte_max'],
      )!,
      aowFranchise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}aow_franchise'],
      )!,
      reserveringsruimteMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reserveringsruimte_max'],
      )!,
      factorAMultiplier: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}factor_a_multiplier'],
      )!,
      kiaLowerThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kia_lower_threshold'],
      )!,
      kiaUpperThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kia_upper_threshold'],
      )!,
      kiaFlatThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kia_flat_threshold'],
      )!,
      kiaRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kia_rate'],
      )!,
      kiaFlatAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kia_flat_amount'],
      )!,
      mileageRatePerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mileage_rate_per_km'],
      )!,
      korThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kor_threshold'],
      )!,
      ossThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}oss_threshold'],
      )!,
      belastingrentePct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}belastingrente_pct'],
      )!,
    );
  }

  @override
  $TaxParamsTable createAlias(String alias) {
    return $TaxParamsTable(attachedDatabase, alias);
  }
}

class TaxParam extends DataClass implements Insertable<TaxParam> {
  final int year;
  final int zelfstandigenaftrek;
  final int startersaftrek;
  final double mkbWinstvrijstellingPct;
  final double bracket1Rate;
  final int bracket1Threshold;
  final double bracket2Rate;
  final int bracket2Threshold;
  final double bracket3Rate;
  final int algHeffingskortingMax;
  final int arbeidskortingMax;
  final double zvwRate;
  final int zvwMax;
  final int mixedCostsThreshold;
  final double mixedCosts80Pct;
  final double jaarruimtePct;
  final int jaarruimteMax;
  final int aowFranchise;
  final int reserveringsruimteMax;
  final double factorAMultiplier;
  final int kiaLowerThreshold;
  final int kiaUpperThreshold;
  final int kiaFlatThreshold;
  final double kiaRate;
  final int kiaFlatAmount;
  final double mileageRatePerKm;
  final int korThreshold;
  final int ossThreshold;
  final double belastingrentePct;
  const TaxParam({
    required this.year,
    required this.zelfstandigenaftrek,
    required this.startersaftrek,
    required this.mkbWinstvrijstellingPct,
    required this.bracket1Rate,
    required this.bracket1Threshold,
    required this.bracket2Rate,
    required this.bracket2Threshold,
    required this.bracket3Rate,
    required this.algHeffingskortingMax,
    required this.arbeidskortingMax,
    required this.zvwRate,
    required this.zvwMax,
    required this.mixedCostsThreshold,
    required this.mixedCosts80Pct,
    required this.jaarruimtePct,
    required this.jaarruimteMax,
    required this.aowFranchise,
    required this.reserveringsruimteMax,
    required this.factorAMultiplier,
    required this.kiaLowerThreshold,
    required this.kiaUpperThreshold,
    required this.kiaFlatThreshold,
    required this.kiaRate,
    required this.kiaFlatAmount,
    required this.mileageRatePerKm,
    required this.korThreshold,
    required this.ossThreshold,
    required this.belastingrentePct,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['year'] = Variable<int>(year);
    map['zelfstandigenaftrek'] = Variable<int>(zelfstandigenaftrek);
    map['startersaftrek'] = Variable<int>(startersaftrek);
    map['mkb_winstvrijstelling_pct'] = Variable<double>(
      mkbWinstvrijstellingPct,
    );
    map['bracket1_rate'] = Variable<double>(bracket1Rate);
    map['bracket1_threshold'] = Variable<int>(bracket1Threshold);
    map['bracket2_rate'] = Variable<double>(bracket2Rate);
    map['bracket2_threshold'] = Variable<int>(bracket2Threshold);
    map['bracket3_rate'] = Variable<double>(bracket3Rate);
    map['alg_heffingskorting_max'] = Variable<int>(algHeffingskortingMax);
    map['arbeidskorting_max'] = Variable<int>(arbeidskortingMax);
    map['zvw_rate'] = Variable<double>(zvwRate);
    map['zvw_max'] = Variable<int>(zvwMax);
    map['mixed_costs_threshold'] = Variable<int>(mixedCostsThreshold);
    map['mixed_costs80_pct'] = Variable<double>(mixedCosts80Pct);
    map['jaarruimte_pct'] = Variable<double>(jaarruimtePct);
    map['jaarruimte_max'] = Variable<int>(jaarruimteMax);
    map['aow_franchise'] = Variable<int>(aowFranchise);
    map['reserveringsruimte_max'] = Variable<int>(reserveringsruimteMax);
    map['factor_a_multiplier'] = Variable<double>(factorAMultiplier);
    map['kia_lower_threshold'] = Variable<int>(kiaLowerThreshold);
    map['kia_upper_threshold'] = Variable<int>(kiaUpperThreshold);
    map['kia_flat_threshold'] = Variable<int>(kiaFlatThreshold);
    map['kia_rate'] = Variable<double>(kiaRate);
    map['kia_flat_amount'] = Variable<int>(kiaFlatAmount);
    map['mileage_rate_per_km'] = Variable<double>(mileageRatePerKm);
    map['kor_threshold'] = Variable<int>(korThreshold);
    map['oss_threshold'] = Variable<int>(ossThreshold);
    map['belastingrente_pct'] = Variable<double>(belastingrentePct);
    return map;
  }

  TaxParamsCompanion toCompanion(bool nullToAbsent) {
    return TaxParamsCompanion(
      year: Value(year),
      zelfstandigenaftrek: Value(zelfstandigenaftrek),
      startersaftrek: Value(startersaftrek),
      mkbWinstvrijstellingPct: Value(mkbWinstvrijstellingPct),
      bracket1Rate: Value(bracket1Rate),
      bracket1Threshold: Value(bracket1Threshold),
      bracket2Rate: Value(bracket2Rate),
      bracket2Threshold: Value(bracket2Threshold),
      bracket3Rate: Value(bracket3Rate),
      algHeffingskortingMax: Value(algHeffingskortingMax),
      arbeidskortingMax: Value(arbeidskortingMax),
      zvwRate: Value(zvwRate),
      zvwMax: Value(zvwMax),
      mixedCostsThreshold: Value(mixedCostsThreshold),
      mixedCosts80Pct: Value(mixedCosts80Pct),
      jaarruimtePct: Value(jaarruimtePct),
      jaarruimteMax: Value(jaarruimteMax),
      aowFranchise: Value(aowFranchise),
      reserveringsruimteMax: Value(reserveringsruimteMax),
      factorAMultiplier: Value(factorAMultiplier),
      kiaLowerThreshold: Value(kiaLowerThreshold),
      kiaUpperThreshold: Value(kiaUpperThreshold),
      kiaFlatThreshold: Value(kiaFlatThreshold),
      kiaRate: Value(kiaRate),
      kiaFlatAmount: Value(kiaFlatAmount),
      mileageRatePerKm: Value(mileageRatePerKm),
      korThreshold: Value(korThreshold),
      ossThreshold: Value(ossThreshold),
      belastingrentePct: Value(belastingrentePct),
    );
  }

  factory TaxParam.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaxParam(
      year: serializer.fromJson<int>(json['year']),
      zelfstandigenaftrek: serializer.fromJson<int>(
        json['zelfstandigenaftrek'],
      ),
      startersaftrek: serializer.fromJson<int>(json['startersaftrek']),
      mkbWinstvrijstellingPct: serializer.fromJson<double>(
        json['mkbWinstvrijstellingPct'],
      ),
      bracket1Rate: serializer.fromJson<double>(json['bracket1Rate']),
      bracket1Threshold: serializer.fromJson<int>(json['bracket1Threshold']),
      bracket2Rate: serializer.fromJson<double>(json['bracket2Rate']),
      bracket2Threshold: serializer.fromJson<int>(json['bracket2Threshold']),
      bracket3Rate: serializer.fromJson<double>(json['bracket3Rate']),
      algHeffingskortingMax: serializer.fromJson<int>(
        json['algHeffingskortingMax'],
      ),
      arbeidskortingMax: serializer.fromJson<int>(json['arbeidskortingMax']),
      zvwRate: serializer.fromJson<double>(json['zvwRate']),
      zvwMax: serializer.fromJson<int>(json['zvwMax']),
      mixedCostsThreshold: serializer.fromJson<int>(
        json['mixedCostsThreshold'],
      ),
      mixedCosts80Pct: serializer.fromJson<double>(json['mixedCosts80Pct']),
      jaarruimtePct: serializer.fromJson<double>(json['jaarruimtePct']),
      jaarruimteMax: serializer.fromJson<int>(json['jaarruimteMax']),
      aowFranchise: serializer.fromJson<int>(json['aowFranchise']),
      reserveringsruimteMax: serializer.fromJson<int>(
        json['reserveringsruimteMax'],
      ),
      factorAMultiplier: serializer.fromJson<double>(json['factorAMultiplier']),
      kiaLowerThreshold: serializer.fromJson<int>(json['kiaLowerThreshold']),
      kiaUpperThreshold: serializer.fromJson<int>(json['kiaUpperThreshold']),
      kiaFlatThreshold: serializer.fromJson<int>(json['kiaFlatThreshold']),
      kiaRate: serializer.fromJson<double>(json['kiaRate']),
      kiaFlatAmount: serializer.fromJson<int>(json['kiaFlatAmount']),
      mileageRatePerKm: serializer.fromJson<double>(json['mileageRatePerKm']),
      korThreshold: serializer.fromJson<int>(json['korThreshold']),
      ossThreshold: serializer.fromJson<int>(json['ossThreshold']),
      belastingrentePct: serializer.fromJson<double>(json['belastingrentePct']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'year': serializer.toJson<int>(year),
      'zelfstandigenaftrek': serializer.toJson<int>(zelfstandigenaftrek),
      'startersaftrek': serializer.toJson<int>(startersaftrek),
      'mkbWinstvrijstellingPct': serializer.toJson<double>(
        mkbWinstvrijstellingPct,
      ),
      'bracket1Rate': serializer.toJson<double>(bracket1Rate),
      'bracket1Threshold': serializer.toJson<int>(bracket1Threshold),
      'bracket2Rate': serializer.toJson<double>(bracket2Rate),
      'bracket2Threshold': serializer.toJson<int>(bracket2Threshold),
      'bracket3Rate': serializer.toJson<double>(bracket3Rate),
      'algHeffingskortingMax': serializer.toJson<int>(algHeffingskortingMax),
      'arbeidskortingMax': serializer.toJson<int>(arbeidskortingMax),
      'zvwRate': serializer.toJson<double>(zvwRate),
      'zvwMax': serializer.toJson<int>(zvwMax),
      'mixedCostsThreshold': serializer.toJson<int>(mixedCostsThreshold),
      'mixedCosts80Pct': serializer.toJson<double>(mixedCosts80Pct),
      'jaarruimtePct': serializer.toJson<double>(jaarruimtePct),
      'jaarruimteMax': serializer.toJson<int>(jaarruimteMax),
      'aowFranchise': serializer.toJson<int>(aowFranchise),
      'reserveringsruimteMax': serializer.toJson<int>(reserveringsruimteMax),
      'factorAMultiplier': serializer.toJson<double>(factorAMultiplier),
      'kiaLowerThreshold': serializer.toJson<int>(kiaLowerThreshold),
      'kiaUpperThreshold': serializer.toJson<int>(kiaUpperThreshold),
      'kiaFlatThreshold': serializer.toJson<int>(kiaFlatThreshold),
      'kiaRate': serializer.toJson<double>(kiaRate),
      'kiaFlatAmount': serializer.toJson<int>(kiaFlatAmount),
      'mileageRatePerKm': serializer.toJson<double>(mileageRatePerKm),
      'korThreshold': serializer.toJson<int>(korThreshold),
      'ossThreshold': serializer.toJson<int>(ossThreshold),
      'belastingrentePct': serializer.toJson<double>(belastingrentePct),
    };
  }

  TaxParam copyWith({
    int? year,
    int? zelfstandigenaftrek,
    int? startersaftrek,
    double? mkbWinstvrijstellingPct,
    double? bracket1Rate,
    int? bracket1Threshold,
    double? bracket2Rate,
    int? bracket2Threshold,
    double? bracket3Rate,
    int? algHeffingskortingMax,
    int? arbeidskortingMax,
    double? zvwRate,
    int? zvwMax,
    int? mixedCostsThreshold,
    double? mixedCosts80Pct,
    double? jaarruimtePct,
    int? jaarruimteMax,
    int? aowFranchise,
    int? reserveringsruimteMax,
    double? factorAMultiplier,
    int? kiaLowerThreshold,
    int? kiaUpperThreshold,
    int? kiaFlatThreshold,
    double? kiaRate,
    int? kiaFlatAmount,
    double? mileageRatePerKm,
    int? korThreshold,
    int? ossThreshold,
    double? belastingrentePct,
  }) => TaxParam(
    year: year ?? this.year,
    zelfstandigenaftrek: zelfstandigenaftrek ?? this.zelfstandigenaftrek,
    startersaftrek: startersaftrek ?? this.startersaftrek,
    mkbWinstvrijstellingPct:
        mkbWinstvrijstellingPct ?? this.mkbWinstvrijstellingPct,
    bracket1Rate: bracket1Rate ?? this.bracket1Rate,
    bracket1Threshold: bracket1Threshold ?? this.bracket1Threshold,
    bracket2Rate: bracket2Rate ?? this.bracket2Rate,
    bracket2Threshold: bracket2Threshold ?? this.bracket2Threshold,
    bracket3Rate: bracket3Rate ?? this.bracket3Rate,
    algHeffingskortingMax: algHeffingskortingMax ?? this.algHeffingskortingMax,
    arbeidskortingMax: arbeidskortingMax ?? this.arbeidskortingMax,
    zvwRate: zvwRate ?? this.zvwRate,
    zvwMax: zvwMax ?? this.zvwMax,
    mixedCostsThreshold: mixedCostsThreshold ?? this.mixedCostsThreshold,
    mixedCosts80Pct: mixedCosts80Pct ?? this.mixedCosts80Pct,
    jaarruimtePct: jaarruimtePct ?? this.jaarruimtePct,
    jaarruimteMax: jaarruimteMax ?? this.jaarruimteMax,
    aowFranchise: aowFranchise ?? this.aowFranchise,
    reserveringsruimteMax: reserveringsruimteMax ?? this.reserveringsruimteMax,
    factorAMultiplier: factorAMultiplier ?? this.factorAMultiplier,
    kiaLowerThreshold: kiaLowerThreshold ?? this.kiaLowerThreshold,
    kiaUpperThreshold: kiaUpperThreshold ?? this.kiaUpperThreshold,
    kiaFlatThreshold: kiaFlatThreshold ?? this.kiaFlatThreshold,
    kiaRate: kiaRate ?? this.kiaRate,
    kiaFlatAmount: kiaFlatAmount ?? this.kiaFlatAmount,
    mileageRatePerKm: mileageRatePerKm ?? this.mileageRatePerKm,
    korThreshold: korThreshold ?? this.korThreshold,
    ossThreshold: ossThreshold ?? this.ossThreshold,
    belastingrentePct: belastingrentePct ?? this.belastingrentePct,
  );
  TaxParam copyWithCompanion(TaxParamsCompanion data) {
    return TaxParam(
      year: data.year.present ? data.year.value : this.year,
      zelfstandigenaftrek: data.zelfstandigenaftrek.present
          ? data.zelfstandigenaftrek.value
          : this.zelfstandigenaftrek,
      startersaftrek: data.startersaftrek.present
          ? data.startersaftrek.value
          : this.startersaftrek,
      mkbWinstvrijstellingPct: data.mkbWinstvrijstellingPct.present
          ? data.mkbWinstvrijstellingPct.value
          : this.mkbWinstvrijstellingPct,
      bracket1Rate: data.bracket1Rate.present
          ? data.bracket1Rate.value
          : this.bracket1Rate,
      bracket1Threshold: data.bracket1Threshold.present
          ? data.bracket1Threshold.value
          : this.bracket1Threshold,
      bracket2Rate: data.bracket2Rate.present
          ? data.bracket2Rate.value
          : this.bracket2Rate,
      bracket2Threshold: data.bracket2Threshold.present
          ? data.bracket2Threshold.value
          : this.bracket2Threshold,
      bracket3Rate: data.bracket3Rate.present
          ? data.bracket3Rate.value
          : this.bracket3Rate,
      algHeffingskortingMax: data.algHeffingskortingMax.present
          ? data.algHeffingskortingMax.value
          : this.algHeffingskortingMax,
      arbeidskortingMax: data.arbeidskortingMax.present
          ? data.arbeidskortingMax.value
          : this.arbeidskortingMax,
      zvwRate: data.zvwRate.present ? data.zvwRate.value : this.zvwRate,
      zvwMax: data.zvwMax.present ? data.zvwMax.value : this.zvwMax,
      mixedCostsThreshold: data.mixedCostsThreshold.present
          ? data.mixedCostsThreshold.value
          : this.mixedCostsThreshold,
      mixedCosts80Pct: data.mixedCosts80Pct.present
          ? data.mixedCosts80Pct.value
          : this.mixedCosts80Pct,
      jaarruimtePct: data.jaarruimtePct.present
          ? data.jaarruimtePct.value
          : this.jaarruimtePct,
      jaarruimteMax: data.jaarruimteMax.present
          ? data.jaarruimteMax.value
          : this.jaarruimteMax,
      aowFranchise: data.aowFranchise.present
          ? data.aowFranchise.value
          : this.aowFranchise,
      reserveringsruimteMax: data.reserveringsruimteMax.present
          ? data.reserveringsruimteMax.value
          : this.reserveringsruimteMax,
      factorAMultiplier: data.factorAMultiplier.present
          ? data.factorAMultiplier.value
          : this.factorAMultiplier,
      kiaLowerThreshold: data.kiaLowerThreshold.present
          ? data.kiaLowerThreshold.value
          : this.kiaLowerThreshold,
      kiaUpperThreshold: data.kiaUpperThreshold.present
          ? data.kiaUpperThreshold.value
          : this.kiaUpperThreshold,
      kiaFlatThreshold: data.kiaFlatThreshold.present
          ? data.kiaFlatThreshold.value
          : this.kiaFlatThreshold,
      kiaRate: data.kiaRate.present ? data.kiaRate.value : this.kiaRate,
      kiaFlatAmount: data.kiaFlatAmount.present
          ? data.kiaFlatAmount.value
          : this.kiaFlatAmount,
      mileageRatePerKm: data.mileageRatePerKm.present
          ? data.mileageRatePerKm.value
          : this.mileageRatePerKm,
      korThreshold: data.korThreshold.present
          ? data.korThreshold.value
          : this.korThreshold,
      ossThreshold: data.ossThreshold.present
          ? data.ossThreshold.value
          : this.ossThreshold,
      belastingrentePct: data.belastingrentePct.present
          ? data.belastingrentePct.value
          : this.belastingrentePct,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaxParam(')
          ..write('year: $year, ')
          ..write('zelfstandigenaftrek: $zelfstandigenaftrek, ')
          ..write('startersaftrek: $startersaftrek, ')
          ..write('mkbWinstvrijstellingPct: $mkbWinstvrijstellingPct, ')
          ..write('bracket1Rate: $bracket1Rate, ')
          ..write('bracket1Threshold: $bracket1Threshold, ')
          ..write('bracket2Rate: $bracket2Rate, ')
          ..write('bracket2Threshold: $bracket2Threshold, ')
          ..write('bracket3Rate: $bracket3Rate, ')
          ..write('algHeffingskortingMax: $algHeffingskortingMax, ')
          ..write('arbeidskortingMax: $arbeidskortingMax, ')
          ..write('zvwRate: $zvwRate, ')
          ..write('zvwMax: $zvwMax, ')
          ..write('mixedCostsThreshold: $mixedCostsThreshold, ')
          ..write('mixedCosts80Pct: $mixedCosts80Pct, ')
          ..write('jaarruimtePct: $jaarruimtePct, ')
          ..write('jaarruimteMax: $jaarruimteMax, ')
          ..write('aowFranchise: $aowFranchise, ')
          ..write('reserveringsruimteMax: $reserveringsruimteMax, ')
          ..write('factorAMultiplier: $factorAMultiplier, ')
          ..write('kiaLowerThreshold: $kiaLowerThreshold, ')
          ..write('kiaUpperThreshold: $kiaUpperThreshold, ')
          ..write('kiaFlatThreshold: $kiaFlatThreshold, ')
          ..write('kiaRate: $kiaRate, ')
          ..write('kiaFlatAmount: $kiaFlatAmount, ')
          ..write('mileageRatePerKm: $mileageRatePerKm, ')
          ..write('korThreshold: $korThreshold, ')
          ..write('ossThreshold: $ossThreshold, ')
          ..write('belastingrentePct: $belastingrentePct')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    year,
    zelfstandigenaftrek,
    startersaftrek,
    mkbWinstvrijstellingPct,
    bracket1Rate,
    bracket1Threshold,
    bracket2Rate,
    bracket2Threshold,
    bracket3Rate,
    algHeffingskortingMax,
    arbeidskortingMax,
    zvwRate,
    zvwMax,
    mixedCostsThreshold,
    mixedCosts80Pct,
    jaarruimtePct,
    jaarruimteMax,
    aowFranchise,
    reserveringsruimteMax,
    factorAMultiplier,
    kiaLowerThreshold,
    kiaUpperThreshold,
    kiaFlatThreshold,
    kiaRate,
    kiaFlatAmount,
    mileageRatePerKm,
    korThreshold,
    ossThreshold,
    belastingrentePct,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaxParam &&
          other.year == this.year &&
          other.zelfstandigenaftrek == this.zelfstandigenaftrek &&
          other.startersaftrek == this.startersaftrek &&
          other.mkbWinstvrijstellingPct == this.mkbWinstvrijstellingPct &&
          other.bracket1Rate == this.bracket1Rate &&
          other.bracket1Threshold == this.bracket1Threshold &&
          other.bracket2Rate == this.bracket2Rate &&
          other.bracket2Threshold == this.bracket2Threshold &&
          other.bracket3Rate == this.bracket3Rate &&
          other.algHeffingskortingMax == this.algHeffingskortingMax &&
          other.arbeidskortingMax == this.arbeidskortingMax &&
          other.zvwRate == this.zvwRate &&
          other.zvwMax == this.zvwMax &&
          other.mixedCostsThreshold == this.mixedCostsThreshold &&
          other.mixedCosts80Pct == this.mixedCosts80Pct &&
          other.jaarruimtePct == this.jaarruimtePct &&
          other.jaarruimteMax == this.jaarruimteMax &&
          other.aowFranchise == this.aowFranchise &&
          other.reserveringsruimteMax == this.reserveringsruimteMax &&
          other.factorAMultiplier == this.factorAMultiplier &&
          other.kiaLowerThreshold == this.kiaLowerThreshold &&
          other.kiaUpperThreshold == this.kiaUpperThreshold &&
          other.kiaFlatThreshold == this.kiaFlatThreshold &&
          other.kiaRate == this.kiaRate &&
          other.kiaFlatAmount == this.kiaFlatAmount &&
          other.mileageRatePerKm == this.mileageRatePerKm &&
          other.korThreshold == this.korThreshold &&
          other.ossThreshold == this.ossThreshold &&
          other.belastingrentePct == this.belastingrentePct);
}

class TaxParamsCompanion extends UpdateCompanion<TaxParam> {
  final Value<int> year;
  final Value<int> zelfstandigenaftrek;
  final Value<int> startersaftrek;
  final Value<double> mkbWinstvrijstellingPct;
  final Value<double> bracket1Rate;
  final Value<int> bracket1Threshold;
  final Value<double> bracket2Rate;
  final Value<int> bracket2Threshold;
  final Value<double> bracket3Rate;
  final Value<int> algHeffingskortingMax;
  final Value<int> arbeidskortingMax;
  final Value<double> zvwRate;
  final Value<int> zvwMax;
  final Value<int> mixedCostsThreshold;
  final Value<double> mixedCosts80Pct;
  final Value<double> jaarruimtePct;
  final Value<int> jaarruimteMax;
  final Value<int> aowFranchise;
  final Value<int> reserveringsruimteMax;
  final Value<double> factorAMultiplier;
  final Value<int> kiaLowerThreshold;
  final Value<int> kiaUpperThreshold;
  final Value<int> kiaFlatThreshold;
  final Value<double> kiaRate;
  final Value<int> kiaFlatAmount;
  final Value<double> mileageRatePerKm;
  final Value<int> korThreshold;
  final Value<int> ossThreshold;
  final Value<double> belastingrentePct;
  const TaxParamsCompanion({
    this.year = const Value.absent(),
    this.zelfstandigenaftrek = const Value.absent(),
    this.startersaftrek = const Value.absent(),
    this.mkbWinstvrijstellingPct = const Value.absent(),
    this.bracket1Rate = const Value.absent(),
    this.bracket1Threshold = const Value.absent(),
    this.bracket2Rate = const Value.absent(),
    this.bracket2Threshold = const Value.absent(),
    this.bracket3Rate = const Value.absent(),
    this.algHeffingskortingMax = const Value.absent(),
    this.arbeidskortingMax = const Value.absent(),
    this.zvwRate = const Value.absent(),
    this.zvwMax = const Value.absent(),
    this.mixedCostsThreshold = const Value.absent(),
    this.mixedCosts80Pct = const Value.absent(),
    this.jaarruimtePct = const Value.absent(),
    this.jaarruimteMax = const Value.absent(),
    this.aowFranchise = const Value.absent(),
    this.reserveringsruimteMax = const Value.absent(),
    this.factorAMultiplier = const Value.absent(),
    this.kiaLowerThreshold = const Value.absent(),
    this.kiaUpperThreshold = const Value.absent(),
    this.kiaFlatThreshold = const Value.absent(),
    this.kiaRate = const Value.absent(),
    this.kiaFlatAmount = const Value.absent(),
    this.mileageRatePerKm = const Value.absent(),
    this.korThreshold = const Value.absent(),
    this.ossThreshold = const Value.absent(),
    this.belastingrentePct = const Value.absent(),
  });
  TaxParamsCompanion.insert({
    this.year = const Value.absent(),
    required int zelfstandigenaftrek,
    required int startersaftrek,
    required double mkbWinstvrijstellingPct,
    required double bracket1Rate,
    required int bracket1Threshold,
    required double bracket2Rate,
    required int bracket2Threshold,
    required double bracket3Rate,
    required int algHeffingskortingMax,
    required int arbeidskortingMax,
    required double zvwRate,
    required int zvwMax,
    required int mixedCostsThreshold,
    required double mixedCosts80Pct,
    required double jaarruimtePct,
    required int jaarruimteMax,
    required int aowFranchise,
    required int reserveringsruimteMax,
    required double factorAMultiplier,
    required int kiaLowerThreshold,
    required int kiaUpperThreshold,
    required int kiaFlatThreshold,
    required double kiaRate,
    required int kiaFlatAmount,
    required double mileageRatePerKm,
    required int korThreshold,
    required int ossThreshold,
    required double belastingrentePct,
  }) : zelfstandigenaftrek = Value(zelfstandigenaftrek),
       startersaftrek = Value(startersaftrek),
       mkbWinstvrijstellingPct = Value(mkbWinstvrijstellingPct),
       bracket1Rate = Value(bracket1Rate),
       bracket1Threshold = Value(bracket1Threshold),
       bracket2Rate = Value(bracket2Rate),
       bracket2Threshold = Value(bracket2Threshold),
       bracket3Rate = Value(bracket3Rate),
       algHeffingskortingMax = Value(algHeffingskortingMax),
       arbeidskortingMax = Value(arbeidskortingMax),
       zvwRate = Value(zvwRate),
       zvwMax = Value(zvwMax),
       mixedCostsThreshold = Value(mixedCostsThreshold),
       mixedCosts80Pct = Value(mixedCosts80Pct),
       jaarruimtePct = Value(jaarruimtePct),
       jaarruimteMax = Value(jaarruimteMax),
       aowFranchise = Value(aowFranchise),
       reserveringsruimteMax = Value(reserveringsruimteMax),
       factorAMultiplier = Value(factorAMultiplier),
       kiaLowerThreshold = Value(kiaLowerThreshold),
       kiaUpperThreshold = Value(kiaUpperThreshold),
       kiaFlatThreshold = Value(kiaFlatThreshold),
       kiaRate = Value(kiaRate),
       kiaFlatAmount = Value(kiaFlatAmount),
       mileageRatePerKm = Value(mileageRatePerKm),
       korThreshold = Value(korThreshold),
       ossThreshold = Value(ossThreshold),
       belastingrentePct = Value(belastingrentePct);
  static Insertable<TaxParam> custom({
    Expression<int>? year,
    Expression<int>? zelfstandigenaftrek,
    Expression<int>? startersaftrek,
    Expression<double>? mkbWinstvrijstellingPct,
    Expression<double>? bracket1Rate,
    Expression<int>? bracket1Threshold,
    Expression<double>? bracket2Rate,
    Expression<int>? bracket2Threshold,
    Expression<double>? bracket3Rate,
    Expression<int>? algHeffingskortingMax,
    Expression<int>? arbeidskortingMax,
    Expression<double>? zvwRate,
    Expression<int>? zvwMax,
    Expression<int>? mixedCostsThreshold,
    Expression<double>? mixedCosts80Pct,
    Expression<double>? jaarruimtePct,
    Expression<int>? jaarruimteMax,
    Expression<int>? aowFranchise,
    Expression<int>? reserveringsruimteMax,
    Expression<double>? factorAMultiplier,
    Expression<int>? kiaLowerThreshold,
    Expression<int>? kiaUpperThreshold,
    Expression<int>? kiaFlatThreshold,
    Expression<double>? kiaRate,
    Expression<int>? kiaFlatAmount,
    Expression<double>? mileageRatePerKm,
    Expression<int>? korThreshold,
    Expression<int>? ossThreshold,
    Expression<double>? belastingrentePct,
  }) {
    return RawValuesInsertable({
      if (year != null) 'year': year,
      if (zelfstandigenaftrek != null)
        'zelfstandigenaftrek': zelfstandigenaftrek,
      if (startersaftrek != null) 'startersaftrek': startersaftrek,
      if (mkbWinstvrijstellingPct != null)
        'mkb_winstvrijstelling_pct': mkbWinstvrijstellingPct,
      if (bracket1Rate != null) 'bracket1_rate': bracket1Rate,
      if (bracket1Threshold != null) 'bracket1_threshold': bracket1Threshold,
      if (bracket2Rate != null) 'bracket2_rate': bracket2Rate,
      if (bracket2Threshold != null) 'bracket2_threshold': bracket2Threshold,
      if (bracket3Rate != null) 'bracket3_rate': bracket3Rate,
      if (algHeffingskortingMax != null)
        'alg_heffingskorting_max': algHeffingskortingMax,
      if (arbeidskortingMax != null) 'arbeidskorting_max': arbeidskortingMax,
      if (zvwRate != null) 'zvw_rate': zvwRate,
      if (zvwMax != null) 'zvw_max': zvwMax,
      if (mixedCostsThreshold != null)
        'mixed_costs_threshold': mixedCostsThreshold,
      if (mixedCosts80Pct != null) 'mixed_costs80_pct': mixedCosts80Pct,
      if (jaarruimtePct != null) 'jaarruimte_pct': jaarruimtePct,
      if (jaarruimteMax != null) 'jaarruimte_max': jaarruimteMax,
      if (aowFranchise != null) 'aow_franchise': aowFranchise,
      if (reserveringsruimteMax != null)
        'reserveringsruimte_max': reserveringsruimteMax,
      if (factorAMultiplier != null) 'factor_a_multiplier': factorAMultiplier,
      if (kiaLowerThreshold != null) 'kia_lower_threshold': kiaLowerThreshold,
      if (kiaUpperThreshold != null) 'kia_upper_threshold': kiaUpperThreshold,
      if (kiaFlatThreshold != null) 'kia_flat_threshold': kiaFlatThreshold,
      if (kiaRate != null) 'kia_rate': kiaRate,
      if (kiaFlatAmount != null) 'kia_flat_amount': kiaFlatAmount,
      if (mileageRatePerKm != null) 'mileage_rate_per_km': mileageRatePerKm,
      if (korThreshold != null) 'kor_threshold': korThreshold,
      if (ossThreshold != null) 'oss_threshold': ossThreshold,
      if (belastingrentePct != null) 'belastingrente_pct': belastingrentePct,
    });
  }

  TaxParamsCompanion copyWith({
    Value<int>? year,
    Value<int>? zelfstandigenaftrek,
    Value<int>? startersaftrek,
    Value<double>? mkbWinstvrijstellingPct,
    Value<double>? bracket1Rate,
    Value<int>? bracket1Threshold,
    Value<double>? bracket2Rate,
    Value<int>? bracket2Threshold,
    Value<double>? bracket3Rate,
    Value<int>? algHeffingskortingMax,
    Value<int>? arbeidskortingMax,
    Value<double>? zvwRate,
    Value<int>? zvwMax,
    Value<int>? mixedCostsThreshold,
    Value<double>? mixedCosts80Pct,
    Value<double>? jaarruimtePct,
    Value<int>? jaarruimteMax,
    Value<int>? aowFranchise,
    Value<int>? reserveringsruimteMax,
    Value<double>? factorAMultiplier,
    Value<int>? kiaLowerThreshold,
    Value<int>? kiaUpperThreshold,
    Value<int>? kiaFlatThreshold,
    Value<double>? kiaRate,
    Value<int>? kiaFlatAmount,
    Value<double>? mileageRatePerKm,
    Value<int>? korThreshold,
    Value<int>? ossThreshold,
    Value<double>? belastingrentePct,
  }) {
    return TaxParamsCompanion(
      year: year ?? this.year,
      zelfstandigenaftrek: zelfstandigenaftrek ?? this.zelfstandigenaftrek,
      startersaftrek: startersaftrek ?? this.startersaftrek,
      mkbWinstvrijstellingPct:
          mkbWinstvrijstellingPct ?? this.mkbWinstvrijstellingPct,
      bracket1Rate: bracket1Rate ?? this.bracket1Rate,
      bracket1Threshold: bracket1Threshold ?? this.bracket1Threshold,
      bracket2Rate: bracket2Rate ?? this.bracket2Rate,
      bracket2Threshold: bracket2Threshold ?? this.bracket2Threshold,
      bracket3Rate: bracket3Rate ?? this.bracket3Rate,
      algHeffingskortingMax:
          algHeffingskortingMax ?? this.algHeffingskortingMax,
      arbeidskortingMax: arbeidskortingMax ?? this.arbeidskortingMax,
      zvwRate: zvwRate ?? this.zvwRate,
      zvwMax: zvwMax ?? this.zvwMax,
      mixedCostsThreshold: mixedCostsThreshold ?? this.mixedCostsThreshold,
      mixedCosts80Pct: mixedCosts80Pct ?? this.mixedCosts80Pct,
      jaarruimtePct: jaarruimtePct ?? this.jaarruimtePct,
      jaarruimteMax: jaarruimteMax ?? this.jaarruimteMax,
      aowFranchise: aowFranchise ?? this.aowFranchise,
      reserveringsruimteMax:
          reserveringsruimteMax ?? this.reserveringsruimteMax,
      factorAMultiplier: factorAMultiplier ?? this.factorAMultiplier,
      kiaLowerThreshold: kiaLowerThreshold ?? this.kiaLowerThreshold,
      kiaUpperThreshold: kiaUpperThreshold ?? this.kiaUpperThreshold,
      kiaFlatThreshold: kiaFlatThreshold ?? this.kiaFlatThreshold,
      kiaRate: kiaRate ?? this.kiaRate,
      kiaFlatAmount: kiaFlatAmount ?? this.kiaFlatAmount,
      mileageRatePerKm: mileageRatePerKm ?? this.mileageRatePerKm,
      korThreshold: korThreshold ?? this.korThreshold,
      ossThreshold: ossThreshold ?? this.ossThreshold,
      belastingrentePct: belastingrentePct ?? this.belastingrentePct,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (zelfstandigenaftrek.present) {
      map['zelfstandigenaftrek'] = Variable<int>(zelfstandigenaftrek.value);
    }
    if (startersaftrek.present) {
      map['startersaftrek'] = Variable<int>(startersaftrek.value);
    }
    if (mkbWinstvrijstellingPct.present) {
      map['mkb_winstvrijstelling_pct'] = Variable<double>(
        mkbWinstvrijstellingPct.value,
      );
    }
    if (bracket1Rate.present) {
      map['bracket1_rate'] = Variable<double>(bracket1Rate.value);
    }
    if (bracket1Threshold.present) {
      map['bracket1_threshold'] = Variable<int>(bracket1Threshold.value);
    }
    if (bracket2Rate.present) {
      map['bracket2_rate'] = Variable<double>(bracket2Rate.value);
    }
    if (bracket2Threshold.present) {
      map['bracket2_threshold'] = Variable<int>(bracket2Threshold.value);
    }
    if (bracket3Rate.present) {
      map['bracket3_rate'] = Variable<double>(bracket3Rate.value);
    }
    if (algHeffingskortingMax.present) {
      map['alg_heffingskorting_max'] = Variable<int>(
        algHeffingskortingMax.value,
      );
    }
    if (arbeidskortingMax.present) {
      map['arbeidskorting_max'] = Variable<int>(arbeidskortingMax.value);
    }
    if (zvwRate.present) {
      map['zvw_rate'] = Variable<double>(zvwRate.value);
    }
    if (zvwMax.present) {
      map['zvw_max'] = Variable<int>(zvwMax.value);
    }
    if (mixedCostsThreshold.present) {
      map['mixed_costs_threshold'] = Variable<int>(mixedCostsThreshold.value);
    }
    if (mixedCosts80Pct.present) {
      map['mixed_costs80_pct'] = Variable<double>(mixedCosts80Pct.value);
    }
    if (jaarruimtePct.present) {
      map['jaarruimte_pct'] = Variable<double>(jaarruimtePct.value);
    }
    if (jaarruimteMax.present) {
      map['jaarruimte_max'] = Variable<int>(jaarruimteMax.value);
    }
    if (aowFranchise.present) {
      map['aow_franchise'] = Variable<int>(aowFranchise.value);
    }
    if (reserveringsruimteMax.present) {
      map['reserveringsruimte_max'] = Variable<int>(
        reserveringsruimteMax.value,
      );
    }
    if (factorAMultiplier.present) {
      map['factor_a_multiplier'] = Variable<double>(factorAMultiplier.value);
    }
    if (kiaLowerThreshold.present) {
      map['kia_lower_threshold'] = Variable<int>(kiaLowerThreshold.value);
    }
    if (kiaUpperThreshold.present) {
      map['kia_upper_threshold'] = Variable<int>(kiaUpperThreshold.value);
    }
    if (kiaFlatThreshold.present) {
      map['kia_flat_threshold'] = Variable<int>(kiaFlatThreshold.value);
    }
    if (kiaRate.present) {
      map['kia_rate'] = Variable<double>(kiaRate.value);
    }
    if (kiaFlatAmount.present) {
      map['kia_flat_amount'] = Variable<int>(kiaFlatAmount.value);
    }
    if (mileageRatePerKm.present) {
      map['mileage_rate_per_km'] = Variable<double>(mileageRatePerKm.value);
    }
    if (korThreshold.present) {
      map['kor_threshold'] = Variable<int>(korThreshold.value);
    }
    if (ossThreshold.present) {
      map['oss_threshold'] = Variable<int>(ossThreshold.value);
    }
    if (belastingrentePct.present) {
      map['belastingrente_pct'] = Variable<double>(belastingrentePct.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaxParamsCompanion(')
          ..write('year: $year, ')
          ..write('zelfstandigenaftrek: $zelfstandigenaftrek, ')
          ..write('startersaftrek: $startersaftrek, ')
          ..write('mkbWinstvrijstellingPct: $mkbWinstvrijstellingPct, ')
          ..write('bracket1Rate: $bracket1Rate, ')
          ..write('bracket1Threshold: $bracket1Threshold, ')
          ..write('bracket2Rate: $bracket2Rate, ')
          ..write('bracket2Threshold: $bracket2Threshold, ')
          ..write('bracket3Rate: $bracket3Rate, ')
          ..write('algHeffingskortingMax: $algHeffingskortingMax, ')
          ..write('arbeidskortingMax: $arbeidskortingMax, ')
          ..write('zvwRate: $zvwRate, ')
          ..write('zvwMax: $zvwMax, ')
          ..write('mixedCostsThreshold: $mixedCostsThreshold, ')
          ..write('mixedCosts80Pct: $mixedCosts80Pct, ')
          ..write('jaarruimtePct: $jaarruimtePct, ')
          ..write('jaarruimteMax: $jaarruimteMax, ')
          ..write('aowFranchise: $aowFranchise, ')
          ..write('reserveringsruimteMax: $reserveringsruimteMax, ')
          ..write('factorAMultiplier: $factorAMultiplier, ')
          ..write('kiaLowerThreshold: $kiaLowerThreshold, ')
          ..write('kiaUpperThreshold: $kiaUpperThreshold, ')
          ..write('kiaFlatThreshold: $kiaFlatThreshold, ')
          ..write('kiaRate: $kiaRate, ')
          ..write('kiaFlatAmount: $kiaFlatAmount, ')
          ..write('mileageRatePerKm: $mileageRatePerKm, ')
          ..write('korThreshold: $korThreshold, ')
          ..write('ossThreshold: $ossThreshold, ')
          ..write('belastingrentePct: $belastingrentePct')
          ..write(')'))
        .toString();
  }
}

class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('NL'),
  );
  static const VerificationMeta _vatNumberMeta = const VerificationMeta(
    'vatNumber',
  );
  @override
  late final GeneratedColumn<String> vatNumber = GeneratedColumn<String>(
    'vat_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kvkNumberMeta = const VerificationMeta(
    'kvkNumber',
  );
  @override
  late final GeneratedColumn<String> kvkNumber = GeneratedColumn<String>(
    'kvk_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactPersonMeta = const VerificationMeta(
    'contactPerson',
  );
  @override
  late final GeneratedColumn<String> contactPerson = GeneratedColumn<String>(
    'contact_person',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wetDbaRiskLevelMeta = const VerificationMeta(
    'wetDbaRiskLevel',
  );
  @override
  late final GeneratedColumn<String> wetDbaRiskLevel = GeneratedColumn<String>(
    'wet_dba_risk_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Low'),
  );
  static const VerificationMeta _contractSignedMeta = const VerificationMeta(
    'contractSigned',
  );
  @override
  late final GeneratedColumn<bool> contractSigned = GeneratedColumn<bool>(
    'contract_signed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("contract_signed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _contractExpiryMeta = const VerificationMeta(
    'contractExpiry',
  );
  @override
  late final GeneratedColumn<DateTime> contractExpiry =
      GeneratedColumn<DateTime>(
        'contract_expiry',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    country,
    vatNumber,
    kvkNumber,
    address,
    contactPerson,
    email,
    phone,
    wetDbaRiskLevel,
    contractSigned,
    contractExpiry,
    notes,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('vat_number')) {
      context.handle(
        _vatNumberMeta,
        vatNumber.isAcceptableOrUnknown(data['vat_number']!, _vatNumberMeta),
      );
    }
    if (data.containsKey('kvk_number')) {
      context.handle(
        _kvkNumberMeta,
        kvkNumber.isAcceptableOrUnknown(data['kvk_number']!, _kvkNumberMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('contact_person')) {
      context.handle(
        _contactPersonMeta,
        contactPerson.isAcceptableOrUnknown(
          data['contact_person']!,
          _contactPersonMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('wet_dba_risk_level')) {
      context.handle(
        _wetDbaRiskLevelMeta,
        wetDbaRiskLevel.isAcceptableOrUnknown(
          data['wet_dba_risk_level']!,
          _wetDbaRiskLevelMeta,
        ),
      );
    }
    if (data.containsKey('contract_signed')) {
      context.handle(
        _contractSignedMeta,
        contractSigned.isAcceptableOrUnknown(
          data['contract_signed']!,
          _contractSignedMeta,
        ),
      );
    }
    if (data.containsKey('contract_expiry')) {
      context.handle(
        _contractExpiryMeta,
        contractExpiry.isAcceptableOrUnknown(
          data['contract_expiry']!,
          _contractExpiryMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      vatNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vat_number'],
      ),
      kvkNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kvk_number'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      contactPerson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_person'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      wetDbaRiskLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wet_dba_risk_level'],
      )!,
      contractSigned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}contract_signed'],
      )!,
      contractExpiry: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}contract_expiry'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final String name;
  final String country;
  final String? vatNumber;
  final String? kvkNumber;
  final String? address;
  final String? contactPerson;
  final String? email;
  final String? phone;
  final String wetDbaRiskLevel;
  final bool contractSigned;
  final DateTime? contractExpiry;
  final String? notes;
  final bool isActive;
  const Client({
    required this.id,
    required this.name,
    required this.country,
    this.vatNumber,
    this.kvkNumber,
    this.address,
    this.contactPerson,
    this.email,
    this.phone,
    required this.wetDbaRiskLevel,
    required this.contractSigned,
    this.contractExpiry,
    this.notes,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['country'] = Variable<String>(country);
    if (!nullToAbsent || vatNumber != null) {
      map['vat_number'] = Variable<String>(vatNumber);
    }
    if (!nullToAbsent || kvkNumber != null) {
      map['kvk_number'] = Variable<String>(kvkNumber);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || contactPerson != null) {
      map['contact_person'] = Variable<String>(contactPerson);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['wet_dba_risk_level'] = Variable<String>(wetDbaRiskLevel);
    map['contract_signed'] = Variable<bool>(contractSigned);
    if (!nullToAbsent || contractExpiry != null) {
      map['contract_expiry'] = Variable<DateTime>(contractExpiry);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      name: Value(name),
      country: Value(country),
      vatNumber: vatNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(vatNumber),
      kvkNumber: kvkNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(kvkNumber),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      contactPerson: contactPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPerson),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      wetDbaRiskLevel: Value(wetDbaRiskLevel),
      contractSigned: Value(contractSigned),
      contractExpiry: contractExpiry == null && nullToAbsent
          ? const Value.absent()
          : Value(contractExpiry),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      country: serializer.fromJson<String>(json['country']),
      vatNumber: serializer.fromJson<String?>(json['vatNumber']),
      kvkNumber: serializer.fromJson<String?>(json['kvkNumber']),
      address: serializer.fromJson<String?>(json['address']),
      contactPerson: serializer.fromJson<String?>(json['contactPerson']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      wetDbaRiskLevel: serializer.fromJson<String>(json['wetDbaRiskLevel']),
      contractSigned: serializer.fromJson<bool>(json['contractSigned']),
      contractExpiry: serializer.fromJson<DateTime?>(json['contractExpiry']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'country': serializer.toJson<String>(country),
      'vatNumber': serializer.toJson<String?>(vatNumber),
      'kvkNumber': serializer.toJson<String?>(kvkNumber),
      'address': serializer.toJson<String?>(address),
      'contactPerson': serializer.toJson<String?>(contactPerson),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'wetDbaRiskLevel': serializer.toJson<String>(wetDbaRiskLevel),
      'contractSigned': serializer.toJson<bool>(contractSigned),
      'contractExpiry': serializer.toJson<DateTime?>(contractExpiry),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Client copyWith({
    int? id,
    String? name,
    String? country,
    Value<String?> vatNumber = const Value.absent(),
    Value<String?> kvkNumber = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> contactPerson = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    String? wetDbaRiskLevel,
    bool? contractSigned,
    Value<DateTime?> contractExpiry = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isActive,
  }) => Client(
    id: id ?? this.id,
    name: name ?? this.name,
    country: country ?? this.country,
    vatNumber: vatNumber.present ? vatNumber.value : this.vatNumber,
    kvkNumber: kvkNumber.present ? kvkNumber.value : this.kvkNumber,
    address: address.present ? address.value : this.address,
    contactPerson: contactPerson.present
        ? contactPerson.value
        : this.contactPerson,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    wetDbaRiskLevel: wetDbaRiskLevel ?? this.wetDbaRiskLevel,
    contractSigned: contractSigned ?? this.contractSigned,
    contractExpiry: contractExpiry.present
        ? contractExpiry.value
        : this.contractExpiry,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      country: data.country.present ? data.country.value : this.country,
      vatNumber: data.vatNumber.present ? data.vatNumber.value : this.vatNumber,
      kvkNumber: data.kvkNumber.present ? data.kvkNumber.value : this.kvkNumber,
      address: data.address.present ? data.address.value : this.address,
      contactPerson: data.contactPerson.present
          ? data.contactPerson.value
          : this.contactPerson,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      wetDbaRiskLevel: data.wetDbaRiskLevel.present
          ? data.wetDbaRiskLevel.value
          : this.wetDbaRiskLevel,
      contractSigned: data.contractSigned.present
          ? data.contractSigned.value
          : this.contractSigned,
      contractExpiry: data.contractExpiry.present
          ? data.contractExpiry.value
          : this.contractExpiry,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('vatNumber: $vatNumber, ')
          ..write('kvkNumber: $kvkNumber, ')
          ..write('address: $address, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('wetDbaRiskLevel: $wetDbaRiskLevel, ')
          ..write('contractSigned: $contractSigned, ')
          ..write('contractExpiry: $contractExpiry, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    country,
    vatNumber,
    kvkNumber,
    address,
    contactPerson,
    email,
    phone,
    wetDbaRiskLevel,
    contractSigned,
    contractExpiry,
    notes,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.name == this.name &&
          other.country == this.country &&
          other.vatNumber == this.vatNumber &&
          other.kvkNumber == this.kvkNumber &&
          other.address == this.address &&
          other.contactPerson == this.contactPerson &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.wetDbaRiskLevel == this.wetDbaRiskLevel &&
          other.contractSigned == this.contractSigned &&
          other.contractExpiry == this.contractExpiry &&
          other.notes == this.notes &&
          other.isActive == this.isActive);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> country;
  final Value<String?> vatNumber;
  final Value<String?> kvkNumber;
  final Value<String?> address;
  final Value<String?> contactPerson;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String> wetDbaRiskLevel;
  final Value<bool> contractSigned;
  final Value<DateTime?> contractExpiry;
  final Value<String?> notes;
  final Value<bool> isActive;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.country = const Value.absent(),
    this.vatNumber = const Value.absent(),
    this.kvkNumber = const Value.absent(),
    this.address = const Value.absent(),
    this.contactPerson = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.wetDbaRiskLevel = const Value.absent(),
    this.contractSigned = const Value.absent(),
    this.contractExpiry = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.country = const Value.absent(),
    this.vatNumber = const Value.absent(),
    this.kvkNumber = const Value.absent(),
    this.address = const Value.absent(),
    this.contactPerson = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.wetDbaRiskLevel = const Value.absent(),
    this.contractSigned = const Value.absent(),
    this.contractExpiry = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? country,
    Expression<String>? vatNumber,
    Expression<String>? kvkNumber,
    Expression<String>? address,
    Expression<String>? contactPerson,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? wetDbaRiskLevel,
    Expression<bool>? contractSigned,
    Expression<DateTime>? contractExpiry,
    Expression<String>? notes,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (country != null) 'country': country,
      if (vatNumber != null) 'vat_number': vatNumber,
      if (kvkNumber != null) 'kvk_number': kvkNumber,
      if (address != null) 'address': address,
      if (contactPerson != null) 'contact_person': contactPerson,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (wetDbaRiskLevel != null) 'wet_dba_risk_level': wetDbaRiskLevel,
      if (contractSigned != null) 'contract_signed': contractSigned,
      if (contractExpiry != null) 'contract_expiry': contractExpiry,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
    });
  }

  ClientsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? country,
    Value<String?>? vatNumber,
    Value<String?>? kvkNumber,
    Value<String?>? address,
    Value<String?>? contactPerson,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String>? wetDbaRiskLevel,
    Value<bool>? contractSigned,
    Value<DateTime?>? contractExpiry,
    Value<String?>? notes,
    Value<bool>? isActive,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      vatNumber: vatNumber ?? this.vatNumber,
      kvkNumber: kvkNumber ?? this.kvkNumber,
      address: address ?? this.address,
      contactPerson: contactPerson ?? this.contactPerson,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      wetDbaRiskLevel: wetDbaRiskLevel ?? this.wetDbaRiskLevel,
      contractSigned: contractSigned ?? this.contractSigned,
      contractExpiry: contractExpiry ?? this.contractExpiry,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (vatNumber.present) {
      map['vat_number'] = Variable<String>(vatNumber.value);
    }
    if (kvkNumber.present) {
      map['kvk_number'] = Variable<String>(kvkNumber.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (contactPerson.present) {
      map['contact_person'] = Variable<String>(contactPerson.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (wetDbaRiskLevel.present) {
      map['wet_dba_risk_level'] = Variable<String>(wetDbaRiskLevel.value);
    }
    if (contractSigned.present) {
      map['contract_signed'] = Variable<bool>(contractSigned.value);
    }
    if (contractExpiry.present) {
      map['contract_expiry'] = Variable<DateTime>(contractExpiry.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('vatNumber: $vatNumber, ')
          ..write('kvkNumber: $kvkNumber, ')
          ..write('address: $address, ')
          ..write('contactPerson: $contactPerson, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('wetDbaRiskLevel: $wetDbaRiskLevel, ')
          ..write('contractSigned: $contractSigned, ')
          ..write('contractExpiry: $contractExpiry, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _invoiceDateMeta = const VerificationMeta(
    'invoiceDate',
  );
  @override
  late final GeneratedColumn<DateTime> invoiceDate = GeneratedColumn<DateTime>(
    'invoice_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplyDateMeta = const VerificationMeta(
    'supplyDate',
  );
  @override
  late final GeneratedColumn<DateTime> supplyDate = GeneratedColumn<DateTime>(
    'supply_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _invoiceTypeMeta = const VerificationMeta(
    'invoiceType',
  );
  @override
  late final GeneratedColumn<String> invoiceType = GeneratedColumn<String>(
    'invoice_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Invoice'),
  );
  static const VerificationMeta _sellerNameMeta = const VerificationMeta(
    'sellerName',
  );
  @override
  late final GeneratedColumn<String> sellerName = GeneratedColumn<String>(
    'seller_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellerVatNumberMeta = const VerificationMeta(
    'sellerVatNumber',
  );
  @override
  late final GeneratedColumn<String> sellerVatNumber = GeneratedColumn<String>(
    'seller_vat_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellerKvkNumberMeta = const VerificationMeta(
    'sellerKvkNumber',
  );
  @override
  late final GeneratedColumn<String> sellerKvkNumber = GeneratedColumn<String>(
    'seller_kvk_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellerAddressMeta = const VerificationMeta(
    'sellerAddress',
  );
  @override
  late final GeneratedColumn<String> sellerAddress = GeneratedColumn<String>(
    'seller_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentTermDaysMeta = const VerificationMeta(
    'paymentTermDays',
  );
  @override
  late final GeneratedColumn<int> paymentTermDays = GeneratedColumn<int>(
    'payment_term_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Draft'),
  );
  static const VerificationMeta _paidDateMeta = const VerificationMeta(
    'paidDate',
  );
  @override
  late final GeneratedColumn<DateTime> paidDate = GeneratedColumn<DateTime>(
    'paid_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isReverseChargeMeta = const VerificationMeta(
    'isReverseCharge',
  );
  @override
  late final GeneratedColumn<bool> isReverseCharge = GeneratedColumn<bool>(
    'is_reverse_charge',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_reverse_charge" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isIcpMeta = const VerificationMeta('isIcp');
  @override
  late final GeneratedColumn<bool> isIcp = GeneratedColumn<bool>(
    'is_icp',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_icp" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reverseChargeNoteMeta = const VerificationMeta(
    'reverseChargeNote',
  );
  @override
  late final GeneratedColumn<String> reverseChargeNote =
      GeneratedColumn<String>(
        'reverse_charge_note',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _totalExclVatMeta = const VerificationMeta(
    'totalExclVat',
  );
  @override
  late final GeneratedColumn<int> totalExclVat = GeneratedColumn<int>(
    'total_excl_vat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalVatMeta = const VerificationMeta(
    'totalVat',
  );
  @override
  late final GeneratedColumn<int> totalVat = GeneratedColumn<int>(
    'total_vat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalInclVatMeta = const VerificationMeta(
    'totalInclVat',
  );
  @override
  late final GeneratedColumn<int> totalInclVat = GeneratedColumn<int>(
    'total_incl_vat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fiscalYearMeta = const VerificationMeta(
    'fiscalYear',
  );
  @override
  late final GeneratedColumn<int> fiscalYear = GeneratedColumn<int>(
    'fiscal_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quarterMeta = const VerificationMeta(
    'quarter',
  );
  @override
  late final GeneratedColumn<String> quarter = GeneratedColumn<String>(
    'quarter',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceNumber,
    invoiceDate,
    supplyDate,
    clientId,
    invoiceType,
    sellerName,
    sellerVatNumber,
    sellerKvkNumber,
    sellerAddress,
    paymentTermDays,
    dueDate,
    status,
    paidDate,
    paymentMethod,
    notes,
    isReverseCharge,
    isIcp,
    reverseChargeNote,
    totalExclVat,
    totalVat,
    totalInclVat,
    fiscalYear,
    quarter,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('invoice_date')) {
      context.handle(
        _invoiceDateMeta,
        invoiceDate.isAcceptableOrUnknown(
          data['invoice_date']!,
          _invoiceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceDateMeta);
    }
    if (data.containsKey('supply_date')) {
      context.handle(
        _supplyDateMeta,
        supplyDate.isAcceptableOrUnknown(data['supply_date']!, _supplyDateMeta),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('invoice_type')) {
      context.handle(
        _invoiceTypeMeta,
        invoiceType.isAcceptableOrUnknown(
          data['invoice_type']!,
          _invoiceTypeMeta,
        ),
      );
    }
    if (data.containsKey('seller_name')) {
      context.handle(
        _sellerNameMeta,
        sellerName.isAcceptableOrUnknown(data['seller_name']!, _sellerNameMeta),
      );
    } else if (isInserting) {
      context.missing(_sellerNameMeta);
    }
    if (data.containsKey('seller_vat_number')) {
      context.handle(
        _sellerVatNumberMeta,
        sellerVatNumber.isAcceptableOrUnknown(
          data['seller_vat_number']!,
          _sellerVatNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellerVatNumberMeta);
    }
    if (data.containsKey('seller_kvk_number')) {
      context.handle(
        _sellerKvkNumberMeta,
        sellerKvkNumber.isAcceptableOrUnknown(
          data['seller_kvk_number']!,
          _sellerKvkNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellerKvkNumberMeta);
    }
    if (data.containsKey('seller_address')) {
      context.handle(
        _sellerAddressMeta,
        sellerAddress.isAcceptableOrUnknown(
          data['seller_address']!,
          _sellerAddressMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellerAddressMeta);
    }
    if (data.containsKey('payment_term_days')) {
      context.handle(
        _paymentTermDaysMeta,
        paymentTermDays.isAcceptableOrUnknown(
          data['payment_term_days']!,
          _paymentTermDaysMeta,
        ),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('paid_date')) {
      context.handle(
        _paidDateMeta,
        paidDate.isAcceptableOrUnknown(data['paid_date']!, _paidDateMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_reverse_charge')) {
      context.handle(
        _isReverseChargeMeta,
        isReverseCharge.isAcceptableOrUnknown(
          data['is_reverse_charge']!,
          _isReverseChargeMeta,
        ),
      );
    }
    if (data.containsKey('is_icp')) {
      context.handle(
        _isIcpMeta,
        isIcp.isAcceptableOrUnknown(data['is_icp']!, _isIcpMeta),
      );
    }
    if (data.containsKey('reverse_charge_note')) {
      context.handle(
        _reverseChargeNoteMeta,
        reverseChargeNote.isAcceptableOrUnknown(
          data['reverse_charge_note']!,
          _reverseChargeNoteMeta,
        ),
      );
    }
    if (data.containsKey('total_excl_vat')) {
      context.handle(
        _totalExclVatMeta,
        totalExclVat.isAcceptableOrUnknown(
          data['total_excl_vat']!,
          _totalExclVatMeta,
        ),
      );
    }
    if (data.containsKey('total_vat')) {
      context.handle(
        _totalVatMeta,
        totalVat.isAcceptableOrUnknown(data['total_vat']!, _totalVatMeta),
      );
    }
    if (data.containsKey('total_incl_vat')) {
      context.handle(
        _totalInclVatMeta,
        totalInclVat.isAcceptableOrUnknown(
          data['total_incl_vat']!,
          _totalInclVatMeta,
        ),
      );
    }
    if (data.containsKey('fiscal_year')) {
      context.handle(
        _fiscalYearMeta,
        fiscalYear.isAcceptableOrUnknown(data['fiscal_year']!, _fiscalYearMeta),
      );
    } else if (isInserting) {
      context.missing(_fiscalYearMeta);
    }
    if (data.containsKey('quarter')) {
      context.handle(
        _quarterMeta,
        quarter.isAcceptableOrUnknown(data['quarter']!, _quarterMeta),
      );
    } else if (isInserting) {
      context.missing(_quarterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      )!,
      invoiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}invoice_date'],
      )!,
      supplyDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}supply_date'],
      ),
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      invoiceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_type'],
      )!,
      sellerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seller_name'],
      )!,
      sellerVatNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seller_vat_number'],
      )!,
      sellerKvkNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seller_kvk_number'],
      )!,
      sellerAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seller_address'],
      )!,
      paymentTermDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_term_days'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      paidDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_date'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isReverseCharge: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_reverse_charge'],
      )!,
      isIcp: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_icp'],
      )!,
      reverseChargeNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reverse_charge_note'],
      ),
      totalExclVat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_excl_vat'],
      )!,
      totalVat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_vat'],
      )!,
      totalInclVat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_incl_vat'],
      )!,
      fiscalYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fiscal_year'],
      )!,
      quarter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quarter'],
      )!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final DateTime? supplyDate;
  final int clientId;
  final String invoiceType;
  final String sellerName;
  final String sellerVatNumber;
  final String sellerKvkNumber;
  final String sellerAddress;
  final int paymentTermDays;
  final DateTime dueDate;
  final String status;
  final DateTime? paidDate;
  final String? paymentMethod;
  final String? notes;
  final bool isReverseCharge;
  final bool isIcp;
  final String? reverseChargeNote;
  final int totalExclVat;
  final int totalVat;
  final int totalInclVat;
  final int fiscalYear;
  final String quarter;
  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.invoiceDate,
    this.supplyDate,
    required this.clientId,
    required this.invoiceType,
    required this.sellerName,
    required this.sellerVatNumber,
    required this.sellerKvkNumber,
    required this.sellerAddress,
    required this.paymentTermDays,
    required this.dueDate,
    required this.status,
    this.paidDate,
    this.paymentMethod,
    this.notes,
    required this.isReverseCharge,
    required this.isIcp,
    this.reverseChargeNote,
    required this.totalExclVat,
    required this.totalVat,
    required this.totalInclVat,
    required this.fiscalYear,
    required this.quarter,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['invoice_date'] = Variable<DateTime>(invoiceDate);
    if (!nullToAbsent || supplyDate != null) {
      map['supply_date'] = Variable<DateTime>(supplyDate);
    }
    map['client_id'] = Variable<int>(clientId);
    map['invoice_type'] = Variable<String>(invoiceType);
    map['seller_name'] = Variable<String>(sellerName);
    map['seller_vat_number'] = Variable<String>(sellerVatNumber);
    map['seller_kvk_number'] = Variable<String>(sellerKvkNumber);
    map['seller_address'] = Variable<String>(sellerAddress);
    map['payment_term_days'] = Variable<int>(paymentTermDays);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || paidDate != null) {
      map['paid_date'] = Variable<DateTime>(paidDate);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_reverse_charge'] = Variable<bool>(isReverseCharge);
    map['is_icp'] = Variable<bool>(isIcp);
    if (!nullToAbsent || reverseChargeNote != null) {
      map['reverse_charge_note'] = Variable<String>(reverseChargeNote);
    }
    map['total_excl_vat'] = Variable<int>(totalExclVat);
    map['total_vat'] = Variable<int>(totalVat);
    map['total_incl_vat'] = Variable<int>(totalInclVat);
    map['fiscal_year'] = Variable<int>(fiscalYear);
    map['quarter'] = Variable<String>(quarter);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      invoiceNumber: Value(invoiceNumber),
      invoiceDate: Value(invoiceDate),
      supplyDate: supplyDate == null && nullToAbsent
          ? const Value.absent()
          : Value(supplyDate),
      clientId: Value(clientId),
      invoiceType: Value(invoiceType),
      sellerName: Value(sellerName),
      sellerVatNumber: Value(sellerVatNumber),
      sellerKvkNumber: Value(sellerKvkNumber),
      sellerAddress: Value(sellerAddress),
      paymentTermDays: Value(paymentTermDays),
      dueDate: Value(dueDate),
      status: Value(status),
      paidDate: paidDate == null && nullToAbsent
          ? const Value.absent()
          : Value(paidDate),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isReverseCharge: Value(isReverseCharge),
      isIcp: Value(isIcp),
      reverseChargeNote: reverseChargeNote == null && nullToAbsent
          ? const Value.absent()
          : Value(reverseChargeNote),
      totalExclVat: Value(totalExclVat),
      totalVat: Value(totalVat),
      totalInclVat: Value(totalInclVat),
      fiscalYear: Value(fiscalYear),
      quarter: Value(quarter),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      invoiceDate: serializer.fromJson<DateTime>(json['invoiceDate']),
      supplyDate: serializer.fromJson<DateTime?>(json['supplyDate']),
      clientId: serializer.fromJson<int>(json['clientId']),
      invoiceType: serializer.fromJson<String>(json['invoiceType']),
      sellerName: serializer.fromJson<String>(json['sellerName']),
      sellerVatNumber: serializer.fromJson<String>(json['sellerVatNumber']),
      sellerKvkNumber: serializer.fromJson<String>(json['sellerKvkNumber']),
      sellerAddress: serializer.fromJson<String>(json['sellerAddress']),
      paymentTermDays: serializer.fromJson<int>(json['paymentTermDays']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      status: serializer.fromJson<String>(json['status']),
      paidDate: serializer.fromJson<DateTime?>(json['paidDate']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      notes: serializer.fromJson<String?>(json['notes']),
      isReverseCharge: serializer.fromJson<bool>(json['isReverseCharge']),
      isIcp: serializer.fromJson<bool>(json['isIcp']),
      reverseChargeNote: serializer.fromJson<String?>(
        json['reverseChargeNote'],
      ),
      totalExclVat: serializer.fromJson<int>(json['totalExclVat']),
      totalVat: serializer.fromJson<int>(json['totalVat']),
      totalInclVat: serializer.fromJson<int>(json['totalInclVat']),
      fiscalYear: serializer.fromJson<int>(json['fiscalYear']),
      quarter: serializer.fromJson<String>(json['quarter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'invoiceDate': serializer.toJson<DateTime>(invoiceDate),
      'supplyDate': serializer.toJson<DateTime?>(supplyDate),
      'clientId': serializer.toJson<int>(clientId),
      'invoiceType': serializer.toJson<String>(invoiceType),
      'sellerName': serializer.toJson<String>(sellerName),
      'sellerVatNumber': serializer.toJson<String>(sellerVatNumber),
      'sellerKvkNumber': serializer.toJson<String>(sellerKvkNumber),
      'sellerAddress': serializer.toJson<String>(sellerAddress),
      'paymentTermDays': serializer.toJson<int>(paymentTermDays),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'status': serializer.toJson<String>(status),
      'paidDate': serializer.toJson<DateTime?>(paidDate),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'notes': serializer.toJson<String?>(notes),
      'isReverseCharge': serializer.toJson<bool>(isReverseCharge),
      'isIcp': serializer.toJson<bool>(isIcp),
      'reverseChargeNote': serializer.toJson<String?>(reverseChargeNote),
      'totalExclVat': serializer.toJson<int>(totalExclVat),
      'totalVat': serializer.toJson<int>(totalVat),
      'totalInclVat': serializer.toJson<int>(totalInclVat),
      'fiscalYear': serializer.toJson<int>(fiscalYear),
      'quarter': serializer.toJson<String>(quarter),
    };
  }

  Invoice copyWith({
    int? id,
    String? invoiceNumber,
    DateTime? invoiceDate,
    Value<DateTime?> supplyDate = const Value.absent(),
    int? clientId,
    String? invoiceType,
    String? sellerName,
    String? sellerVatNumber,
    String? sellerKvkNumber,
    String? sellerAddress,
    int? paymentTermDays,
    DateTime? dueDate,
    String? status,
    Value<DateTime?> paidDate = const Value.absent(),
    Value<String?> paymentMethod = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isReverseCharge,
    bool? isIcp,
    Value<String?> reverseChargeNote = const Value.absent(),
    int? totalExclVat,
    int? totalVat,
    int? totalInclVat,
    int? fiscalYear,
    String? quarter,
  }) => Invoice(
    id: id ?? this.id,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    invoiceDate: invoiceDate ?? this.invoiceDate,
    supplyDate: supplyDate.present ? supplyDate.value : this.supplyDate,
    clientId: clientId ?? this.clientId,
    invoiceType: invoiceType ?? this.invoiceType,
    sellerName: sellerName ?? this.sellerName,
    sellerVatNumber: sellerVatNumber ?? this.sellerVatNumber,
    sellerKvkNumber: sellerKvkNumber ?? this.sellerKvkNumber,
    sellerAddress: sellerAddress ?? this.sellerAddress,
    paymentTermDays: paymentTermDays ?? this.paymentTermDays,
    dueDate: dueDate ?? this.dueDate,
    status: status ?? this.status,
    paidDate: paidDate.present ? paidDate.value : this.paidDate,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    notes: notes.present ? notes.value : this.notes,
    isReverseCharge: isReverseCharge ?? this.isReverseCharge,
    isIcp: isIcp ?? this.isIcp,
    reverseChargeNote: reverseChargeNote.present
        ? reverseChargeNote.value
        : this.reverseChargeNote,
    totalExclVat: totalExclVat ?? this.totalExclVat,
    totalVat: totalVat ?? this.totalVat,
    totalInclVat: totalInclVat ?? this.totalInclVat,
    fiscalYear: fiscalYear ?? this.fiscalYear,
    quarter: quarter ?? this.quarter,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      invoiceDate: data.invoiceDate.present
          ? data.invoiceDate.value
          : this.invoiceDate,
      supplyDate: data.supplyDate.present
          ? data.supplyDate.value
          : this.supplyDate,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      invoiceType: data.invoiceType.present
          ? data.invoiceType.value
          : this.invoiceType,
      sellerName: data.sellerName.present
          ? data.sellerName.value
          : this.sellerName,
      sellerVatNumber: data.sellerVatNumber.present
          ? data.sellerVatNumber.value
          : this.sellerVatNumber,
      sellerKvkNumber: data.sellerKvkNumber.present
          ? data.sellerKvkNumber.value
          : this.sellerKvkNumber,
      sellerAddress: data.sellerAddress.present
          ? data.sellerAddress.value
          : this.sellerAddress,
      paymentTermDays: data.paymentTermDays.present
          ? data.paymentTermDays.value
          : this.paymentTermDays,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      status: data.status.present ? data.status.value : this.status,
      paidDate: data.paidDate.present ? data.paidDate.value : this.paidDate,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      notes: data.notes.present ? data.notes.value : this.notes,
      isReverseCharge: data.isReverseCharge.present
          ? data.isReverseCharge.value
          : this.isReverseCharge,
      isIcp: data.isIcp.present ? data.isIcp.value : this.isIcp,
      reverseChargeNote: data.reverseChargeNote.present
          ? data.reverseChargeNote.value
          : this.reverseChargeNote,
      totalExclVat: data.totalExclVat.present
          ? data.totalExclVat.value
          : this.totalExclVat,
      totalVat: data.totalVat.present ? data.totalVat.value : this.totalVat,
      totalInclVat: data.totalInclVat.present
          ? data.totalInclVat.value
          : this.totalInclVat,
      fiscalYear: data.fiscalYear.present
          ? data.fiscalYear.value
          : this.fiscalYear,
      quarter: data.quarter.present ? data.quarter.value : this.quarter,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('supplyDate: $supplyDate, ')
          ..write('clientId: $clientId, ')
          ..write('invoiceType: $invoiceType, ')
          ..write('sellerName: $sellerName, ')
          ..write('sellerVatNumber: $sellerVatNumber, ')
          ..write('sellerKvkNumber: $sellerKvkNumber, ')
          ..write('sellerAddress: $sellerAddress, ')
          ..write('paymentTermDays: $paymentTermDays, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('paidDate: $paidDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('isReverseCharge: $isReverseCharge, ')
          ..write('isIcp: $isIcp, ')
          ..write('reverseChargeNote: $reverseChargeNote, ')
          ..write('totalExclVat: $totalExclVat, ')
          ..write('totalVat: $totalVat, ')
          ..write('totalInclVat: $totalInclVat, ')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('quarter: $quarter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    invoiceNumber,
    invoiceDate,
    supplyDate,
    clientId,
    invoiceType,
    sellerName,
    sellerVatNumber,
    sellerKvkNumber,
    sellerAddress,
    paymentTermDays,
    dueDate,
    status,
    paidDate,
    paymentMethod,
    notes,
    isReverseCharge,
    isIcp,
    reverseChargeNote,
    totalExclVat,
    totalVat,
    totalInclVat,
    fiscalYear,
    quarter,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.invoiceNumber == this.invoiceNumber &&
          other.invoiceDate == this.invoiceDate &&
          other.supplyDate == this.supplyDate &&
          other.clientId == this.clientId &&
          other.invoiceType == this.invoiceType &&
          other.sellerName == this.sellerName &&
          other.sellerVatNumber == this.sellerVatNumber &&
          other.sellerKvkNumber == this.sellerKvkNumber &&
          other.sellerAddress == this.sellerAddress &&
          other.paymentTermDays == this.paymentTermDays &&
          other.dueDate == this.dueDate &&
          other.status == this.status &&
          other.paidDate == this.paidDate &&
          other.paymentMethod == this.paymentMethod &&
          other.notes == this.notes &&
          other.isReverseCharge == this.isReverseCharge &&
          other.isIcp == this.isIcp &&
          other.reverseChargeNote == this.reverseChargeNote &&
          other.totalExclVat == this.totalExclVat &&
          other.totalVat == this.totalVat &&
          other.totalInclVat == this.totalInclVat &&
          other.fiscalYear == this.fiscalYear &&
          other.quarter == this.quarter);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<String> invoiceNumber;
  final Value<DateTime> invoiceDate;
  final Value<DateTime?> supplyDate;
  final Value<int> clientId;
  final Value<String> invoiceType;
  final Value<String> sellerName;
  final Value<String> sellerVatNumber;
  final Value<String> sellerKvkNumber;
  final Value<String> sellerAddress;
  final Value<int> paymentTermDays;
  final Value<DateTime> dueDate;
  final Value<String> status;
  final Value<DateTime?> paidDate;
  final Value<String?> paymentMethod;
  final Value<String?> notes;
  final Value<bool> isReverseCharge;
  final Value<bool> isIcp;
  final Value<String?> reverseChargeNote;
  final Value<int> totalExclVat;
  final Value<int> totalVat;
  final Value<int> totalInclVat;
  final Value<int> fiscalYear;
  final Value<String> quarter;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.invoiceDate = const Value.absent(),
    this.supplyDate = const Value.absent(),
    this.clientId = const Value.absent(),
    this.invoiceType = const Value.absent(),
    this.sellerName = const Value.absent(),
    this.sellerVatNumber = const Value.absent(),
    this.sellerKvkNumber = const Value.absent(),
    this.sellerAddress = const Value.absent(),
    this.paymentTermDays = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.status = const Value.absent(),
    this.paidDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.isReverseCharge = const Value.absent(),
    this.isIcp = const Value.absent(),
    this.reverseChargeNote = const Value.absent(),
    this.totalExclVat = const Value.absent(),
    this.totalVat = const Value.absent(),
    this.totalInclVat = const Value.absent(),
    this.fiscalYear = const Value.absent(),
    this.quarter = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required String invoiceNumber,
    required DateTime invoiceDate,
    this.supplyDate = const Value.absent(),
    required int clientId,
    this.invoiceType = const Value.absent(),
    required String sellerName,
    required String sellerVatNumber,
    required String sellerKvkNumber,
    required String sellerAddress,
    this.paymentTermDays = const Value.absent(),
    required DateTime dueDate,
    this.status = const Value.absent(),
    this.paidDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.isReverseCharge = const Value.absent(),
    this.isIcp = const Value.absent(),
    this.reverseChargeNote = const Value.absent(),
    this.totalExclVat = const Value.absent(),
    this.totalVat = const Value.absent(),
    this.totalInclVat = const Value.absent(),
    required int fiscalYear,
    required String quarter,
  }) : invoiceNumber = Value(invoiceNumber),
       invoiceDate = Value(invoiceDate),
       clientId = Value(clientId),
       sellerName = Value(sellerName),
       sellerVatNumber = Value(sellerVatNumber),
       sellerKvkNumber = Value(sellerKvkNumber),
       sellerAddress = Value(sellerAddress),
       dueDate = Value(dueDate),
       fiscalYear = Value(fiscalYear),
       quarter = Value(quarter);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<String>? invoiceNumber,
    Expression<DateTime>? invoiceDate,
    Expression<DateTime>? supplyDate,
    Expression<int>? clientId,
    Expression<String>? invoiceType,
    Expression<String>? sellerName,
    Expression<String>? sellerVatNumber,
    Expression<String>? sellerKvkNumber,
    Expression<String>? sellerAddress,
    Expression<int>? paymentTermDays,
    Expression<DateTime>? dueDate,
    Expression<String>? status,
    Expression<DateTime>? paidDate,
    Expression<String>? paymentMethod,
    Expression<String>? notes,
    Expression<bool>? isReverseCharge,
    Expression<bool>? isIcp,
    Expression<String>? reverseChargeNote,
    Expression<int>? totalExclVat,
    Expression<int>? totalVat,
    Expression<int>? totalInclVat,
    Expression<int>? fiscalYear,
    Expression<String>? quarter,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (invoiceDate != null) 'invoice_date': invoiceDate,
      if (supplyDate != null) 'supply_date': supplyDate,
      if (clientId != null) 'client_id': clientId,
      if (invoiceType != null) 'invoice_type': invoiceType,
      if (sellerName != null) 'seller_name': sellerName,
      if (sellerVatNumber != null) 'seller_vat_number': sellerVatNumber,
      if (sellerKvkNumber != null) 'seller_kvk_number': sellerKvkNumber,
      if (sellerAddress != null) 'seller_address': sellerAddress,
      if (paymentTermDays != null) 'payment_term_days': paymentTermDays,
      if (dueDate != null) 'due_date': dueDate,
      if (status != null) 'status': status,
      if (paidDate != null) 'paid_date': paidDate,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (notes != null) 'notes': notes,
      if (isReverseCharge != null) 'is_reverse_charge': isReverseCharge,
      if (isIcp != null) 'is_icp': isIcp,
      if (reverseChargeNote != null) 'reverse_charge_note': reverseChargeNote,
      if (totalExclVat != null) 'total_excl_vat': totalExclVat,
      if (totalVat != null) 'total_vat': totalVat,
      if (totalInclVat != null) 'total_incl_vat': totalInclVat,
      if (fiscalYear != null) 'fiscal_year': fiscalYear,
      if (quarter != null) 'quarter': quarter,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? id,
    Value<String>? invoiceNumber,
    Value<DateTime>? invoiceDate,
    Value<DateTime?>? supplyDate,
    Value<int>? clientId,
    Value<String>? invoiceType,
    Value<String>? sellerName,
    Value<String>? sellerVatNumber,
    Value<String>? sellerKvkNumber,
    Value<String>? sellerAddress,
    Value<int>? paymentTermDays,
    Value<DateTime>? dueDate,
    Value<String>? status,
    Value<DateTime?>? paidDate,
    Value<String?>? paymentMethod,
    Value<String?>? notes,
    Value<bool>? isReverseCharge,
    Value<bool>? isIcp,
    Value<String?>? reverseChargeNote,
    Value<int>? totalExclVat,
    Value<int>? totalVat,
    Value<int>? totalInclVat,
    Value<int>? fiscalYear,
    Value<String>? quarter,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      supplyDate: supplyDate ?? this.supplyDate,
      clientId: clientId ?? this.clientId,
      invoiceType: invoiceType ?? this.invoiceType,
      sellerName: sellerName ?? this.sellerName,
      sellerVatNumber: sellerVatNumber ?? this.sellerVatNumber,
      sellerKvkNumber: sellerKvkNumber ?? this.sellerKvkNumber,
      sellerAddress: sellerAddress ?? this.sellerAddress,
      paymentTermDays: paymentTermDays ?? this.paymentTermDays,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      paidDate: paidDate ?? this.paidDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      isReverseCharge: isReverseCharge ?? this.isReverseCharge,
      isIcp: isIcp ?? this.isIcp,
      reverseChargeNote: reverseChargeNote ?? this.reverseChargeNote,
      totalExclVat: totalExclVat ?? this.totalExclVat,
      totalVat: totalVat ?? this.totalVat,
      totalInclVat: totalInclVat ?? this.totalInclVat,
      fiscalYear: fiscalYear ?? this.fiscalYear,
      quarter: quarter ?? this.quarter,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (invoiceDate.present) {
      map['invoice_date'] = Variable<DateTime>(invoiceDate.value);
    }
    if (supplyDate.present) {
      map['supply_date'] = Variable<DateTime>(supplyDate.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (invoiceType.present) {
      map['invoice_type'] = Variable<String>(invoiceType.value);
    }
    if (sellerName.present) {
      map['seller_name'] = Variable<String>(sellerName.value);
    }
    if (sellerVatNumber.present) {
      map['seller_vat_number'] = Variable<String>(sellerVatNumber.value);
    }
    if (sellerKvkNumber.present) {
      map['seller_kvk_number'] = Variable<String>(sellerKvkNumber.value);
    }
    if (sellerAddress.present) {
      map['seller_address'] = Variable<String>(sellerAddress.value);
    }
    if (paymentTermDays.present) {
      map['payment_term_days'] = Variable<int>(paymentTermDays.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (paidDate.present) {
      map['paid_date'] = Variable<DateTime>(paidDate.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isReverseCharge.present) {
      map['is_reverse_charge'] = Variable<bool>(isReverseCharge.value);
    }
    if (isIcp.present) {
      map['is_icp'] = Variable<bool>(isIcp.value);
    }
    if (reverseChargeNote.present) {
      map['reverse_charge_note'] = Variable<String>(reverseChargeNote.value);
    }
    if (totalExclVat.present) {
      map['total_excl_vat'] = Variable<int>(totalExclVat.value);
    }
    if (totalVat.present) {
      map['total_vat'] = Variable<int>(totalVat.value);
    }
    if (totalInclVat.present) {
      map['total_incl_vat'] = Variable<int>(totalInclVat.value);
    }
    if (fiscalYear.present) {
      map['fiscal_year'] = Variable<int>(fiscalYear.value);
    }
    if (quarter.present) {
      map['quarter'] = Variable<String>(quarter.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('supplyDate: $supplyDate, ')
          ..write('clientId: $clientId, ')
          ..write('invoiceType: $invoiceType, ')
          ..write('sellerName: $sellerName, ')
          ..write('sellerVatNumber: $sellerVatNumber, ')
          ..write('sellerKvkNumber: $sellerKvkNumber, ')
          ..write('sellerAddress: $sellerAddress, ')
          ..write('paymentTermDays: $paymentTermDays, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('paidDate: $paidDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('isReverseCharge: $isReverseCharge, ')
          ..write('isIcp: $isIcp, ')
          ..write('reverseChargeNote: $reverseChargeNote, ')
          ..write('totalExclVat: $totalExclVat, ')
          ..write('totalVat: $totalVat, ')
          ..write('totalInclVat: $totalInclVat, ')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('quarter: $quarter')
          ..write(')'))
        .toString();
  }
}

class $InvoiceLinesTable extends InvoiceLines
    with TableInfo<$InvoiceLinesTable, InvoiceLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityUnitMeta = const VerificationMeta(
    'quantityUnit',
  );
  @override
  late final GeneratedColumn<String> quantityUnit = GeneratedColumn<String>(
    'quantity_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('1'),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _unitPriceExclVatMeta = const VerificationMeta(
    'unitPriceExclVat',
  );
  @override
  late final GeneratedColumn<int> unitPriceExclVat = GeneratedColumn<int>(
    'unit_price_excl_vat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatRateMeta = const VerificationMeta(
    'vatRate',
  );
  @override
  late final GeneratedColumn<String> vatRate = GeneratedColumn<String>(
    'vat_rate',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('21%'),
  );
  static const VerificationMeta _vatAmountMeta = const VerificationMeta(
    'vatAmount',
  );
  @override
  late final GeneratedColumn<int> vatAmount = GeneratedColumn<int>(
    'vat_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lineTotalExclVatMeta = const VerificationMeta(
    'lineTotalExclVat',
  );
  @override
  late final GeneratedColumn<int> lineTotalExclVat = GeneratedColumn<int>(
    'line_total_excl_vat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    description,
    quantityUnit,
    quantity,
    unitPriceExclVat,
    vatRate,
    vatAmount,
    lineTotalExclVat,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity_unit')) {
      context.handle(
        _quantityUnitMeta,
        quantityUnit.isAcceptableOrUnknown(
          data['quantity_unit']!,
          _quantityUnitMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_price_excl_vat')) {
      context.handle(
        _unitPriceExclVatMeta,
        unitPriceExclVat.isAcceptableOrUnknown(
          data['unit_price_excl_vat']!,
          _unitPriceExclVatMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitPriceExclVatMeta);
    }
    if (data.containsKey('vat_rate')) {
      context.handle(
        _vatRateMeta,
        vatRate.isAcceptableOrUnknown(data['vat_rate']!, _vatRateMeta),
      );
    }
    if (data.containsKey('vat_amount')) {
      context.handle(
        _vatAmountMeta,
        vatAmount.isAcceptableOrUnknown(data['vat_amount']!, _vatAmountMeta),
      );
    }
    if (data.containsKey('line_total_excl_vat')) {
      context.handle(
        _lineTotalExclVatMeta,
        lineTotalExclVat.isAcceptableOrUnknown(
          data['line_total_excl_vat']!,
          _lineTotalExclVatMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceLine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantityUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quantity_unit'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitPriceExclVat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_excl_vat'],
      )!,
      vatRate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vat_rate'],
      )!,
      vatAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vat_amount'],
      )!,
      lineTotalExclVat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_total_excl_vat'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $InvoiceLinesTable createAlias(String alias) {
    return $InvoiceLinesTable(attachedDatabase, alias);
  }
}

class InvoiceLine extends DataClass implements Insertable<InvoiceLine> {
  final int id;
  final int invoiceId;
  final String description;
  final String quantityUnit;
  final double quantity;
  final int unitPriceExclVat;
  final String vatRate;
  final int vatAmount;
  final int lineTotalExclVat;
  final int sortOrder;
  const InvoiceLine({
    required this.id,
    required this.invoiceId,
    required this.description,
    required this.quantityUnit,
    required this.quantity,
    required this.unitPriceExclVat,
    required this.vatRate,
    required this.vatAmount,
    required this.lineTotalExclVat,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['description'] = Variable<String>(description);
    map['quantity_unit'] = Variable<String>(quantityUnit);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price_excl_vat'] = Variable<int>(unitPriceExclVat);
    map['vat_rate'] = Variable<String>(vatRate);
    map['vat_amount'] = Variable<int>(vatAmount);
    map['line_total_excl_vat'] = Variable<int>(lineTotalExclVat);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  InvoiceLinesCompanion toCompanion(bool nullToAbsent) {
    return InvoiceLinesCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      description: Value(description),
      quantityUnit: Value(quantityUnit),
      quantity: Value(quantity),
      unitPriceExclVat: Value(unitPriceExclVat),
      vatRate: Value(vatRate),
      vatAmount: Value(vatAmount),
      lineTotalExclVat: Value(lineTotalExclVat),
      sortOrder: Value(sortOrder),
    );
  }

  factory InvoiceLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceLine(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      description: serializer.fromJson<String>(json['description']),
      quantityUnit: serializer.fromJson<String>(json['quantityUnit']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPriceExclVat: serializer.fromJson<int>(json['unitPriceExclVat']),
      vatRate: serializer.fromJson<String>(json['vatRate']),
      vatAmount: serializer.fromJson<int>(json['vatAmount']),
      lineTotalExclVat: serializer.fromJson<int>(json['lineTotalExclVat']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'description': serializer.toJson<String>(description),
      'quantityUnit': serializer.toJson<String>(quantityUnit),
      'quantity': serializer.toJson<double>(quantity),
      'unitPriceExclVat': serializer.toJson<int>(unitPriceExclVat),
      'vatRate': serializer.toJson<String>(vatRate),
      'vatAmount': serializer.toJson<int>(vatAmount),
      'lineTotalExclVat': serializer.toJson<int>(lineTotalExclVat),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  InvoiceLine copyWith({
    int? id,
    int? invoiceId,
    String? description,
    String? quantityUnit,
    double? quantity,
    int? unitPriceExclVat,
    String? vatRate,
    int? vatAmount,
    int? lineTotalExclVat,
    int? sortOrder,
  }) => InvoiceLine(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    description: description ?? this.description,
    quantityUnit: quantityUnit ?? this.quantityUnit,
    quantity: quantity ?? this.quantity,
    unitPriceExclVat: unitPriceExclVat ?? this.unitPriceExclVat,
    vatRate: vatRate ?? this.vatRate,
    vatAmount: vatAmount ?? this.vatAmount,
    lineTotalExclVat: lineTotalExclVat ?? this.lineTotalExclVat,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  InvoiceLine copyWithCompanion(InvoiceLinesCompanion data) {
    return InvoiceLine(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantityUnit: data.quantityUnit.present
          ? data.quantityUnit.value
          : this.quantityUnit,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPriceExclVat: data.unitPriceExclVat.present
          ? data.unitPriceExclVat.value
          : this.unitPriceExclVat,
      vatRate: data.vatRate.present ? data.vatRate.value : this.vatRate,
      vatAmount: data.vatAmount.present ? data.vatAmount.value : this.vatAmount,
      lineTotalExclVat: data.lineTotalExclVat.present
          ? data.lineTotalExclVat.value
          : this.lineTotalExclVat,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceLine(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('description: $description, ')
          ..write('quantityUnit: $quantityUnit, ')
          ..write('quantity: $quantity, ')
          ..write('unitPriceExclVat: $unitPriceExclVat, ')
          ..write('vatRate: $vatRate, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('lineTotalExclVat: $lineTotalExclVat, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    description,
    quantityUnit,
    quantity,
    unitPriceExclVat,
    vatRate,
    vatAmount,
    lineTotalExclVat,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceLine &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.description == this.description &&
          other.quantityUnit == this.quantityUnit &&
          other.quantity == this.quantity &&
          other.unitPriceExclVat == this.unitPriceExclVat &&
          other.vatRate == this.vatRate &&
          other.vatAmount == this.vatAmount &&
          other.lineTotalExclVat == this.lineTotalExclVat &&
          other.sortOrder == this.sortOrder);
}

class InvoiceLinesCompanion extends UpdateCompanion<InvoiceLine> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<String> description;
  final Value<String> quantityUnit;
  final Value<double> quantity;
  final Value<int> unitPriceExclVat;
  final Value<String> vatRate;
  final Value<int> vatAmount;
  final Value<int> lineTotalExclVat;
  final Value<int> sortOrder;
  const InvoiceLinesCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantityUnit = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPriceExclVat = const Value.absent(),
    this.vatRate = const Value.absent(),
    this.vatAmount = const Value.absent(),
    this.lineTotalExclVat = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  InvoiceLinesCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required String description,
    this.quantityUnit = const Value.absent(),
    this.quantity = const Value.absent(),
    required int unitPriceExclVat,
    this.vatRate = const Value.absent(),
    this.vatAmount = const Value.absent(),
    this.lineTotalExclVat = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       description = Value(description),
       unitPriceExclVat = Value(unitPriceExclVat);
  static Insertable<InvoiceLine> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<String>? description,
    Expression<String>? quantityUnit,
    Expression<double>? quantity,
    Expression<int>? unitPriceExclVat,
    Expression<String>? vatRate,
    Expression<int>? vatAmount,
    Expression<int>? lineTotalExclVat,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (description != null) 'description': description,
      if (quantityUnit != null) 'quantity_unit': quantityUnit,
      if (quantity != null) 'quantity': quantity,
      if (unitPriceExclVat != null) 'unit_price_excl_vat': unitPriceExclVat,
      if (vatRate != null) 'vat_rate': vatRate,
      if (vatAmount != null) 'vat_amount': vatAmount,
      if (lineTotalExclVat != null) 'line_total_excl_vat': lineTotalExclVat,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  InvoiceLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<String>? description,
    Value<String>? quantityUnit,
    Value<double>? quantity,
    Value<int>? unitPriceExclVat,
    Value<String>? vatRate,
    Value<int>? vatAmount,
    Value<int>? lineTotalExclVat,
    Value<int>? sortOrder,
  }) {
    return InvoiceLinesCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      description: description ?? this.description,
      quantityUnit: quantityUnit ?? this.quantityUnit,
      quantity: quantity ?? this.quantity,
      unitPriceExclVat: unitPriceExclVat ?? this.unitPriceExclVat,
      vatRate: vatRate ?? this.vatRate,
      vatAmount: vatAmount ?? this.vatAmount,
      lineTotalExclVat: lineTotalExclVat ?? this.lineTotalExclVat,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantityUnit.present) {
      map['quantity_unit'] = Variable<String>(quantityUnit.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPriceExclVat.present) {
      map['unit_price_excl_vat'] = Variable<int>(unitPriceExclVat.value);
    }
    if (vatRate.present) {
      map['vat_rate'] = Variable<String>(vatRate.value);
    }
    if (vatAmount.present) {
      map['vat_amount'] = Variable<int>(vatAmount.value);
    }
    if (lineTotalExclVat.present) {
      map['line_total_excl_vat'] = Variable<int>(lineTotalExclVat.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceLinesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('description: $description, ')
          ..write('quantityUnit: $quantityUnit, ')
          ..write('quantity: $quantity, ')
          ..write('unitPriceExclVat: $unitPriceExclVat, ')
          ..write('vatRate: $vatRate, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('lineTotalExclVat: $lineTotalExclVat, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierMeta = const VerificationMeta(
    'supplier',
  );
  @override
  late final GeneratedColumn<String> supplier = GeneratedColumn<String>(
    'supplier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiptAttachedMeta = const VerificationMeta(
    'receiptAttached',
  );
  @override
  late final GeneratedColumn<bool> receiptAttached = GeneratedColumn<bool>(
    'receipt_attached',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("receipt_attached" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _amountExclVatMeta = const VerificationMeta(
    'amountExclVat',
  );
  @override
  late final GeneratedColumn<int> amountExclVat = GeneratedColumn<int>(
    'amount_excl_vat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatRateMeta = const VerificationMeta(
    'vatRate',
  );
  @override
  late final GeneratedColumn<String> vatRate = GeneratedColumn<String>(
    'vat_rate',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('21%'),
  );
  static const VerificationMeta _vatAmountMeta = const VerificationMeta(
    'vatAmount',
  );
  @override
  late final GeneratedColumn<int> vatAmount = GeneratedColumn<int>(
    'vat_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalInclVatMeta = const VerificationMeta(
    'totalInclVat',
  );
  @override
  late final GeneratedColumn<int> totalInclVat = GeneratedColumn<int>(
    'total_incl_vat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _businessUsePctMeta = const VerificationMeta(
    'businessUsePct',
  );
  @override
  late final GeneratedColumn<double> businessUsePct = GeneratedColumn<double>(
    'business_use_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _deductibleAmountMeta = const VerificationMeta(
    'deductibleAmount',
  );
  @override
  late final GeneratedColumn<int> deductibleAmount = GeneratedColumn<int>(
    'deductible_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _vatReclaimableMeta = const VerificationMeta(
    'vatReclaimable',
  );
  @override
  late final GeneratedColumn<bool> vatReclaimable = GeneratedColumn<bool>(
    'vat_reclaimable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("vat_reclaimable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _vatToReclaimMeta = const VerificationMeta(
    'vatToReclaim',
  );
  @override
  late final GeneratedColumn<int> vatToReclaim = GeneratedColumn<int>(
    'vat_to_reclaim',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isMixedCostMeta = const VerificationMeta(
    'isMixedCost',
  );
  @override
  late final GeneratedColumn<bool> isMixedCost = GeneratedColumn<bool>(
    'is_mixed_cost',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_mixed_cost" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paidFromMeta = const VerificationMeta(
    'paidFrom',
  );
  @override
  late final GeneratedColumn<String> paidFrom = GeneratedColumn<String>(
    'paid_from',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentReferenceMeta = const VerificationMeta(
    'paymentReference',
  );
  @override
  late final GeneratedColumn<String> paymentReference = GeneratedColumn<String>(
    'payment_reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fiscalYearMeta = const VerificationMeta(
    'fiscalYear',
  );
  @override
  late final GeneratedColumn<int> fiscalYear = GeneratedColumn<int>(
    'fiscal_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quarterMeta = const VerificationMeta(
    'quarter',
  );
  @override
  late final GeneratedColumn<String> quarter = GeneratedColumn<String>(
    'quarter',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    supplier,
    description,
    category,
    receiptAttached,
    amountExclVat,
    vatRate,
    vatAmount,
    totalInclVat,
    businessUsePct,
    deductibleAmount,
    vatReclaimable,
    vatToReclaim,
    isMixedCost,
    notes,
    paidFrom,
    paymentReference,
    fiscalYear,
    quarter,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('supplier')) {
      context.handle(
        _supplierMeta,
        supplier.isAcceptableOrUnknown(data['supplier']!, _supplierMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('receipt_attached')) {
      context.handle(
        _receiptAttachedMeta,
        receiptAttached.isAcceptableOrUnknown(
          data['receipt_attached']!,
          _receiptAttachedMeta,
        ),
      );
    }
    if (data.containsKey('amount_excl_vat')) {
      context.handle(
        _amountExclVatMeta,
        amountExclVat.isAcceptableOrUnknown(
          data['amount_excl_vat']!,
          _amountExclVatMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountExclVatMeta);
    }
    if (data.containsKey('vat_rate')) {
      context.handle(
        _vatRateMeta,
        vatRate.isAcceptableOrUnknown(data['vat_rate']!, _vatRateMeta),
      );
    }
    if (data.containsKey('vat_amount')) {
      context.handle(
        _vatAmountMeta,
        vatAmount.isAcceptableOrUnknown(data['vat_amount']!, _vatAmountMeta),
      );
    }
    if (data.containsKey('total_incl_vat')) {
      context.handle(
        _totalInclVatMeta,
        totalInclVat.isAcceptableOrUnknown(
          data['total_incl_vat']!,
          _totalInclVatMeta,
        ),
      );
    }
    if (data.containsKey('business_use_pct')) {
      context.handle(
        _businessUsePctMeta,
        businessUsePct.isAcceptableOrUnknown(
          data['business_use_pct']!,
          _businessUsePctMeta,
        ),
      );
    }
    if (data.containsKey('deductible_amount')) {
      context.handle(
        _deductibleAmountMeta,
        deductibleAmount.isAcceptableOrUnknown(
          data['deductible_amount']!,
          _deductibleAmountMeta,
        ),
      );
    }
    if (data.containsKey('vat_reclaimable')) {
      context.handle(
        _vatReclaimableMeta,
        vatReclaimable.isAcceptableOrUnknown(
          data['vat_reclaimable']!,
          _vatReclaimableMeta,
        ),
      );
    }
    if (data.containsKey('vat_to_reclaim')) {
      context.handle(
        _vatToReclaimMeta,
        vatToReclaim.isAcceptableOrUnknown(
          data['vat_to_reclaim']!,
          _vatToReclaimMeta,
        ),
      );
    }
    if (data.containsKey('is_mixed_cost')) {
      context.handle(
        _isMixedCostMeta,
        isMixedCost.isAcceptableOrUnknown(
          data['is_mixed_cost']!,
          _isMixedCostMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('paid_from')) {
      context.handle(
        _paidFromMeta,
        paidFrom.isAcceptableOrUnknown(data['paid_from']!, _paidFromMeta),
      );
    }
    if (data.containsKey('payment_reference')) {
      context.handle(
        _paymentReferenceMeta,
        paymentReference.isAcceptableOrUnknown(
          data['payment_reference']!,
          _paymentReferenceMeta,
        ),
      );
    }
    if (data.containsKey('fiscal_year')) {
      context.handle(
        _fiscalYearMeta,
        fiscalYear.isAcceptableOrUnknown(data['fiscal_year']!, _fiscalYearMeta),
      );
    } else if (isInserting) {
      context.missing(_fiscalYearMeta);
    }
    if (data.containsKey('quarter')) {
      context.handle(
        _quarterMeta,
        quarter.isAcceptableOrUnknown(data['quarter']!, _quarterMeta),
      );
    } else if (isInserting) {
      context.missing(_quarterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      supplier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      receiptAttached: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}receipt_attached'],
      )!,
      amountExclVat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_excl_vat'],
      )!,
      vatRate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vat_rate'],
      )!,
      vatAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vat_amount'],
      )!,
      totalInclVat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_incl_vat'],
      )!,
      businessUsePct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}business_use_pct'],
      )!,
      deductibleAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deductible_amount'],
      )!,
      vatReclaimable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}vat_reclaimable'],
      )!,
      vatToReclaim: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vat_to_reclaim'],
      )!,
      isMixedCost: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_mixed_cost'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      paidFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paid_from'],
      ),
      paymentReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_reference'],
      ),
      fiscalYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fiscal_year'],
      )!,
      quarter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quarter'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final DateTime date;
  final String supplier;
  final String description;
  final String category;
  final bool receiptAttached;
  final int amountExclVat;
  final String vatRate;
  final int vatAmount;
  final int totalInclVat;
  final double businessUsePct;
  final int deductibleAmount;
  final bool vatReclaimable;
  final int vatToReclaim;
  final bool isMixedCost;
  final String? notes;
  final String? paidFrom;
  final String? paymentReference;
  final int fiscalYear;
  final String quarter;
  const Expense({
    required this.id,
    required this.date,
    required this.supplier,
    required this.description,
    required this.category,
    required this.receiptAttached,
    required this.amountExclVat,
    required this.vatRate,
    required this.vatAmount,
    required this.totalInclVat,
    required this.businessUsePct,
    required this.deductibleAmount,
    required this.vatReclaimable,
    required this.vatToReclaim,
    required this.isMixedCost,
    this.notes,
    this.paidFrom,
    this.paymentReference,
    required this.fiscalYear,
    required this.quarter,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['supplier'] = Variable<String>(supplier);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    map['receipt_attached'] = Variable<bool>(receiptAttached);
    map['amount_excl_vat'] = Variable<int>(amountExclVat);
    map['vat_rate'] = Variable<String>(vatRate);
    map['vat_amount'] = Variable<int>(vatAmount);
    map['total_incl_vat'] = Variable<int>(totalInclVat);
    map['business_use_pct'] = Variable<double>(businessUsePct);
    map['deductible_amount'] = Variable<int>(deductibleAmount);
    map['vat_reclaimable'] = Variable<bool>(vatReclaimable);
    map['vat_to_reclaim'] = Variable<int>(vatToReclaim);
    map['is_mixed_cost'] = Variable<bool>(isMixedCost);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || paidFrom != null) {
      map['paid_from'] = Variable<String>(paidFrom);
    }
    if (!nullToAbsent || paymentReference != null) {
      map['payment_reference'] = Variable<String>(paymentReference);
    }
    map['fiscal_year'] = Variable<int>(fiscalYear);
    map['quarter'] = Variable<String>(quarter);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      date: Value(date),
      supplier: Value(supplier),
      description: Value(description),
      category: Value(category),
      receiptAttached: Value(receiptAttached),
      amountExclVat: Value(amountExclVat),
      vatRate: Value(vatRate),
      vatAmount: Value(vatAmount),
      totalInclVat: Value(totalInclVat),
      businessUsePct: Value(businessUsePct),
      deductibleAmount: Value(deductibleAmount),
      vatReclaimable: Value(vatReclaimable),
      vatToReclaim: Value(vatToReclaim),
      isMixedCost: Value(isMixedCost),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      paidFrom: paidFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(paidFrom),
      paymentReference: paymentReference == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentReference),
      fiscalYear: Value(fiscalYear),
      quarter: Value(quarter),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      supplier: serializer.fromJson<String>(json['supplier']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      receiptAttached: serializer.fromJson<bool>(json['receiptAttached']),
      amountExclVat: serializer.fromJson<int>(json['amountExclVat']),
      vatRate: serializer.fromJson<String>(json['vatRate']),
      vatAmount: serializer.fromJson<int>(json['vatAmount']),
      totalInclVat: serializer.fromJson<int>(json['totalInclVat']),
      businessUsePct: serializer.fromJson<double>(json['businessUsePct']),
      deductibleAmount: serializer.fromJson<int>(json['deductibleAmount']),
      vatReclaimable: serializer.fromJson<bool>(json['vatReclaimable']),
      vatToReclaim: serializer.fromJson<int>(json['vatToReclaim']),
      isMixedCost: serializer.fromJson<bool>(json['isMixedCost']),
      notes: serializer.fromJson<String?>(json['notes']),
      paidFrom: serializer.fromJson<String?>(json['paidFrom']),
      paymentReference: serializer.fromJson<String?>(json['paymentReference']),
      fiscalYear: serializer.fromJson<int>(json['fiscalYear']),
      quarter: serializer.fromJson<String>(json['quarter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'supplier': serializer.toJson<String>(supplier),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'receiptAttached': serializer.toJson<bool>(receiptAttached),
      'amountExclVat': serializer.toJson<int>(amountExclVat),
      'vatRate': serializer.toJson<String>(vatRate),
      'vatAmount': serializer.toJson<int>(vatAmount),
      'totalInclVat': serializer.toJson<int>(totalInclVat),
      'businessUsePct': serializer.toJson<double>(businessUsePct),
      'deductibleAmount': serializer.toJson<int>(deductibleAmount),
      'vatReclaimable': serializer.toJson<bool>(vatReclaimable),
      'vatToReclaim': serializer.toJson<int>(vatToReclaim),
      'isMixedCost': serializer.toJson<bool>(isMixedCost),
      'notes': serializer.toJson<String?>(notes),
      'paidFrom': serializer.toJson<String?>(paidFrom),
      'paymentReference': serializer.toJson<String?>(paymentReference),
      'fiscalYear': serializer.toJson<int>(fiscalYear),
      'quarter': serializer.toJson<String>(quarter),
    };
  }

  Expense copyWith({
    int? id,
    DateTime? date,
    String? supplier,
    String? description,
    String? category,
    bool? receiptAttached,
    int? amountExclVat,
    String? vatRate,
    int? vatAmount,
    int? totalInclVat,
    double? businessUsePct,
    int? deductibleAmount,
    bool? vatReclaimable,
    int? vatToReclaim,
    bool? isMixedCost,
    Value<String?> notes = const Value.absent(),
    Value<String?> paidFrom = const Value.absent(),
    Value<String?> paymentReference = const Value.absent(),
    int? fiscalYear,
    String? quarter,
  }) => Expense(
    id: id ?? this.id,
    date: date ?? this.date,
    supplier: supplier ?? this.supplier,
    description: description ?? this.description,
    category: category ?? this.category,
    receiptAttached: receiptAttached ?? this.receiptAttached,
    amountExclVat: amountExclVat ?? this.amountExclVat,
    vatRate: vatRate ?? this.vatRate,
    vatAmount: vatAmount ?? this.vatAmount,
    totalInclVat: totalInclVat ?? this.totalInclVat,
    businessUsePct: businessUsePct ?? this.businessUsePct,
    deductibleAmount: deductibleAmount ?? this.deductibleAmount,
    vatReclaimable: vatReclaimable ?? this.vatReclaimable,
    vatToReclaim: vatToReclaim ?? this.vatToReclaim,
    isMixedCost: isMixedCost ?? this.isMixedCost,
    notes: notes.present ? notes.value : this.notes,
    paidFrom: paidFrom.present ? paidFrom.value : this.paidFrom,
    paymentReference: paymentReference.present
        ? paymentReference.value
        : this.paymentReference,
    fiscalYear: fiscalYear ?? this.fiscalYear,
    quarter: quarter ?? this.quarter,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      supplier: data.supplier.present ? data.supplier.value : this.supplier,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      receiptAttached: data.receiptAttached.present
          ? data.receiptAttached.value
          : this.receiptAttached,
      amountExclVat: data.amountExclVat.present
          ? data.amountExclVat.value
          : this.amountExclVat,
      vatRate: data.vatRate.present ? data.vatRate.value : this.vatRate,
      vatAmount: data.vatAmount.present ? data.vatAmount.value : this.vatAmount,
      totalInclVat: data.totalInclVat.present
          ? data.totalInclVat.value
          : this.totalInclVat,
      businessUsePct: data.businessUsePct.present
          ? data.businessUsePct.value
          : this.businessUsePct,
      deductibleAmount: data.deductibleAmount.present
          ? data.deductibleAmount.value
          : this.deductibleAmount,
      vatReclaimable: data.vatReclaimable.present
          ? data.vatReclaimable.value
          : this.vatReclaimable,
      vatToReclaim: data.vatToReclaim.present
          ? data.vatToReclaim.value
          : this.vatToReclaim,
      isMixedCost: data.isMixedCost.present
          ? data.isMixedCost.value
          : this.isMixedCost,
      notes: data.notes.present ? data.notes.value : this.notes,
      paidFrom: data.paidFrom.present ? data.paidFrom.value : this.paidFrom,
      paymentReference: data.paymentReference.present
          ? data.paymentReference.value
          : this.paymentReference,
      fiscalYear: data.fiscalYear.present
          ? data.fiscalYear.value
          : this.fiscalYear,
      quarter: data.quarter.present ? data.quarter.value : this.quarter,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('supplier: $supplier, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('receiptAttached: $receiptAttached, ')
          ..write('amountExclVat: $amountExclVat, ')
          ..write('vatRate: $vatRate, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('totalInclVat: $totalInclVat, ')
          ..write('businessUsePct: $businessUsePct, ')
          ..write('deductibleAmount: $deductibleAmount, ')
          ..write('vatReclaimable: $vatReclaimable, ')
          ..write('vatToReclaim: $vatToReclaim, ')
          ..write('isMixedCost: $isMixedCost, ')
          ..write('notes: $notes, ')
          ..write('paidFrom: $paidFrom, ')
          ..write('paymentReference: $paymentReference, ')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('quarter: $quarter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    supplier,
    description,
    category,
    receiptAttached,
    amountExclVat,
    vatRate,
    vatAmount,
    totalInclVat,
    businessUsePct,
    deductibleAmount,
    vatReclaimable,
    vatToReclaim,
    isMixedCost,
    notes,
    paidFrom,
    paymentReference,
    fiscalYear,
    quarter,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.date == this.date &&
          other.supplier == this.supplier &&
          other.description == this.description &&
          other.category == this.category &&
          other.receiptAttached == this.receiptAttached &&
          other.amountExclVat == this.amountExclVat &&
          other.vatRate == this.vatRate &&
          other.vatAmount == this.vatAmount &&
          other.totalInclVat == this.totalInclVat &&
          other.businessUsePct == this.businessUsePct &&
          other.deductibleAmount == this.deductibleAmount &&
          other.vatReclaimable == this.vatReclaimable &&
          other.vatToReclaim == this.vatToReclaim &&
          other.isMixedCost == this.isMixedCost &&
          other.notes == this.notes &&
          other.paidFrom == this.paidFrom &&
          other.paymentReference == this.paymentReference &&
          other.fiscalYear == this.fiscalYear &&
          other.quarter == this.quarter);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> supplier;
  final Value<String> description;
  final Value<String> category;
  final Value<bool> receiptAttached;
  final Value<int> amountExclVat;
  final Value<String> vatRate;
  final Value<int> vatAmount;
  final Value<int> totalInclVat;
  final Value<double> businessUsePct;
  final Value<int> deductibleAmount;
  final Value<bool> vatReclaimable;
  final Value<int> vatToReclaim;
  final Value<bool> isMixedCost;
  final Value<String?> notes;
  final Value<String?> paidFrom;
  final Value<String?> paymentReference;
  final Value<int> fiscalYear;
  final Value<String> quarter;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.supplier = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.receiptAttached = const Value.absent(),
    this.amountExclVat = const Value.absent(),
    this.vatRate = const Value.absent(),
    this.vatAmount = const Value.absent(),
    this.totalInclVat = const Value.absent(),
    this.businessUsePct = const Value.absent(),
    this.deductibleAmount = const Value.absent(),
    this.vatReclaimable = const Value.absent(),
    this.vatToReclaim = const Value.absent(),
    this.isMixedCost = const Value.absent(),
    this.notes = const Value.absent(),
    this.paidFrom = const Value.absent(),
    this.paymentReference = const Value.absent(),
    this.fiscalYear = const Value.absent(),
    this.quarter = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String supplier,
    required String description,
    required String category,
    this.receiptAttached = const Value.absent(),
    required int amountExclVat,
    this.vatRate = const Value.absent(),
    this.vatAmount = const Value.absent(),
    this.totalInclVat = const Value.absent(),
    this.businessUsePct = const Value.absent(),
    this.deductibleAmount = const Value.absent(),
    this.vatReclaimable = const Value.absent(),
    this.vatToReclaim = const Value.absent(),
    this.isMixedCost = const Value.absent(),
    this.notes = const Value.absent(),
    this.paidFrom = const Value.absent(),
    this.paymentReference = const Value.absent(),
    required int fiscalYear,
    required String quarter,
  }) : date = Value(date),
       supplier = Value(supplier),
       description = Value(description),
       category = Value(category),
       amountExclVat = Value(amountExclVat),
       fiscalYear = Value(fiscalYear),
       quarter = Value(quarter);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? supplier,
    Expression<String>? description,
    Expression<String>? category,
    Expression<bool>? receiptAttached,
    Expression<int>? amountExclVat,
    Expression<String>? vatRate,
    Expression<int>? vatAmount,
    Expression<int>? totalInclVat,
    Expression<double>? businessUsePct,
    Expression<int>? deductibleAmount,
    Expression<bool>? vatReclaimable,
    Expression<int>? vatToReclaim,
    Expression<bool>? isMixedCost,
    Expression<String>? notes,
    Expression<String>? paidFrom,
    Expression<String>? paymentReference,
    Expression<int>? fiscalYear,
    Expression<String>? quarter,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (supplier != null) 'supplier': supplier,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (receiptAttached != null) 'receipt_attached': receiptAttached,
      if (amountExclVat != null) 'amount_excl_vat': amountExclVat,
      if (vatRate != null) 'vat_rate': vatRate,
      if (vatAmount != null) 'vat_amount': vatAmount,
      if (totalInclVat != null) 'total_incl_vat': totalInclVat,
      if (businessUsePct != null) 'business_use_pct': businessUsePct,
      if (deductibleAmount != null) 'deductible_amount': deductibleAmount,
      if (vatReclaimable != null) 'vat_reclaimable': vatReclaimable,
      if (vatToReclaim != null) 'vat_to_reclaim': vatToReclaim,
      if (isMixedCost != null) 'is_mixed_cost': isMixedCost,
      if (notes != null) 'notes': notes,
      if (paidFrom != null) 'paid_from': paidFrom,
      if (paymentReference != null) 'payment_reference': paymentReference,
      if (fiscalYear != null) 'fiscal_year': fiscalYear,
      if (quarter != null) 'quarter': quarter,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? supplier,
    Value<String>? description,
    Value<String>? category,
    Value<bool>? receiptAttached,
    Value<int>? amountExclVat,
    Value<String>? vatRate,
    Value<int>? vatAmount,
    Value<int>? totalInclVat,
    Value<double>? businessUsePct,
    Value<int>? deductibleAmount,
    Value<bool>? vatReclaimable,
    Value<int>? vatToReclaim,
    Value<bool>? isMixedCost,
    Value<String?>? notes,
    Value<String?>? paidFrom,
    Value<String?>? paymentReference,
    Value<int>? fiscalYear,
    Value<String>? quarter,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      supplier: supplier ?? this.supplier,
      description: description ?? this.description,
      category: category ?? this.category,
      receiptAttached: receiptAttached ?? this.receiptAttached,
      amountExclVat: amountExclVat ?? this.amountExclVat,
      vatRate: vatRate ?? this.vatRate,
      vatAmount: vatAmount ?? this.vatAmount,
      totalInclVat: totalInclVat ?? this.totalInclVat,
      businessUsePct: businessUsePct ?? this.businessUsePct,
      deductibleAmount: deductibleAmount ?? this.deductibleAmount,
      vatReclaimable: vatReclaimable ?? this.vatReclaimable,
      vatToReclaim: vatToReclaim ?? this.vatToReclaim,
      isMixedCost: isMixedCost ?? this.isMixedCost,
      notes: notes ?? this.notes,
      paidFrom: paidFrom ?? this.paidFrom,
      paymentReference: paymentReference ?? this.paymentReference,
      fiscalYear: fiscalYear ?? this.fiscalYear,
      quarter: quarter ?? this.quarter,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (supplier.present) {
      map['supplier'] = Variable<String>(supplier.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (receiptAttached.present) {
      map['receipt_attached'] = Variable<bool>(receiptAttached.value);
    }
    if (amountExclVat.present) {
      map['amount_excl_vat'] = Variable<int>(amountExclVat.value);
    }
    if (vatRate.present) {
      map['vat_rate'] = Variable<String>(vatRate.value);
    }
    if (vatAmount.present) {
      map['vat_amount'] = Variable<int>(vatAmount.value);
    }
    if (totalInclVat.present) {
      map['total_incl_vat'] = Variable<int>(totalInclVat.value);
    }
    if (businessUsePct.present) {
      map['business_use_pct'] = Variable<double>(businessUsePct.value);
    }
    if (deductibleAmount.present) {
      map['deductible_amount'] = Variable<int>(deductibleAmount.value);
    }
    if (vatReclaimable.present) {
      map['vat_reclaimable'] = Variable<bool>(vatReclaimable.value);
    }
    if (vatToReclaim.present) {
      map['vat_to_reclaim'] = Variable<int>(vatToReclaim.value);
    }
    if (isMixedCost.present) {
      map['is_mixed_cost'] = Variable<bool>(isMixedCost.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (paidFrom.present) {
      map['paid_from'] = Variable<String>(paidFrom.value);
    }
    if (paymentReference.present) {
      map['payment_reference'] = Variable<String>(paymentReference.value);
    }
    if (fiscalYear.present) {
      map['fiscal_year'] = Variable<int>(fiscalYear.value);
    }
    if (quarter.present) {
      map['quarter'] = Variable<String>(quarter.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('supplier: $supplier, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('receiptAttached: $receiptAttached, ')
          ..write('amountExclVat: $amountExclVat, ')
          ..write('vatRate: $vatRate, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('totalInclVat: $totalInclVat, ')
          ..write('businessUsePct: $businessUsePct, ')
          ..write('deductibleAmount: $deductibleAmount, ')
          ..write('vatReclaimable: $vatReclaimable, ')
          ..write('vatToReclaim: $vatToReclaim, ')
          ..write('isMixedCost: $isMixedCost, ')
          ..write('notes: $notes, ')
          ..write('paidFrom: $paidFrom, ')
          ..write('paymentReference: $paymentReference, ')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('quarter: $quarter')
          ..write(')'))
        .toString();
  }
}

class $HourEntriesTable extends HourEntries
    with TableInfo<$HourEntriesTable, HourEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HourEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workTypeMeta = const VerificationMeta(
    'workType',
  );
  @override
  late final GeneratedColumn<String> workType = GeneratedColumn<String>(
    'work_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hoursMeta = const VerificationMeta('hours');
  @override
  late final GeneratedColumn<double> hours = GeneratedColumn<double>(
    'hours',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billableMeta = const VerificationMeta(
    'billable',
  );
  @override
  late final GeneratedColumn<bool> billable = GeneratedColumn<bool>(
    'billable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("billable" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _clientProjectMeta = const VerificationMeta(
    'clientProject',
  );
  @override
  late final GeneratedColumn<String> clientProject = GeneratedColumn<String>(
    'client_project',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isWbsoMeta = const VerificationMeta('isWbso');
  @override
  late final GeneratedColumn<bool> isWbso = GeneratedColumn<bool>(
    'is_wbso',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_wbso" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fiscalYearMeta = const VerificationMeta(
    'fiscalYear',
  );
  @override
  late final GeneratedColumn<int> fiscalYear = GeneratedColumn<int>(
    'fiscal_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekNumberMeta = const VerificationMeta(
    'weekNumber',
  );
  @override
  late final GeneratedColumn<int> weekNumber = GeneratedColumn<int>(
    'week_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    description,
    workType,
    hours,
    billable,
    clientProject,
    isWbso,
    notes,
    fiscalYear,
    weekNumber,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hour_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<HourEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('work_type')) {
      context.handle(
        _workTypeMeta,
        workType.isAcceptableOrUnknown(data['work_type']!, _workTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_workTypeMeta);
    }
    if (data.containsKey('hours')) {
      context.handle(
        _hoursMeta,
        hours.isAcceptableOrUnknown(data['hours']!, _hoursMeta),
      );
    } else if (isInserting) {
      context.missing(_hoursMeta);
    }
    if (data.containsKey('billable')) {
      context.handle(
        _billableMeta,
        billable.isAcceptableOrUnknown(data['billable']!, _billableMeta),
      );
    }
    if (data.containsKey('client_project')) {
      context.handle(
        _clientProjectMeta,
        clientProject.isAcceptableOrUnknown(
          data['client_project']!,
          _clientProjectMeta,
        ),
      );
    }
    if (data.containsKey('is_wbso')) {
      context.handle(
        _isWbsoMeta,
        isWbso.isAcceptableOrUnknown(data['is_wbso']!, _isWbsoMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('fiscal_year')) {
      context.handle(
        _fiscalYearMeta,
        fiscalYear.isAcceptableOrUnknown(data['fiscal_year']!, _fiscalYearMeta),
      );
    } else if (isInserting) {
      context.missing(_fiscalYearMeta);
    }
    if (data.containsKey('week_number')) {
      context.handle(
        _weekNumberMeta,
        weekNumber.isAcceptableOrUnknown(data['week_number']!, _weekNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_weekNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HourEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HourEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      workType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_type'],
      )!,
      hours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hours'],
      )!,
      billable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}billable'],
      )!,
      clientProject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_project'],
      ),
      isWbso: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_wbso'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      fiscalYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fiscal_year'],
      )!,
      weekNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_number'],
      )!,
    );
  }

  @override
  $HourEntriesTable createAlias(String alias) {
    return $HourEntriesTable(attachedDatabase, alias);
  }
}

class HourEntry extends DataClass implements Insertable<HourEntry> {
  final int id;
  final DateTime date;
  final String description;
  final String workType;
  final double hours;
  final bool billable;
  final String? clientProject;
  final bool isWbso;
  final String? notes;
  final int fiscalYear;
  final int weekNumber;
  const HourEntry({
    required this.id,
    required this.date,
    required this.description,
    required this.workType,
    required this.hours,
    required this.billable,
    this.clientProject,
    required this.isWbso,
    this.notes,
    required this.fiscalYear,
    required this.weekNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['description'] = Variable<String>(description);
    map['work_type'] = Variable<String>(workType);
    map['hours'] = Variable<double>(hours);
    map['billable'] = Variable<bool>(billable);
    if (!nullToAbsent || clientProject != null) {
      map['client_project'] = Variable<String>(clientProject);
    }
    map['is_wbso'] = Variable<bool>(isWbso);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['fiscal_year'] = Variable<int>(fiscalYear);
    map['week_number'] = Variable<int>(weekNumber);
    return map;
  }

  HourEntriesCompanion toCompanion(bool nullToAbsent) {
    return HourEntriesCompanion(
      id: Value(id),
      date: Value(date),
      description: Value(description),
      workType: Value(workType),
      hours: Value(hours),
      billable: Value(billable),
      clientProject: clientProject == null && nullToAbsent
          ? const Value.absent()
          : Value(clientProject),
      isWbso: Value(isWbso),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      fiscalYear: Value(fiscalYear),
      weekNumber: Value(weekNumber),
    );
  }

  factory HourEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HourEntry(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String>(json['description']),
      workType: serializer.fromJson<String>(json['workType']),
      hours: serializer.fromJson<double>(json['hours']),
      billable: serializer.fromJson<bool>(json['billable']),
      clientProject: serializer.fromJson<String?>(json['clientProject']),
      isWbso: serializer.fromJson<bool>(json['isWbso']),
      notes: serializer.fromJson<String?>(json['notes']),
      fiscalYear: serializer.fromJson<int>(json['fiscalYear']),
      weekNumber: serializer.fromJson<int>(json['weekNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String>(description),
      'workType': serializer.toJson<String>(workType),
      'hours': serializer.toJson<double>(hours),
      'billable': serializer.toJson<bool>(billable),
      'clientProject': serializer.toJson<String?>(clientProject),
      'isWbso': serializer.toJson<bool>(isWbso),
      'notes': serializer.toJson<String?>(notes),
      'fiscalYear': serializer.toJson<int>(fiscalYear),
      'weekNumber': serializer.toJson<int>(weekNumber),
    };
  }

  HourEntry copyWith({
    int? id,
    DateTime? date,
    String? description,
    String? workType,
    double? hours,
    bool? billable,
    Value<String?> clientProject = const Value.absent(),
    bool? isWbso,
    Value<String?> notes = const Value.absent(),
    int? fiscalYear,
    int? weekNumber,
  }) => HourEntry(
    id: id ?? this.id,
    date: date ?? this.date,
    description: description ?? this.description,
    workType: workType ?? this.workType,
    hours: hours ?? this.hours,
    billable: billable ?? this.billable,
    clientProject: clientProject.present
        ? clientProject.value
        : this.clientProject,
    isWbso: isWbso ?? this.isWbso,
    notes: notes.present ? notes.value : this.notes,
    fiscalYear: fiscalYear ?? this.fiscalYear,
    weekNumber: weekNumber ?? this.weekNumber,
  );
  HourEntry copyWithCompanion(HourEntriesCompanion data) {
    return HourEntry(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      description: data.description.present
          ? data.description.value
          : this.description,
      workType: data.workType.present ? data.workType.value : this.workType,
      hours: data.hours.present ? data.hours.value : this.hours,
      billable: data.billable.present ? data.billable.value : this.billable,
      clientProject: data.clientProject.present
          ? data.clientProject.value
          : this.clientProject,
      isWbso: data.isWbso.present ? data.isWbso.value : this.isWbso,
      notes: data.notes.present ? data.notes.value : this.notes,
      fiscalYear: data.fiscalYear.present
          ? data.fiscalYear.value
          : this.fiscalYear,
      weekNumber: data.weekNumber.present
          ? data.weekNumber.value
          : this.weekNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HourEntry(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('workType: $workType, ')
          ..write('hours: $hours, ')
          ..write('billable: $billable, ')
          ..write('clientProject: $clientProject, ')
          ..write('isWbso: $isWbso, ')
          ..write('notes: $notes, ')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('weekNumber: $weekNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    description,
    workType,
    hours,
    billable,
    clientProject,
    isWbso,
    notes,
    fiscalYear,
    weekNumber,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HourEntry &&
          other.id == this.id &&
          other.date == this.date &&
          other.description == this.description &&
          other.workType == this.workType &&
          other.hours == this.hours &&
          other.billable == this.billable &&
          other.clientProject == this.clientProject &&
          other.isWbso == this.isWbso &&
          other.notes == this.notes &&
          other.fiscalYear == this.fiscalYear &&
          other.weekNumber == this.weekNumber);
}

class HourEntriesCompanion extends UpdateCompanion<HourEntry> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> description;
  final Value<String> workType;
  final Value<double> hours;
  final Value<bool> billable;
  final Value<String?> clientProject;
  final Value<bool> isWbso;
  final Value<String?> notes;
  final Value<int> fiscalYear;
  final Value<int> weekNumber;
  const HourEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.workType = const Value.absent(),
    this.hours = const Value.absent(),
    this.billable = const Value.absent(),
    this.clientProject = const Value.absent(),
    this.isWbso = const Value.absent(),
    this.notes = const Value.absent(),
    this.fiscalYear = const Value.absent(),
    this.weekNumber = const Value.absent(),
  });
  HourEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String description,
    required String workType,
    required double hours,
    this.billable = const Value.absent(),
    this.clientProject = const Value.absent(),
    this.isWbso = const Value.absent(),
    this.notes = const Value.absent(),
    required int fiscalYear,
    required int weekNumber,
  }) : date = Value(date),
       description = Value(description),
       workType = Value(workType),
       hours = Value(hours),
       fiscalYear = Value(fiscalYear),
       weekNumber = Value(weekNumber);
  static Insertable<HourEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<String>? workType,
    Expression<double>? hours,
    Expression<bool>? billable,
    Expression<String>? clientProject,
    Expression<bool>? isWbso,
    Expression<String>? notes,
    Expression<int>? fiscalYear,
    Expression<int>? weekNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (workType != null) 'work_type': workType,
      if (hours != null) 'hours': hours,
      if (billable != null) 'billable': billable,
      if (clientProject != null) 'client_project': clientProject,
      if (isWbso != null) 'is_wbso': isWbso,
      if (notes != null) 'notes': notes,
      if (fiscalYear != null) 'fiscal_year': fiscalYear,
      if (weekNumber != null) 'week_number': weekNumber,
    });
  }

  HourEntriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? description,
    Value<String>? workType,
    Value<double>? hours,
    Value<bool>? billable,
    Value<String?>? clientProject,
    Value<bool>? isWbso,
    Value<String?>? notes,
    Value<int>? fiscalYear,
    Value<int>? weekNumber,
  }) {
    return HourEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      description: description ?? this.description,
      workType: workType ?? this.workType,
      hours: hours ?? this.hours,
      billable: billable ?? this.billable,
      clientProject: clientProject ?? this.clientProject,
      isWbso: isWbso ?? this.isWbso,
      notes: notes ?? this.notes,
      fiscalYear: fiscalYear ?? this.fiscalYear,
      weekNumber: weekNumber ?? this.weekNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (workType.present) {
      map['work_type'] = Variable<String>(workType.value);
    }
    if (hours.present) {
      map['hours'] = Variable<double>(hours.value);
    }
    if (billable.present) {
      map['billable'] = Variable<bool>(billable.value);
    }
    if (clientProject.present) {
      map['client_project'] = Variable<String>(clientProject.value);
    }
    if (isWbso.present) {
      map['is_wbso'] = Variable<bool>(isWbso.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (fiscalYear.present) {
      map['fiscal_year'] = Variable<int>(fiscalYear.value);
    }
    if (weekNumber.present) {
      map['week_number'] = Variable<int>(weekNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HourEntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('workType: $workType, ')
          ..write('hours: $hours, ')
          ..write('billable: $billable, ')
          ..write('clientProject: $clientProject, ')
          ..write('isWbso: $isWbso, ')
          ..write('notes: $notes, ')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('weekNumber: $weekNumber')
          ..write(')'))
        .toString();
  }
}

class $MileageTripsTable extends MileageTrips
    with TableInfo<$MileageTripsTable, MileageTrip> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MileageTripsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleMakeModelMeta = const VerificationMeta(
    'vehicleMakeModel',
  );
  @override
  late final GeneratedColumn<String> vehicleMakeModel = GeneratedColumn<String>(
    'vehicle_make_model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleLicensePlateMeta =
      const VerificationMeta('vehicleLicensePlate');
  @override
  late final GeneratedColumn<String> vehicleLicensePlate =
      GeneratedColumn<String>(
        'vehicle_license_plate',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _departureAddressMeta = const VerificationMeta(
    'departureAddress',
  );
  @override
  late final GeneratedColumn<String> departureAddress = GeneratedColumn<String>(
    'departure_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arrivalAddressMeta = const VerificationMeta(
    'arrivalAddress',
  );
  @override
  late final GeneratedColumn<String> arrivalAddress = GeneratedColumn<String>(
    'arrival_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerStartMeta = const VerificationMeta(
    'odometerStart',
  );
  @override
  late final GeneratedColumn<int> odometerStart = GeneratedColumn<int>(
    'odometer_start',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerEndMeta = const VerificationMeta(
    'odometerEnd',
  );
  @override
  late final GeneratedColumn<int> odometerEnd = GeneratedColumn<int>(
    'odometer_end',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _distanceKmMeta = const VerificationMeta(
    'distanceKm',
  );
  @override
  late final GeneratedColumn<int> distanceKm = GeneratedColumn<int>(
    'distance_km',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tripTypeMeta = const VerificationMeta(
    'tripType',
  );
  @override
  late final GeneratedColumn<String> tripType = GeneratedColumn<String>(
    'trip_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Business'),
  );
  static const VerificationMeta _purposeMeta = const VerificationMeta(
    'purpose',
  );
  @override
  late final GeneratedColumn<String> purpose = GeneratedColumn<String>(
    'purpose',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routeDeviationMeta = const VerificationMeta(
    'routeDeviation',
  );
  @override
  late final GeneratedColumn<bool> routeDeviation = GeneratedColumn<bool>(
    'route_deviation',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("route_deviation" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fiscalYearMeta = const VerificationMeta(
    'fiscalYear',
  );
  @override
  late final GeneratedColumn<int> fiscalYear = GeneratedColumn<int>(
    'fiscal_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    vehicleMakeModel,
    vehicleLicensePlate,
    departureAddress,
    arrivalAddress,
    odometerStart,
    odometerEnd,
    distanceKm,
    tripType,
    purpose,
    routeDeviation,
    notes,
    fiscalYear,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mileage_trips';
  @override
  VerificationContext validateIntegrity(
    Insertable<MileageTrip> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('vehicle_make_model')) {
      context.handle(
        _vehicleMakeModelMeta,
        vehicleMakeModel.isAcceptableOrUnknown(
          data['vehicle_make_model']!,
          _vehicleMakeModelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vehicleMakeModelMeta);
    }
    if (data.containsKey('vehicle_license_plate')) {
      context.handle(
        _vehicleLicensePlateMeta,
        vehicleLicensePlate.isAcceptableOrUnknown(
          data['vehicle_license_plate']!,
          _vehicleLicensePlateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vehicleLicensePlateMeta);
    }
    if (data.containsKey('departure_address')) {
      context.handle(
        _departureAddressMeta,
        departureAddress.isAcceptableOrUnknown(
          data['departure_address']!,
          _departureAddressMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_departureAddressMeta);
    }
    if (data.containsKey('arrival_address')) {
      context.handle(
        _arrivalAddressMeta,
        arrivalAddress.isAcceptableOrUnknown(
          data['arrival_address']!,
          _arrivalAddressMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arrivalAddressMeta);
    }
    if (data.containsKey('odometer_start')) {
      context.handle(
        _odometerStartMeta,
        odometerStart.isAcceptableOrUnknown(
          data['odometer_start']!,
          _odometerStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_odometerStartMeta);
    }
    if (data.containsKey('odometer_end')) {
      context.handle(
        _odometerEndMeta,
        odometerEnd.isAcceptableOrUnknown(
          data['odometer_end']!,
          _odometerEndMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_odometerEndMeta);
    }
    if (data.containsKey('distance_km')) {
      context.handle(
        _distanceKmMeta,
        distanceKm.isAcceptableOrUnknown(data['distance_km']!, _distanceKmMeta),
      );
    } else if (isInserting) {
      context.missing(_distanceKmMeta);
    }
    if (data.containsKey('trip_type')) {
      context.handle(
        _tripTypeMeta,
        tripType.isAcceptableOrUnknown(data['trip_type']!, _tripTypeMeta),
      );
    }
    if (data.containsKey('purpose')) {
      context.handle(
        _purposeMeta,
        purpose.isAcceptableOrUnknown(data['purpose']!, _purposeMeta),
      );
    } else if (isInserting) {
      context.missing(_purposeMeta);
    }
    if (data.containsKey('route_deviation')) {
      context.handle(
        _routeDeviationMeta,
        routeDeviation.isAcceptableOrUnknown(
          data['route_deviation']!,
          _routeDeviationMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('fiscal_year')) {
      context.handle(
        _fiscalYearMeta,
        fiscalYear.isAcceptableOrUnknown(data['fiscal_year']!, _fiscalYearMeta),
      );
    } else if (isInserting) {
      context.missing(_fiscalYearMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MileageTrip map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MileageTrip(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      vehicleMakeModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_make_model'],
      )!,
      vehicleLicensePlate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_license_plate'],
      )!,
      departureAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}departure_address'],
      )!,
      arrivalAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arrival_address'],
      )!,
      odometerStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer_start'],
      )!,
      odometerEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}odometer_end'],
      )!,
      distanceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}distance_km'],
      )!,
      tripType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trip_type'],
      )!,
      purpose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purpose'],
      )!,
      routeDeviation: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}route_deviation'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      fiscalYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fiscal_year'],
      )!,
    );
  }

  @override
  $MileageTripsTable createAlias(String alias) {
    return $MileageTripsTable(attachedDatabase, alias);
  }
}

class MileageTrip extends DataClass implements Insertable<MileageTrip> {
  final int id;
  final DateTime date;
  final String vehicleMakeModel;
  final String vehicleLicensePlate;
  final String departureAddress;
  final String arrivalAddress;
  final int odometerStart;
  final int odometerEnd;
  final int distanceKm;
  final String tripType;
  final String purpose;
  final bool routeDeviation;
  final String? notes;
  final int fiscalYear;
  const MileageTrip({
    required this.id,
    required this.date,
    required this.vehicleMakeModel,
    required this.vehicleLicensePlate,
    required this.departureAddress,
    required this.arrivalAddress,
    required this.odometerStart,
    required this.odometerEnd,
    required this.distanceKm,
    required this.tripType,
    required this.purpose,
    required this.routeDeviation,
    this.notes,
    required this.fiscalYear,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['vehicle_make_model'] = Variable<String>(vehicleMakeModel);
    map['vehicle_license_plate'] = Variable<String>(vehicleLicensePlate);
    map['departure_address'] = Variable<String>(departureAddress);
    map['arrival_address'] = Variable<String>(arrivalAddress);
    map['odometer_start'] = Variable<int>(odometerStart);
    map['odometer_end'] = Variable<int>(odometerEnd);
    map['distance_km'] = Variable<int>(distanceKm);
    map['trip_type'] = Variable<String>(tripType);
    map['purpose'] = Variable<String>(purpose);
    map['route_deviation'] = Variable<bool>(routeDeviation);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['fiscal_year'] = Variable<int>(fiscalYear);
    return map;
  }

  MileageTripsCompanion toCompanion(bool nullToAbsent) {
    return MileageTripsCompanion(
      id: Value(id),
      date: Value(date),
      vehicleMakeModel: Value(vehicleMakeModel),
      vehicleLicensePlate: Value(vehicleLicensePlate),
      departureAddress: Value(departureAddress),
      arrivalAddress: Value(arrivalAddress),
      odometerStart: Value(odometerStart),
      odometerEnd: Value(odometerEnd),
      distanceKm: Value(distanceKm),
      tripType: Value(tripType),
      purpose: Value(purpose),
      routeDeviation: Value(routeDeviation),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      fiscalYear: Value(fiscalYear),
    );
  }

  factory MileageTrip.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MileageTrip(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      vehicleMakeModel: serializer.fromJson<String>(json['vehicleMakeModel']),
      vehicleLicensePlate: serializer.fromJson<String>(
        json['vehicleLicensePlate'],
      ),
      departureAddress: serializer.fromJson<String>(json['departureAddress']),
      arrivalAddress: serializer.fromJson<String>(json['arrivalAddress']),
      odometerStart: serializer.fromJson<int>(json['odometerStart']),
      odometerEnd: serializer.fromJson<int>(json['odometerEnd']),
      distanceKm: serializer.fromJson<int>(json['distanceKm']),
      tripType: serializer.fromJson<String>(json['tripType']),
      purpose: serializer.fromJson<String>(json['purpose']),
      routeDeviation: serializer.fromJson<bool>(json['routeDeviation']),
      notes: serializer.fromJson<String?>(json['notes']),
      fiscalYear: serializer.fromJson<int>(json['fiscalYear']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'vehicleMakeModel': serializer.toJson<String>(vehicleMakeModel),
      'vehicleLicensePlate': serializer.toJson<String>(vehicleLicensePlate),
      'departureAddress': serializer.toJson<String>(departureAddress),
      'arrivalAddress': serializer.toJson<String>(arrivalAddress),
      'odometerStart': serializer.toJson<int>(odometerStart),
      'odometerEnd': serializer.toJson<int>(odometerEnd),
      'distanceKm': serializer.toJson<int>(distanceKm),
      'tripType': serializer.toJson<String>(tripType),
      'purpose': serializer.toJson<String>(purpose),
      'routeDeviation': serializer.toJson<bool>(routeDeviation),
      'notes': serializer.toJson<String?>(notes),
      'fiscalYear': serializer.toJson<int>(fiscalYear),
    };
  }

  MileageTrip copyWith({
    int? id,
    DateTime? date,
    String? vehicleMakeModel,
    String? vehicleLicensePlate,
    String? departureAddress,
    String? arrivalAddress,
    int? odometerStart,
    int? odometerEnd,
    int? distanceKm,
    String? tripType,
    String? purpose,
    bool? routeDeviation,
    Value<String?> notes = const Value.absent(),
    int? fiscalYear,
  }) => MileageTrip(
    id: id ?? this.id,
    date: date ?? this.date,
    vehicleMakeModel: vehicleMakeModel ?? this.vehicleMakeModel,
    vehicleLicensePlate: vehicleLicensePlate ?? this.vehicleLicensePlate,
    departureAddress: departureAddress ?? this.departureAddress,
    arrivalAddress: arrivalAddress ?? this.arrivalAddress,
    odometerStart: odometerStart ?? this.odometerStart,
    odometerEnd: odometerEnd ?? this.odometerEnd,
    distanceKm: distanceKm ?? this.distanceKm,
    tripType: tripType ?? this.tripType,
    purpose: purpose ?? this.purpose,
    routeDeviation: routeDeviation ?? this.routeDeviation,
    notes: notes.present ? notes.value : this.notes,
    fiscalYear: fiscalYear ?? this.fiscalYear,
  );
  MileageTrip copyWithCompanion(MileageTripsCompanion data) {
    return MileageTrip(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      vehicleMakeModel: data.vehicleMakeModel.present
          ? data.vehicleMakeModel.value
          : this.vehicleMakeModel,
      vehicleLicensePlate: data.vehicleLicensePlate.present
          ? data.vehicleLicensePlate.value
          : this.vehicleLicensePlate,
      departureAddress: data.departureAddress.present
          ? data.departureAddress.value
          : this.departureAddress,
      arrivalAddress: data.arrivalAddress.present
          ? data.arrivalAddress.value
          : this.arrivalAddress,
      odometerStart: data.odometerStart.present
          ? data.odometerStart.value
          : this.odometerStart,
      odometerEnd: data.odometerEnd.present
          ? data.odometerEnd.value
          : this.odometerEnd,
      distanceKm: data.distanceKm.present
          ? data.distanceKm.value
          : this.distanceKm,
      tripType: data.tripType.present ? data.tripType.value : this.tripType,
      purpose: data.purpose.present ? data.purpose.value : this.purpose,
      routeDeviation: data.routeDeviation.present
          ? data.routeDeviation.value
          : this.routeDeviation,
      notes: data.notes.present ? data.notes.value : this.notes,
      fiscalYear: data.fiscalYear.present
          ? data.fiscalYear.value
          : this.fiscalYear,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MileageTrip(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('vehicleMakeModel: $vehicleMakeModel, ')
          ..write('vehicleLicensePlate: $vehicleLicensePlate, ')
          ..write('departureAddress: $departureAddress, ')
          ..write('arrivalAddress: $arrivalAddress, ')
          ..write('odometerStart: $odometerStart, ')
          ..write('odometerEnd: $odometerEnd, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('tripType: $tripType, ')
          ..write('purpose: $purpose, ')
          ..write('routeDeviation: $routeDeviation, ')
          ..write('notes: $notes, ')
          ..write('fiscalYear: $fiscalYear')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    vehicleMakeModel,
    vehicleLicensePlate,
    departureAddress,
    arrivalAddress,
    odometerStart,
    odometerEnd,
    distanceKm,
    tripType,
    purpose,
    routeDeviation,
    notes,
    fiscalYear,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MileageTrip &&
          other.id == this.id &&
          other.date == this.date &&
          other.vehicleMakeModel == this.vehicleMakeModel &&
          other.vehicleLicensePlate == this.vehicleLicensePlate &&
          other.departureAddress == this.departureAddress &&
          other.arrivalAddress == this.arrivalAddress &&
          other.odometerStart == this.odometerStart &&
          other.odometerEnd == this.odometerEnd &&
          other.distanceKm == this.distanceKm &&
          other.tripType == this.tripType &&
          other.purpose == this.purpose &&
          other.routeDeviation == this.routeDeviation &&
          other.notes == this.notes &&
          other.fiscalYear == this.fiscalYear);
}

class MileageTripsCompanion extends UpdateCompanion<MileageTrip> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> vehicleMakeModel;
  final Value<String> vehicleLicensePlate;
  final Value<String> departureAddress;
  final Value<String> arrivalAddress;
  final Value<int> odometerStart;
  final Value<int> odometerEnd;
  final Value<int> distanceKm;
  final Value<String> tripType;
  final Value<String> purpose;
  final Value<bool> routeDeviation;
  final Value<String?> notes;
  final Value<int> fiscalYear;
  const MileageTripsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.vehicleMakeModel = const Value.absent(),
    this.vehicleLicensePlate = const Value.absent(),
    this.departureAddress = const Value.absent(),
    this.arrivalAddress = const Value.absent(),
    this.odometerStart = const Value.absent(),
    this.odometerEnd = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.tripType = const Value.absent(),
    this.purpose = const Value.absent(),
    this.routeDeviation = const Value.absent(),
    this.notes = const Value.absent(),
    this.fiscalYear = const Value.absent(),
  });
  MileageTripsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String vehicleMakeModel,
    required String vehicleLicensePlate,
    required String departureAddress,
    required String arrivalAddress,
    required int odometerStart,
    required int odometerEnd,
    required int distanceKm,
    this.tripType = const Value.absent(),
    required String purpose,
    this.routeDeviation = const Value.absent(),
    this.notes = const Value.absent(),
    required int fiscalYear,
  }) : date = Value(date),
       vehicleMakeModel = Value(vehicleMakeModel),
       vehicleLicensePlate = Value(vehicleLicensePlate),
       departureAddress = Value(departureAddress),
       arrivalAddress = Value(arrivalAddress),
       odometerStart = Value(odometerStart),
       odometerEnd = Value(odometerEnd),
       distanceKm = Value(distanceKm),
       purpose = Value(purpose),
       fiscalYear = Value(fiscalYear);
  static Insertable<MileageTrip> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? vehicleMakeModel,
    Expression<String>? vehicleLicensePlate,
    Expression<String>? departureAddress,
    Expression<String>? arrivalAddress,
    Expression<int>? odometerStart,
    Expression<int>? odometerEnd,
    Expression<int>? distanceKm,
    Expression<String>? tripType,
    Expression<String>? purpose,
    Expression<bool>? routeDeviation,
    Expression<String>? notes,
    Expression<int>? fiscalYear,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (vehicleMakeModel != null) 'vehicle_make_model': vehicleMakeModel,
      if (vehicleLicensePlate != null)
        'vehicle_license_plate': vehicleLicensePlate,
      if (departureAddress != null) 'departure_address': departureAddress,
      if (arrivalAddress != null) 'arrival_address': arrivalAddress,
      if (odometerStart != null) 'odometer_start': odometerStart,
      if (odometerEnd != null) 'odometer_end': odometerEnd,
      if (distanceKm != null) 'distance_km': distanceKm,
      if (tripType != null) 'trip_type': tripType,
      if (purpose != null) 'purpose': purpose,
      if (routeDeviation != null) 'route_deviation': routeDeviation,
      if (notes != null) 'notes': notes,
      if (fiscalYear != null) 'fiscal_year': fiscalYear,
    });
  }

  MileageTripsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? vehicleMakeModel,
    Value<String>? vehicleLicensePlate,
    Value<String>? departureAddress,
    Value<String>? arrivalAddress,
    Value<int>? odometerStart,
    Value<int>? odometerEnd,
    Value<int>? distanceKm,
    Value<String>? tripType,
    Value<String>? purpose,
    Value<bool>? routeDeviation,
    Value<String?>? notes,
    Value<int>? fiscalYear,
  }) {
    return MileageTripsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      vehicleMakeModel: vehicleMakeModel ?? this.vehicleMakeModel,
      vehicleLicensePlate: vehicleLicensePlate ?? this.vehicleLicensePlate,
      departureAddress: departureAddress ?? this.departureAddress,
      arrivalAddress: arrivalAddress ?? this.arrivalAddress,
      odometerStart: odometerStart ?? this.odometerStart,
      odometerEnd: odometerEnd ?? this.odometerEnd,
      distanceKm: distanceKm ?? this.distanceKm,
      tripType: tripType ?? this.tripType,
      purpose: purpose ?? this.purpose,
      routeDeviation: routeDeviation ?? this.routeDeviation,
      notes: notes ?? this.notes,
      fiscalYear: fiscalYear ?? this.fiscalYear,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (vehicleMakeModel.present) {
      map['vehicle_make_model'] = Variable<String>(vehicleMakeModel.value);
    }
    if (vehicleLicensePlate.present) {
      map['vehicle_license_plate'] = Variable<String>(
        vehicleLicensePlate.value,
      );
    }
    if (departureAddress.present) {
      map['departure_address'] = Variable<String>(departureAddress.value);
    }
    if (arrivalAddress.present) {
      map['arrival_address'] = Variable<String>(arrivalAddress.value);
    }
    if (odometerStart.present) {
      map['odometer_start'] = Variable<int>(odometerStart.value);
    }
    if (odometerEnd.present) {
      map['odometer_end'] = Variable<int>(odometerEnd.value);
    }
    if (distanceKm.present) {
      map['distance_km'] = Variable<int>(distanceKm.value);
    }
    if (tripType.present) {
      map['trip_type'] = Variable<String>(tripType.value);
    }
    if (purpose.present) {
      map['purpose'] = Variable<String>(purpose.value);
    }
    if (routeDeviation.present) {
      map['route_deviation'] = Variable<bool>(routeDeviation.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (fiscalYear.present) {
      map['fiscal_year'] = Variable<int>(fiscalYear.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MileageTripsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('vehicleMakeModel: $vehicleMakeModel, ')
          ..write('vehicleLicensePlate: $vehicleLicensePlate, ')
          ..write('departureAddress: $departureAddress, ')
          ..write('arrivalAddress: $arrivalAddress, ')
          ..write('odometerStart: $odometerStart, ')
          ..write('odometerEnd: $odometerEnd, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('tripType: $tripType, ')
          ..write('purpose: $purpose, ')
          ..write('routeDeviation: $routeDeviation, ')
          ..write('notes: $notes, ')
          ..write('fiscalYear: $fiscalYear')
          ..write(')'))
        .toString();
  }
}

class $FixedAssetsTable extends FixedAssets
    with TableInfo<$FixedAssetsTable, FixedAsset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FixedAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fiscalYearMeta = const VerificationMeta(
    'fiscalYear',
  );
  @override
  late final GeneratedColumn<int> fiscalYear = GeneratedColumn<int>(
    'fiscal_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetNameMeta = const VerificationMeta(
    'assetName',
  );
  @override
  late final GeneratedColumn<String> assetName = GeneratedColumn<String>(
    'asset_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costExclVatMeta = const VerificationMeta(
    'costExclVat',
  );
  @override
  late final GeneratedColumn<int> costExclVat = GeneratedColumn<int>(
    'cost_excl_vat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessUsePctMeta = const VerificationMeta(
    'businessUsePct',
  );
  @override
  late final GeneratedColumn<double> businessUsePct = GeneratedColumn<double>(
    'business_use_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _usefulLifeYearsMeta = const VerificationMeta(
    'usefulLifeYears',
  );
  @override
  late final GeneratedColumn<int> usefulLifeYears = GeneratedColumn<int>(
    'useful_life_years',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kiaEligibleMeta = const VerificationMeta(
    'kiaEligible',
  );
  @override
  late final GeneratedColumn<bool> kiaEligible = GeneratedColumn<bool>(
    'kia_eligible',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("kia_eligible" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _eiaOrMiaMeta = const VerificationMeta(
    'eiaOrMia',
  );
  @override
  late final GeneratedColumn<bool> eiaOrMia = GeneratedColumn<bool>(
    'eia_or_mia',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("eia_or_mia" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _disposalDateMeta = const VerificationMeta(
    'disposalDate',
  );
  @override
  late final GeneratedColumn<DateTime> disposalDate = GeneratedColumn<DateTime>(
    'disposal_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _disposalProceedsMeta = const VerificationMeta(
    'disposalProceeds',
  );
  @override
  late final GeneratedColumn<int> disposalProceeds = GeneratedColumn<int>(
    'disposal_proceeds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fiscalYear,
    assetName,
    costExclVat,
    purchaseDate,
    businessUsePct,
    usefulLifeYears,
    kiaEligible,
    eiaOrMia,
    notes,
    disposalDate,
    disposalProceeds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fixed_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<FixedAsset> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fiscal_year')) {
      context.handle(
        _fiscalYearMeta,
        fiscalYear.isAcceptableOrUnknown(data['fiscal_year']!, _fiscalYearMeta),
      );
    } else if (isInserting) {
      context.missing(_fiscalYearMeta);
    }
    if (data.containsKey('asset_name')) {
      context.handle(
        _assetNameMeta,
        assetName.isAcceptableOrUnknown(data['asset_name']!, _assetNameMeta),
      );
    } else if (isInserting) {
      context.missing(_assetNameMeta);
    }
    if (data.containsKey('cost_excl_vat')) {
      context.handle(
        _costExclVatMeta,
        costExclVat.isAcceptableOrUnknown(
          data['cost_excl_vat']!,
          _costExclVatMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costExclVatMeta);
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchaseDateMeta);
    }
    if (data.containsKey('business_use_pct')) {
      context.handle(
        _businessUsePctMeta,
        businessUsePct.isAcceptableOrUnknown(
          data['business_use_pct']!,
          _businessUsePctMeta,
        ),
      );
    }
    if (data.containsKey('useful_life_years')) {
      context.handle(
        _usefulLifeYearsMeta,
        usefulLifeYears.isAcceptableOrUnknown(
          data['useful_life_years']!,
          _usefulLifeYearsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_usefulLifeYearsMeta);
    }
    if (data.containsKey('kia_eligible')) {
      context.handle(
        _kiaEligibleMeta,
        kiaEligible.isAcceptableOrUnknown(
          data['kia_eligible']!,
          _kiaEligibleMeta,
        ),
      );
    }
    if (data.containsKey('eia_or_mia')) {
      context.handle(
        _eiaOrMiaMeta,
        eiaOrMia.isAcceptableOrUnknown(data['eia_or_mia']!, _eiaOrMiaMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('disposal_date')) {
      context.handle(
        _disposalDateMeta,
        disposalDate.isAcceptableOrUnknown(
          data['disposal_date']!,
          _disposalDateMeta,
        ),
      );
    }
    if (data.containsKey('disposal_proceeds')) {
      context.handle(
        _disposalProceedsMeta,
        disposalProceeds.isAcceptableOrUnknown(
          data['disposal_proceeds']!,
          _disposalProceedsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FixedAsset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FixedAsset(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fiscalYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fiscal_year'],
      )!,
      assetName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_name'],
      )!,
      costExclVat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_excl_vat'],
      )!,
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      )!,
      businessUsePct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}business_use_pct'],
      )!,
      usefulLifeYears: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}useful_life_years'],
      )!,
      kiaEligible: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}kia_eligible'],
      )!,
      eiaOrMia: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}eia_or_mia'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      disposalDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}disposal_date'],
      ),
      disposalProceeds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disposal_proceeds'],
      ),
    );
  }

  @override
  $FixedAssetsTable createAlias(String alias) {
    return $FixedAssetsTable(attachedDatabase, alias);
  }
}

class FixedAsset extends DataClass implements Insertable<FixedAsset> {
  final int id;
  final int fiscalYear;
  final String assetName;
  final int costExclVat;
  final DateTime purchaseDate;
  final double businessUsePct;
  final int usefulLifeYears;
  final bool kiaEligible;
  final bool eiaOrMia;
  final String? notes;
  final DateTime? disposalDate;
  final int? disposalProceeds;
  const FixedAsset({
    required this.id,
    required this.fiscalYear,
    required this.assetName,
    required this.costExclVat,
    required this.purchaseDate,
    required this.businessUsePct,
    required this.usefulLifeYears,
    required this.kiaEligible,
    required this.eiaOrMia,
    this.notes,
    this.disposalDate,
    this.disposalProceeds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fiscal_year'] = Variable<int>(fiscalYear);
    map['asset_name'] = Variable<String>(assetName);
    map['cost_excl_vat'] = Variable<int>(costExclVat);
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    map['business_use_pct'] = Variable<double>(businessUsePct);
    map['useful_life_years'] = Variable<int>(usefulLifeYears);
    map['kia_eligible'] = Variable<bool>(kiaEligible);
    map['eia_or_mia'] = Variable<bool>(eiaOrMia);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || disposalDate != null) {
      map['disposal_date'] = Variable<DateTime>(disposalDate);
    }
    if (!nullToAbsent || disposalProceeds != null) {
      map['disposal_proceeds'] = Variable<int>(disposalProceeds);
    }
    return map;
  }

  FixedAssetsCompanion toCompanion(bool nullToAbsent) {
    return FixedAssetsCompanion(
      id: Value(id),
      fiscalYear: Value(fiscalYear),
      assetName: Value(assetName),
      costExclVat: Value(costExclVat),
      purchaseDate: Value(purchaseDate),
      businessUsePct: Value(businessUsePct),
      usefulLifeYears: Value(usefulLifeYears),
      kiaEligible: Value(kiaEligible),
      eiaOrMia: Value(eiaOrMia),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      disposalDate: disposalDate == null && nullToAbsent
          ? const Value.absent()
          : Value(disposalDate),
      disposalProceeds: disposalProceeds == null && nullToAbsent
          ? const Value.absent()
          : Value(disposalProceeds),
    );
  }

  factory FixedAsset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FixedAsset(
      id: serializer.fromJson<int>(json['id']),
      fiscalYear: serializer.fromJson<int>(json['fiscalYear']),
      assetName: serializer.fromJson<String>(json['assetName']),
      costExclVat: serializer.fromJson<int>(json['costExclVat']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
      businessUsePct: serializer.fromJson<double>(json['businessUsePct']),
      usefulLifeYears: serializer.fromJson<int>(json['usefulLifeYears']),
      kiaEligible: serializer.fromJson<bool>(json['kiaEligible']),
      eiaOrMia: serializer.fromJson<bool>(json['eiaOrMia']),
      notes: serializer.fromJson<String?>(json['notes']),
      disposalDate: serializer.fromJson<DateTime?>(json['disposalDate']),
      disposalProceeds: serializer.fromJson<int?>(json['disposalProceeds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fiscalYear': serializer.toJson<int>(fiscalYear),
      'assetName': serializer.toJson<String>(assetName),
      'costExclVat': serializer.toJson<int>(costExclVat),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
      'businessUsePct': serializer.toJson<double>(businessUsePct),
      'usefulLifeYears': serializer.toJson<int>(usefulLifeYears),
      'kiaEligible': serializer.toJson<bool>(kiaEligible),
      'eiaOrMia': serializer.toJson<bool>(eiaOrMia),
      'notes': serializer.toJson<String?>(notes),
      'disposalDate': serializer.toJson<DateTime?>(disposalDate),
      'disposalProceeds': serializer.toJson<int?>(disposalProceeds),
    };
  }

  FixedAsset copyWith({
    int? id,
    int? fiscalYear,
    String? assetName,
    int? costExclVat,
    DateTime? purchaseDate,
    double? businessUsePct,
    int? usefulLifeYears,
    bool? kiaEligible,
    bool? eiaOrMia,
    Value<String?> notes = const Value.absent(),
    Value<DateTime?> disposalDate = const Value.absent(),
    Value<int?> disposalProceeds = const Value.absent(),
  }) => FixedAsset(
    id: id ?? this.id,
    fiscalYear: fiscalYear ?? this.fiscalYear,
    assetName: assetName ?? this.assetName,
    costExclVat: costExclVat ?? this.costExclVat,
    purchaseDate: purchaseDate ?? this.purchaseDate,
    businessUsePct: businessUsePct ?? this.businessUsePct,
    usefulLifeYears: usefulLifeYears ?? this.usefulLifeYears,
    kiaEligible: kiaEligible ?? this.kiaEligible,
    eiaOrMia: eiaOrMia ?? this.eiaOrMia,
    notes: notes.present ? notes.value : this.notes,
    disposalDate: disposalDate.present ? disposalDate.value : this.disposalDate,
    disposalProceeds: disposalProceeds.present
        ? disposalProceeds.value
        : this.disposalProceeds,
  );
  FixedAsset copyWithCompanion(FixedAssetsCompanion data) {
    return FixedAsset(
      id: data.id.present ? data.id.value : this.id,
      fiscalYear: data.fiscalYear.present
          ? data.fiscalYear.value
          : this.fiscalYear,
      assetName: data.assetName.present ? data.assetName.value : this.assetName,
      costExclVat: data.costExclVat.present
          ? data.costExclVat.value
          : this.costExclVat,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      businessUsePct: data.businessUsePct.present
          ? data.businessUsePct.value
          : this.businessUsePct,
      usefulLifeYears: data.usefulLifeYears.present
          ? data.usefulLifeYears.value
          : this.usefulLifeYears,
      kiaEligible: data.kiaEligible.present
          ? data.kiaEligible.value
          : this.kiaEligible,
      eiaOrMia: data.eiaOrMia.present ? data.eiaOrMia.value : this.eiaOrMia,
      notes: data.notes.present ? data.notes.value : this.notes,
      disposalDate: data.disposalDate.present
          ? data.disposalDate.value
          : this.disposalDate,
      disposalProceeds: data.disposalProceeds.present
          ? data.disposalProceeds.value
          : this.disposalProceeds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FixedAsset(')
          ..write('id: $id, ')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('assetName: $assetName, ')
          ..write('costExclVat: $costExclVat, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('businessUsePct: $businessUsePct, ')
          ..write('usefulLifeYears: $usefulLifeYears, ')
          ..write('kiaEligible: $kiaEligible, ')
          ..write('eiaOrMia: $eiaOrMia, ')
          ..write('notes: $notes, ')
          ..write('disposalDate: $disposalDate, ')
          ..write('disposalProceeds: $disposalProceeds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fiscalYear,
    assetName,
    costExclVat,
    purchaseDate,
    businessUsePct,
    usefulLifeYears,
    kiaEligible,
    eiaOrMia,
    notes,
    disposalDate,
    disposalProceeds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FixedAsset &&
          other.id == this.id &&
          other.fiscalYear == this.fiscalYear &&
          other.assetName == this.assetName &&
          other.costExclVat == this.costExclVat &&
          other.purchaseDate == this.purchaseDate &&
          other.businessUsePct == this.businessUsePct &&
          other.usefulLifeYears == this.usefulLifeYears &&
          other.kiaEligible == this.kiaEligible &&
          other.eiaOrMia == this.eiaOrMia &&
          other.notes == this.notes &&
          other.disposalDate == this.disposalDate &&
          other.disposalProceeds == this.disposalProceeds);
}

class FixedAssetsCompanion extends UpdateCompanion<FixedAsset> {
  final Value<int> id;
  final Value<int> fiscalYear;
  final Value<String> assetName;
  final Value<int> costExclVat;
  final Value<DateTime> purchaseDate;
  final Value<double> businessUsePct;
  final Value<int> usefulLifeYears;
  final Value<bool> kiaEligible;
  final Value<bool> eiaOrMia;
  final Value<String?> notes;
  final Value<DateTime?> disposalDate;
  final Value<int?> disposalProceeds;
  const FixedAssetsCompanion({
    this.id = const Value.absent(),
    this.fiscalYear = const Value.absent(),
    this.assetName = const Value.absent(),
    this.costExclVat = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.businessUsePct = const Value.absent(),
    this.usefulLifeYears = const Value.absent(),
    this.kiaEligible = const Value.absent(),
    this.eiaOrMia = const Value.absent(),
    this.notes = const Value.absent(),
    this.disposalDate = const Value.absent(),
    this.disposalProceeds = const Value.absent(),
  });
  FixedAssetsCompanion.insert({
    this.id = const Value.absent(),
    required int fiscalYear,
    required String assetName,
    required int costExclVat,
    required DateTime purchaseDate,
    this.businessUsePct = const Value.absent(),
    required int usefulLifeYears,
    this.kiaEligible = const Value.absent(),
    this.eiaOrMia = const Value.absent(),
    this.notes = const Value.absent(),
    this.disposalDate = const Value.absent(),
    this.disposalProceeds = const Value.absent(),
  }) : fiscalYear = Value(fiscalYear),
       assetName = Value(assetName),
       costExclVat = Value(costExclVat),
       purchaseDate = Value(purchaseDate),
       usefulLifeYears = Value(usefulLifeYears);
  static Insertable<FixedAsset> custom({
    Expression<int>? id,
    Expression<int>? fiscalYear,
    Expression<String>? assetName,
    Expression<int>? costExclVat,
    Expression<DateTime>? purchaseDate,
    Expression<double>? businessUsePct,
    Expression<int>? usefulLifeYears,
    Expression<bool>? kiaEligible,
    Expression<bool>? eiaOrMia,
    Expression<String>? notes,
    Expression<DateTime>? disposalDate,
    Expression<int>? disposalProceeds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fiscalYear != null) 'fiscal_year': fiscalYear,
      if (assetName != null) 'asset_name': assetName,
      if (costExclVat != null) 'cost_excl_vat': costExclVat,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (businessUsePct != null) 'business_use_pct': businessUsePct,
      if (usefulLifeYears != null) 'useful_life_years': usefulLifeYears,
      if (kiaEligible != null) 'kia_eligible': kiaEligible,
      if (eiaOrMia != null) 'eia_or_mia': eiaOrMia,
      if (notes != null) 'notes': notes,
      if (disposalDate != null) 'disposal_date': disposalDate,
      if (disposalProceeds != null) 'disposal_proceeds': disposalProceeds,
    });
  }

  FixedAssetsCompanion copyWith({
    Value<int>? id,
    Value<int>? fiscalYear,
    Value<String>? assetName,
    Value<int>? costExclVat,
    Value<DateTime>? purchaseDate,
    Value<double>? businessUsePct,
    Value<int>? usefulLifeYears,
    Value<bool>? kiaEligible,
    Value<bool>? eiaOrMia,
    Value<String?>? notes,
    Value<DateTime?>? disposalDate,
    Value<int?>? disposalProceeds,
  }) {
    return FixedAssetsCompanion(
      id: id ?? this.id,
      fiscalYear: fiscalYear ?? this.fiscalYear,
      assetName: assetName ?? this.assetName,
      costExclVat: costExclVat ?? this.costExclVat,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      businessUsePct: businessUsePct ?? this.businessUsePct,
      usefulLifeYears: usefulLifeYears ?? this.usefulLifeYears,
      kiaEligible: kiaEligible ?? this.kiaEligible,
      eiaOrMia: eiaOrMia ?? this.eiaOrMia,
      notes: notes ?? this.notes,
      disposalDate: disposalDate ?? this.disposalDate,
      disposalProceeds: disposalProceeds ?? this.disposalProceeds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fiscalYear.present) {
      map['fiscal_year'] = Variable<int>(fiscalYear.value);
    }
    if (assetName.present) {
      map['asset_name'] = Variable<String>(assetName.value);
    }
    if (costExclVat.present) {
      map['cost_excl_vat'] = Variable<int>(costExclVat.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (businessUsePct.present) {
      map['business_use_pct'] = Variable<double>(businessUsePct.value);
    }
    if (usefulLifeYears.present) {
      map['useful_life_years'] = Variable<int>(usefulLifeYears.value);
    }
    if (kiaEligible.present) {
      map['kia_eligible'] = Variable<bool>(kiaEligible.value);
    }
    if (eiaOrMia.present) {
      map['eia_or_mia'] = Variable<bool>(eiaOrMia.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (disposalDate.present) {
      map['disposal_date'] = Variable<DateTime>(disposalDate.value);
    }
    if (disposalProceeds.present) {
      map['disposal_proceeds'] = Variable<int>(disposalProceeds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FixedAssetsCompanion(')
          ..write('id: $id, ')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('assetName: $assetName, ')
          ..write('costExclVat: $costExclVat, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('businessUsePct: $businessUsePct, ')
          ..write('usefulLifeYears: $usefulLifeYears, ')
          ..write('kiaEligible: $kiaEligible, ')
          ..write('eiaOrMia: $eiaOrMia, ')
          ..write('notes: $notes, ')
          ..write('disposalDate: $disposalDate, ')
          ..write('disposalProceeds: $disposalProceeds')
          ..write(')'))
        .toString();
  }
}

class $PensionEntriesTable extends PensionEntries
    with TableInfo<$PensionEntriesTable, PensionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PensionEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _fiscalYearMeta = const VerificationMeta(
    'fiscalYear',
  );
  @override
  late final GeneratedColumn<int> fiscalYear = GeneratedColumn<int>(
    'fiscal_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _factorAMeta = const VerificationMeta(
    'factorA',
  );
  @override
  late final GeneratedColumn<double> factorA = GeneratedColumn<double>(
    'factor_a',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _unusedPriorYearsSpaceMeta =
      const VerificationMeta('unusedPriorYearsSpace');
  @override
  late final GeneratedColumn<int> unusedPriorYearsSpace = GeneratedColumn<int>(
    'unused_prior_years_space',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _plannedContributionMeta =
      const VerificationMeta('plannedContribution');
  @override
  late final GeneratedColumn<int> plannedContribution = GeneratedColumn<int>(
    'planned_contribution',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _aovInsuredMeta = const VerificationMeta(
    'aovInsured',
  );
  @override
  late final GeneratedColumn<bool> aovInsured = GeneratedColumn<bool>(
    'aov_insured',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("aov_insured" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _monthlyAovPremiumMeta = const VerificationMeta(
    'monthlyAovPremium',
  );
  @override
  late final GeneratedColumn<int> monthlyAovPremium = GeneratedColumn<int>(
    'monthly_aov_premium',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    fiscalYear,
    factorA,
    unusedPriorYearsSpace,
    plannedContribution,
    aovInsured,
    monthlyAovPremium,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pension_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<PensionEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('fiscal_year')) {
      context.handle(
        _fiscalYearMeta,
        fiscalYear.isAcceptableOrUnknown(data['fiscal_year']!, _fiscalYearMeta),
      );
    }
    if (data.containsKey('factor_a')) {
      context.handle(
        _factorAMeta,
        factorA.isAcceptableOrUnknown(data['factor_a']!, _factorAMeta),
      );
    }
    if (data.containsKey('unused_prior_years_space')) {
      context.handle(
        _unusedPriorYearsSpaceMeta,
        unusedPriorYearsSpace.isAcceptableOrUnknown(
          data['unused_prior_years_space']!,
          _unusedPriorYearsSpaceMeta,
        ),
      );
    }
    if (data.containsKey('planned_contribution')) {
      context.handle(
        _plannedContributionMeta,
        plannedContribution.isAcceptableOrUnknown(
          data['planned_contribution']!,
          _plannedContributionMeta,
        ),
      );
    }
    if (data.containsKey('aov_insured')) {
      context.handle(
        _aovInsuredMeta,
        aovInsured.isAcceptableOrUnknown(data['aov_insured']!, _aovInsuredMeta),
      );
    }
    if (data.containsKey('monthly_aov_premium')) {
      context.handle(
        _monthlyAovPremiumMeta,
        monthlyAovPremium.isAcceptableOrUnknown(
          data['monthly_aov_premium']!,
          _monthlyAovPremiumMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {fiscalYear};
  @override
  PensionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PensionEntry(
      fiscalYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fiscal_year'],
      )!,
      factorA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}factor_a'],
      )!,
      unusedPriorYearsSpace: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unused_prior_years_space'],
      )!,
      plannedContribution: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_contribution'],
      )!,
      aovInsured: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}aov_insured'],
      )!,
      monthlyAovPremium: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_aov_premium'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PensionEntriesTable createAlias(String alias) {
    return $PensionEntriesTable(attachedDatabase, alias);
  }
}

class PensionEntry extends DataClass implements Insertable<PensionEntry> {
  final int fiscalYear;
  final double factorA;
  final int unusedPriorYearsSpace;
  final int plannedContribution;
  final bool aovInsured;
  final int monthlyAovPremium;
  final String? notes;
  const PensionEntry({
    required this.fiscalYear,
    required this.factorA,
    required this.unusedPriorYearsSpace,
    required this.plannedContribution,
    required this.aovInsured,
    required this.monthlyAovPremium,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['fiscal_year'] = Variable<int>(fiscalYear);
    map['factor_a'] = Variable<double>(factorA);
    map['unused_prior_years_space'] = Variable<int>(unusedPriorYearsSpace);
    map['planned_contribution'] = Variable<int>(plannedContribution);
    map['aov_insured'] = Variable<bool>(aovInsured);
    map['monthly_aov_premium'] = Variable<int>(monthlyAovPremium);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PensionEntriesCompanion toCompanion(bool nullToAbsent) {
    return PensionEntriesCompanion(
      fiscalYear: Value(fiscalYear),
      factorA: Value(factorA),
      unusedPriorYearsSpace: Value(unusedPriorYearsSpace),
      plannedContribution: Value(plannedContribution),
      aovInsured: Value(aovInsured),
      monthlyAovPremium: Value(monthlyAovPremium),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PensionEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PensionEntry(
      fiscalYear: serializer.fromJson<int>(json['fiscalYear']),
      factorA: serializer.fromJson<double>(json['factorA']),
      unusedPriorYearsSpace: serializer.fromJson<int>(
        json['unusedPriorYearsSpace'],
      ),
      plannedContribution: serializer.fromJson<int>(
        json['plannedContribution'],
      ),
      aovInsured: serializer.fromJson<bool>(json['aovInsured']),
      monthlyAovPremium: serializer.fromJson<int>(json['monthlyAovPremium']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fiscalYear': serializer.toJson<int>(fiscalYear),
      'factorA': serializer.toJson<double>(factorA),
      'unusedPriorYearsSpace': serializer.toJson<int>(unusedPriorYearsSpace),
      'plannedContribution': serializer.toJson<int>(plannedContribution),
      'aovInsured': serializer.toJson<bool>(aovInsured),
      'monthlyAovPremium': serializer.toJson<int>(monthlyAovPremium),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PensionEntry copyWith({
    int? fiscalYear,
    double? factorA,
    int? unusedPriorYearsSpace,
    int? plannedContribution,
    bool? aovInsured,
    int? monthlyAovPremium,
    Value<String?> notes = const Value.absent(),
  }) => PensionEntry(
    fiscalYear: fiscalYear ?? this.fiscalYear,
    factorA: factorA ?? this.factorA,
    unusedPriorYearsSpace: unusedPriorYearsSpace ?? this.unusedPriorYearsSpace,
    plannedContribution: plannedContribution ?? this.plannedContribution,
    aovInsured: aovInsured ?? this.aovInsured,
    monthlyAovPremium: monthlyAovPremium ?? this.monthlyAovPremium,
    notes: notes.present ? notes.value : this.notes,
  );
  PensionEntry copyWithCompanion(PensionEntriesCompanion data) {
    return PensionEntry(
      fiscalYear: data.fiscalYear.present
          ? data.fiscalYear.value
          : this.fiscalYear,
      factorA: data.factorA.present ? data.factorA.value : this.factorA,
      unusedPriorYearsSpace: data.unusedPriorYearsSpace.present
          ? data.unusedPriorYearsSpace.value
          : this.unusedPriorYearsSpace,
      plannedContribution: data.plannedContribution.present
          ? data.plannedContribution.value
          : this.plannedContribution,
      aovInsured: data.aovInsured.present
          ? data.aovInsured.value
          : this.aovInsured,
      monthlyAovPremium: data.monthlyAovPremium.present
          ? data.monthlyAovPremium.value
          : this.monthlyAovPremium,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PensionEntry(')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('factorA: $factorA, ')
          ..write('unusedPriorYearsSpace: $unusedPriorYearsSpace, ')
          ..write('plannedContribution: $plannedContribution, ')
          ..write('aovInsured: $aovInsured, ')
          ..write('monthlyAovPremium: $monthlyAovPremium, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    fiscalYear,
    factorA,
    unusedPriorYearsSpace,
    plannedContribution,
    aovInsured,
    monthlyAovPremium,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PensionEntry &&
          other.fiscalYear == this.fiscalYear &&
          other.factorA == this.factorA &&
          other.unusedPriorYearsSpace == this.unusedPriorYearsSpace &&
          other.plannedContribution == this.plannedContribution &&
          other.aovInsured == this.aovInsured &&
          other.monthlyAovPremium == this.monthlyAovPremium &&
          other.notes == this.notes);
}

class PensionEntriesCompanion extends UpdateCompanion<PensionEntry> {
  final Value<int> fiscalYear;
  final Value<double> factorA;
  final Value<int> unusedPriorYearsSpace;
  final Value<int> plannedContribution;
  final Value<bool> aovInsured;
  final Value<int> monthlyAovPremium;
  final Value<String?> notes;
  const PensionEntriesCompanion({
    this.fiscalYear = const Value.absent(),
    this.factorA = const Value.absent(),
    this.unusedPriorYearsSpace = const Value.absent(),
    this.plannedContribution = const Value.absent(),
    this.aovInsured = const Value.absent(),
    this.monthlyAovPremium = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PensionEntriesCompanion.insert({
    this.fiscalYear = const Value.absent(),
    this.factorA = const Value.absent(),
    this.unusedPriorYearsSpace = const Value.absent(),
    this.plannedContribution = const Value.absent(),
    this.aovInsured = const Value.absent(),
    this.monthlyAovPremium = const Value.absent(),
    this.notes = const Value.absent(),
  });
  static Insertable<PensionEntry> custom({
    Expression<int>? fiscalYear,
    Expression<double>? factorA,
    Expression<int>? unusedPriorYearsSpace,
    Expression<int>? plannedContribution,
    Expression<bool>? aovInsured,
    Expression<int>? monthlyAovPremium,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (fiscalYear != null) 'fiscal_year': fiscalYear,
      if (factorA != null) 'factor_a': factorA,
      if (unusedPriorYearsSpace != null)
        'unused_prior_years_space': unusedPriorYearsSpace,
      if (plannedContribution != null)
        'planned_contribution': plannedContribution,
      if (aovInsured != null) 'aov_insured': aovInsured,
      if (monthlyAovPremium != null) 'monthly_aov_premium': monthlyAovPremium,
      if (notes != null) 'notes': notes,
    });
  }

  PensionEntriesCompanion copyWith({
    Value<int>? fiscalYear,
    Value<double>? factorA,
    Value<int>? unusedPriorYearsSpace,
    Value<int>? plannedContribution,
    Value<bool>? aovInsured,
    Value<int>? monthlyAovPremium,
    Value<String?>? notes,
  }) {
    return PensionEntriesCompanion(
      fiscalYear: fiscalYear ?? this.fiscalYear,
      factorA: factorA ?? this.factorA,
      unusedPriorYearsSpace:
          unusedPriorYearsSpace ?? this.unusedPriorYearsSpace,
      plannedContribution: plannedContribution ?? this.plannedContribution,
      aovInsured: aovInsured ?? this.aovInsured,
      monthlyAovPremium: monthlyAovPremium ?? this.monthlyAovPremium,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (fiscalYear.present) {
      map['fiscal_year'] = Variable<int>(fiscalYear.value);
    }
    if (factorA.present) {
      map['factor_a'] = Variable<double>(factorA.value);
    }
    if (unusedPriorYearsSpace.present) {
      map['unused_prior_years_space'] = Variable<int>(
        unusedPriorYearsSpace.value,
      );
    }
    if (plannedContribution.present) {
      map['planned_contribution'] = Variable<int>(plannedContribution.value);
    }
    if (aovInsured.present) {
      map['aov_insured'] = Variable<bool>(aovInsured.value);
    }
    if (monthlyAovPremium.present) {
      map['monthly_aov_premium'] = Variable<int>(monthlyAovPremium.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PensionEntriesCompanion(')
          ..write('fiscalYear: $fiscalYear, ')
          ..write('factorA: $factorA, ')
          ..write('unusedPriorYearsSpace: $unusedPriorYearsSpace, ')
          ..write('plannedContribution: $plannedContribution, ')
          ..write('aovInsured: $aovInsured, ')
          ..write('monthlyAovPremium: $monthlyAovPremium, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TaxParamsTable taxParams = $TaxParamsTable(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $InvoiceLinesTable invoiceLines = $InvoiceLinesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $HourEntriesTable hourEntries = $HourEntriesTable(this);
  late final $MileageTripsTable mileageTrips = $MileageTripsTable(this);
  late final $FixedAssetsTable fixedAssets = $FixedAssetsTable(this);
  late final $PensionEntriesTable pensionEntries = $PensionEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    taxParams,
    clients,
    invoices,
    invoiceLines,
    expenses,
    hourEntries,
    mileageTrips,
    fixedAssets,
    pensionEntries,
  ];
}

typedef $$TaxParamsTableCreateCompanionBuilder =
    TaxParamsCompanion Function({
      Value<int> year,
      required int zelfstandigenaftrek,
      required int startersaftrek,
      required double mkbWinstvrijstellingPct,
      required double bracket1Rate,
      required int bracket1Threshold,
      required double bracket2Rate,
      required int bracket2Threshold,
      required double bracket3Rate,
      required int algHeffingskortingMax,
      required int arbeidskortingMax,
      required double zvwRate,
      required int zvwMax,
      required int mixedCostsThreshold,
      required double mixedCosts80Pct,
      required double jaarruimtePct,
      required int jaarruimteMax,
      required int aowFranchise,
      required int reserveringsruimteMax,
      required double factorAMultiplier,
      required int kiaLowerThreshold,
      required int kiaUpperThreshold,
      required int kiaFlatThreshold,
      required double kiaRate,
      required int kiaFlatAmount,
      required double mileageRatePerKm,
      required int korThreshold,
      required int ossThreshold,
      required double belastingrentePct,
    });
typedef $$TaxParamsTableUpdateCompanionBuilder =
    TaxParamsCompanion Function({
      Value<int> year,
      Value<int> zelfstandigenaftrek,
      Value<int> startersaftrek,
      Value<double> mkbWinstvrijstellingPct,
      Value<double> bracket1Rate,
      Value<int> bracket1Threshold,
      Value<double> bracket2Rate,
      Value<int> bracket2Threshold,
      Value<double> bracket3Rate,
      Value<int> algHeffingskortingMax,
      Value<int> arbeidskortingMax,
      Value<double> zvwRate,
      Value<int> zvwMax,
      Value<int> mixedCostsThreshold,
      Value<double> mixedCosts80Pct,
      Value<double> jaarruimtePct,
      Value<int> jaarruimteMax,
      Value<int> aowFranchise,
      Value<int> reserveringsruimteMax,
      Value<double> factorAMultiplier,
      Value<int> kiaLowerThreshold,
      Value<int> kiaUpperThreshold,
      Value<int> kiaFlatThreshold,
      Value<double> kiaRate,
      Value<int> kiaFlatAmount,
      Value<double> mileageRatePerKm,
      Value<int> korThreshold,
      Value<int> ossThreshold,
      Value<double> belastingrentePct,
    });

class $$TaxParamsTableFilterComposer
    extends Composer<_$AppDatabase, $TaxParamsTable> {
  $$TaxParamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get zelfstandigenaftrek => $composableBuilder(
    column: $table.zelfstandigenaftrek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startersaftrek => $composableBuilder(
    column: $table.startersaftrek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mkbWinstvrijstellingPct => $composableBuilder(
    column: $table.mkbWinstvrijstellingPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bracket1Rate => $composableBuilder(
    column: $table.bracket1Rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bracket1Threshold => $composableBuilder(
    column: $table.bracket1Threshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bracket2Rate => $composableBuilder(
    column: $table.bracket2Rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bracket2Threshold => $composableBuilder(
    column: $table.bracket2Threshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bracket3Rate => $composableBuilder(
    column: $table.bracket3Rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get algHeffingskortingMax => $composableBuilder(
    column: $table.algHeffingskortingMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get arbeidskortingMax => $composableBuilder(
    column: $table.arbeidskortingMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get zvwRate => $composableBuilder(
    column: $table.zvwRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get zvwMax => $composableBuilder(
    column: $table.zvwMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mixedCostsThreshold => $composableBuilder(
    column: $table.mixedCostsThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mixedCosts80Pct => $composableBuilder(
    column: $table.mixedCosts80Pct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get jaarruimtePct => $composableBuilder(
    column: $table.jaarruimtePct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jaarruimteMax => $composableBuilder(
    column: $table.jaarruimteMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get aowFranchise => $composableBuilder(
    column: $table.aowFranchise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reserveringsruimteMax => $composableBuilder(
    column: $table.reserveringsruimteMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get factorAMultiplier => $composableBuilder(
    column: $table.factorAMultiplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kiaLowerThreshold => $composableBuilder(
    column: $table.kiaLowerThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kiaUpperThreshold => $composableBuilder(
    column: $table.kiaUpperThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kiaFlatThreshold => $composableBuilder(
    column: $table.kiaFlatThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kiaRate => $composableBuilder(
    column: $table.kiaRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kiaFlatAmount => $composableBuilder(
    column: $table.kiaFlatAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mileageRatePerKm => $composableBuilder(
    column: $table.mileageRatePerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get korThreshold => $composableBuilder(
    column: $table.korThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ossThreshold => $composableBuilder(
    column: $table.ossThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get belastingrentePct => $composableBuilder(
    column: $table.belastingrentePct,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TaxParamsTableOrderingComposer
    extends Composer<_$AppDatabase, $TaxParamsTable> {
  $$TaxParamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get zelfstandigenaftrek => $composableBuilder(
    column: $table.zelfstandigenaftrek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startersaftrek => $composableBuilder(
    column: $table.startersaftrek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mkbWinstvrijstellingPct => $composableBuilder(
    column: $table.mkbWinstvrijstellingPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bracket1Rate => $composableBuilder(
    column: $table.bracket1Rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bracket1Threshold => $composableBuilder(
    column: $table.bracket1Threshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bracket2Rate => $composableBuilder(
    column: $table.bracket2Rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bracket2Threshold => $composableBuilder(
    column: $table.bracket2Threshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bracket3Rate => $composableBuilder(
    column: $table.bracket3Rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get algHeffingskortingMax => $composableBuilder(
    column: $table.algHeffingskortingMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get arbeidskortingMax => $composableBuilder(
    column: $table.arbeidskortingMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get zvwRate => $composableBuilder(
    column: $table.zvwRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get zvwMax => $composableBuilder(
    column: $table.zvwMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mixedCostsThreshold => $composableBuilder(
    column: $table.mixedCostsThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mixedCosts80Pct => $composableBuilder(
    column: $table.mixedCosts80Pct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get jaarruimtePct => $composableBuilder(
    column: $table.jaarruimtePct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jaarruimteMax => $composableBuilder(
    column: $table.jaarruimteMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get aowFranchise => $composableBuilder(
    column: $table.aowFranchise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reserveringsruimteMax => $composableBuilder(
    column: $table.reserveringsruimteMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get factorAMultiplier => $composableBuilder(
    column: $table.factorAMultiplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kiaLowerThreshold => $composableBuilder(
    column: $table.kiaLowerThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kiaUpperThreshold => $composableBuilder(
    column: $table.kiaUpperThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kiaFlatThreshold => $composableBuilder(
    column: $table.kiaFlatThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kiaRate => $composableBuilder(
    column: $table.kiaRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kiaFlatAmount => $composableBuilder(
    column: $table.kiaFlatAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mileageRatePerKm => $composableBuilder(
    column: $table.mileageRatePerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get korThreshold => $composableBuilder(
    column: $table.korThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ossThreshold => $composableBuilder(
    column: $table.ossThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get belastingrentePct => $composableBuilder(
    column: $table.belastingrentePct,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TaxParamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaxParamsTable> {
  $$TaxParamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get zelfstandigenaftrek => $composableBuilder(
    column: $table.zelfstandigenaftrek,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startersaftrek => $composableBuilder(
    column: $table.startersaftrek,
    builder: (column) => column,
  );

  GeneratedColumn<double> get mkbWinstvrijstellingPct => $composableBuilder(
    column: $table.mkbWinstvrijstellingPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bracket1Rate => $composableBuilder(
    column: $table.bracket1Rate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bracket1Threshold => $composableBuilder(
    column: $table.bracket1Threshold,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bracket2Rate => $composableBuilder(
    column: $table.bracket2Rate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bracket2Threshold => $composableBuilder(
    column: $table.bracket2Threshold,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bracket3Rate => $composableBuilder(
    column: $table.bracket3Rate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get algHeffingskortingMax => $composableBuilder(
    column: $table.algHeffingskortingMax,
    builder: (column) => column,
  );

  GeneratedColumn<int> get arbeidskortingMax => $composableBuilder(
    column: $table.arbeidskortingMax,
    builder: (column) => column,
  );

  GeneratedColumn<double> get zvwRate =>
      $composableBuilder(column: $table.zvwRate, builder: (column) => column);

  GeneratedColumn<int> get zvwMax =>
      $composableBuilder(column: $table.zvwMax, builder: (column) => column);

  GeneratedColumn<int> get mixedCostsThreshold => $composableBuilder(
    column: $table.mixedCostsThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<double> get mixedCosts80Pct => $composableBuilder(
    column: $table.mixedCosts80Pct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get jaarruimtePct => $composableBuilder(
    column: $table.jaarruimtePct,
    builder: (column) => column,
  );

  GeneratedColumn<int> get jaarruimteMax => $composableBuilder(
    column: $table.jaarruimteMax,
    builder: (column) => column,
  );

  GeneratedColumn<int> get aowFranchise => $composableBuilder(
    column: $table.aowFranchise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reserveringsruimteMax => $composableBuilder(
    column: $table.reserveringsruimteMax,
    builder: (column) => column,
  );

  GeneratedColumn<double> get factorAMultiplier => $composableBuilder(
    column: $table.factorAMultiplier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get kiaLowerThreshold => $composableBuilder(
    column: $table.kiaLowerThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<int> get kiaUpperThreshold => $composableBuilder(
    column: $table.kiaUpperThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<int> get kiaFlatThreshold => $composableBuilder(
    column: $table.kiaFlatThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kiaRate =>
      $composableBuilder(column: $table.kiaRate, builder: (column) => column);

  GeneratedColumn<int> get kiaFlatAmount => $composableBuilder(
    column: $table.kiaFlatAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get mileageRatePerKm => $composableBuilder(
    column: $table.mileageRatePerKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get korThreshold => $composableBuilder(
    column: $table.korThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ossThreshold => $composableBuilder(
    column: $table.ossThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<double> get belastingrentePct => $composableBuilder(
    column: $table.belastingrentePct,
    builder: (column) => column,
  );
}

class $$TaxParamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaxParamsTable,
          TaxParam,
          $$TaxParamsTableFilterComposer,
          $$TaxParamsTableOrderingComposer,
          $$TaxParamsTableAnnotationComposer,
          $$TaxParamsTableCreateCompanionBuilder,
          $$TaxParamsTableUpdateCompanionBuilder,
          (TaxParam, BaseReferences<_$AppDatabase, $TaxParamsTable, TaxParam>),
          TaxParam,
          PrefetchHooks Function()
        > {
  $$TaxParamsTableTableManager(_$AppDatabase db, $TaxParamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaxParamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaxParamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaxParamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> year = const Value.absent(),
                Value<int> zelfstandigenaftrek = const Value.absent(),
                Value<int> startersaftrek = const Value.absent(),
                Value<double> mkbWinstvrijstellingPct = const Value.absent(),
                Value<double> bracket1Rate = const Value.absent(),
                Value<int> bracket1Threshold = const Value.absent(),
                Value<double> bracket2Rate = const Value.absent(),
                Value<int> bracket2Threshold = const Value.absent(),
                Value<double> bracket3Rate = const Value.absent(),
                Value<int> algHeffingskortingMax = const Value.absent(),
                Value<int> arbeidskortingMax = const Value.absent(),
                Value<double> zvwRate = const Value.absent(),
                Value<int> zvwMax = const Value.absent(),
                Value<int> mixedCostsThreshold = const Value.absent(),
                Value<double> mixedCosts80Pct = const Value.absent(),
                Value<double> jaarruimtePct = const Value.absent(),
                Value<int> jaarruimteMax = const Value.absent(),
                Value<int> aowFranchise = const Value.absent(),
                Value<int> reserveringsruimteMax = const Value.absent(),
                Value<double> factorAMultiplier = const Value.absent(),
                Value<int> kiaLowerThreshold = const Value.absent(),
                Value<int> kiaUpperThreshold = const Value.absent(),
                Value<int> kiaFlatThreshold = const Value.absent(),
                Value<double> kiaRate = const Value.absent(),
                Value<int> kiaFlatAmount = const Value.absent(),
                Value<double> mileageRatePerKm = const Value.absent(),
                Value<int> korThreshold = const Value.absent(),
                Value<int> ossThreshold = const Value.absent(),
                Value<double> belastingrentePct = const Value.absent(),
              }) => TaxParamsCompanion(
                year: year,
                zelfstandigenaftrek: zelfstandigenaftrek,
                startersaftrek: startersaftrek,
                mkbWinstvrijstellingPct: mkbWinstvrijstellingPct,
                bracket1Rate: bracket1Rate,
                bracket1Threshold: bracket1Threshold,
                bracket2Rate: bracket2Rate,
                bracket2Threshold: bracket2Threshold,
                bracket3Rate: bracket3Rate,
                algHeffingskortingMax: algHeffingskortingMax,
                arbeidskortingMax: arbeidskortingMax,
                zvwRate: zvwRate,
                zvwMax: zvwMax,
                mixedCostsThreshold: mixedCostsThreshold,
                mixedCosts80Pct: mixedCosts80Pct,
                jaarruimtePct: jaarruimtePct,
                jaarruimteMax: jaarruimteMax,
                aowFranchise: aowFranchise,
                reserveringsruimteMax: reserveringsruimteMax,
                factorAMultiplier: factorAMultiplier,
                kiaLowerThreshold: kiaLowerThreshold,
                kiaUpperThreshold: kiaUpperThreshold,
                kiaFlatThreshold: kiaFlatThreshold,
                kiaRate: kiaRate,
                kiaFlatAmount: kiaFlatAmount,
                mileageRatePerKm: mileageRatePerKm,
                korThreshold: korThreshold,
                ossThreshold: ossThreshold,
                belastingrentePct: belastingrentePct,
              ),
          createCompanionCallback:
              ({
                Value<int> year = const Value.absent(),
                required int zelfstandigenaftrek,
                required int startersaftrek,
                required double mkbWinstvrijstellingPct,
                required double bracket1Rate,
                required int bracket1Threshold,
                required double bracket2Rate,
                required int bracket2Threshold,
                required double bracket3Rate,
                required int algHeffingskortingMax,
                required int arbeidskortingMax,
                required double zvwRate,
                required int zvwMax,
                required int mixedCostsThreshold,
                required double mixedCosts80Pct,
                required double jaarruimtePct,
                required int jaarruimteMax,
                required int aowFranchise,
                required int reserveringsruimteMax,
                required double factorAMultiplier,
                required int kiaLowerThreshold,
                required int kiaUpperThreshold,
                required int kiaFlatThreshold,
                required double kiaRate,
                required int kiaFlatAmount,
                required double mileageRatePerKm,
                required int korThreshold,
                required int ossThreshold,
                required double belastingrentePct,
              }) => TaxParamsCompanion.insert(
                year: year,
                zelfstandigenaftrek: zelfstandigenaftrek,
                startersaftrek: startersaftrek,
                mkbWinstvrijstellingPct: mkbWinstvrijstellingPct,
                bracket1Rate: bracket1Rate,
                bracket1Threshold: bracket1Threshold,
                bracket2Rate: bracket2Rate,
                bracket2Threshold: bracket2Threshold,
                bracket3Rate: bracket3Rate,
                algHeffingskortingMax: algHeffingskortingMax,
                arbeidskortingMax: arbeidskortingMax,
                zvwRate: zvwRate,
                zvwMax: zvwMax,
                mixedCostsThreshold: mixedCostsThreshold,
                mixedCosts80Pct: mixedCosts80Pct,
                jaarruimtePct: jaarruimtePct,
                jaarruimteMax: jaarruimteMax,
                aowFranchise: aowFranchise,
                reserveringsruimteMax: reserveringsruimteMax,
                factorAMultiplier: factorAMultiplier,
                kiaLowerThreshold: kiaLowerThreshold,
                kiaUpperThreshold: kiaUpperThreshold,
                kiaFlatThreshold: kiaFlatThreshold,
                kiaRate: kiaRate,
                kiaFlatAmount: kiaFlatAmount,
                mileageRatePerKm: mileageRatePerKm,
                korThreshold: korThreshold,
                ossThreshold: ossThreshold,
                belastingrentePct: belastingrentePct,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TaxParamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaxParamsTable,
      TaxParam,
      $$TaxParamsTableFilterComposer,
      $$TaxParamsTableOrderingComposer,
      $$TaxParamsTableAnnotationComposer,
      $$TaxParamsTableCreateCompanionBuilder,
      $$TaxParamsTableUpdateCompanionBuilder,
      (TaxParam, BaseReferences<_$AppDatabase, $TaxParamsTable, TaxParam>),
      TaxParam,
      PrefetchHooks Function()
    >;
typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      required String name,
      Value<String> country,
      Value<String?> vatNumber,
      Value<String?> kvkNumber,
      Value<String?> address,
      Value<String?> contactPerson,
      Value<String?> email,
      Value<String?> phone,
      Value<String> wetDbaRiskLevel,
      Value<bool> contractSigned,
      Value<DateTime?> contractExpiry,
      Value<String?> notes,
      Value<bool> isActive,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> country,
      Value<String?> vatNumber,
      Value<String?> kvkNumber,
      Value<String?> address,
      Value<String?> contactPerson,
      Value<String?> email,
      Value<String?> phone,
      Value<String> wetDbaRiskLevel,
      Value<bool> contractSigned,
      Value<DateTime?> contractExpiry,
      Value<String?> notes,
      Value<bool> isActive,
    });

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: $_aliasNameGenerator(db.clients.id, db.invoices.clientId),
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vatNumber => $composableBuilder(
    column: $table.vatNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kvkNumber => $composableBuilder(
    column: $table.kvkNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wetDbaRiskLevel => $composableBuilder(
    column: $table.wetDbaRiskLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get contractSigned => $composableBuilder(
    column: $table.contractSigned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get contractExpiry => $composableBuilder(
    column: $table.contractExpiry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vatNumber => $composableBuilder(
    column: $table.vatNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kvkNumber => $composableBuilder(
    column: $table.kvkNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wetDbaRiskLevel => $composableBuilder(
    column: $table.wetDbaRiskLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get contractSigned => $composableBuilder(
    column: $table.contractSigned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get contractExpiry => $composableBuilder(
    column: $table.contractExpiry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get vatNumber =>
      $composableBuilder(column: $table.vatNumber, builder: (column) => column);

  GeneratedColumn<String> get kvkNumber =>
      $composableBuilder(column: $table.kvkNumber, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get contactPerson => $composableBuilder(
    column: $table.contactPerson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get wetDbaRiskLevel => $composableBuilder(
    column: $table.wetDbaRiskLevel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get contractSigned => $composableBuilder(
    column: $table.contractSigned,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get contractExpiry => $composableBuilder(
    column: $table.contractExpiry,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, $$ClientsTableReferences),
          Client,
          PrefetchHooks Function({bool invoicesRefs})
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String?> vatNumber = const Value.absent(),
                Value<String?> kvkNumber = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> wetDbaRiskLevel = const Value.absent(),
                Value<bool> contractSigned = const Value.absent(),
                Value<DateTime?> contractExpiry = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                name: name,
                country: country,
                vatNumber: vatNumber,
                kvkNumber: kvkNumber,
                address: address,
                contactPerson: contactPerson,
                email: email,
                phone: phone,
                wetDbaRiskLevel: wetDbaRiskLevel,
                contractSigned: contractSigned,
                contractExpiry: contractExpiry,
                notes: notes,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> country = const Value.absent(),
                Value<String?> vatNumber = const Value.absent(),
                Value<String?> kvkNumber = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> wetDbaRiskLevel = const Value.absent(),
                Value<bool> contractSigned = const Value.absent(),
                Value<DateTime?> contractExpiry = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                name: name,
                country: country,
                vatNumber: vatNumber,
                kvkNumber: kvkNumber,
                address: address,
                contactPerson: contactPerson,
                email: email,
                phone: phone,
                wetDbaRiskLevel: wetDbaRiskLevel,
                contractSigned: contractSigned,
                contractExpiry: contractExpiry,
                notes: notes,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoicesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (invoicesRefs) db.invoices],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (invoicesRefs)
                    await $_getPrefetchedData<Client, $ClientsTable, Invoice>(
                      currentTable: table,
                      referencedTable: $$ClientsTableReferences
                          ._invoicesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ClientsTableReferences(db, table, p0).invoicesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.clientId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, $$ClientsTableReferences),
      Client,
      PrefetchHooks Function({bool invoicesRefs})
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      required String invoiceNumber,
      required DateTime invoiceDate,
      Value<DateTime?> supplyDate,
      required int clientId,
      Value<String> invoiceType,
      required String sellerName,
      required String sellerVatNumber,
      required String sellerKvkNumber,
      required String sellerAddress,
      Value<int> paymentTermDays,
      required DateTime dueDate,
      Value<String> status,
      Value<DateTime?> paidDate,
      Value<String?> paymentMethod,
      Value<String?> notes,
      Value<bool> isReverseCharge,
      Value<bool> isIcp,
      Value<String?> reverseChargeNote,
      Value<int> totalExclVat,
      Value<int> totalVat,
      Value<int> totalInclVat,
      required int fiscalYear,
      required String quarter,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      Value<String> invoiceNumber,
      Value<DateTime> invoiceDate,
      Value<DateTime?> supplyDate,
      Value<int> clientId,
      Value<String> invoiceType,
      Value<String> sellerName,
      Value<String> sellerVatNumber,
      Value<String> sellerKvkNumber,
      Value<String> sellerAddress,
      Value<int> paymentTermDays,
      Value<DateTime> dueDate,
      Value<String> status,
      Value<DateTime?> paidDate,
      Value<String?> paymentMethod,
      Value<String?> notes,
      Value<bool> isReverseCharge,
      Value<bool> isIcp,
      Value<String?> reverseChargeNote,
      Value<int> totalExclVat,
      Value<int> totalVat,
      Value<int> totalInclVat,
      Value<int> fiscalYear,
      Value<String> quarter,
    });

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) => db.clients
      .createAlias($_aliasNameGenerator(db.invoices.clientId, db.clients.id));

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoiceLinesTable, List<InvoiceLine>>
  _invoiceLinesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceLines,
    aliasName: $_aliasNameGenerator(db.invoices.id, db.invoiceLines.invoiceId),
  );

  $$InvoiceLinesTableProcessedTableManager get invoiceLinesRefs {
    final manager = $$InvoiceLinesTableTableManager(
      $_db,
      $_db.invoiceLines,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceLinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get supplyDate => $composableBuilder(
    column: $table.supplyDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceType => $composableBuilder(
    column: $table.invoiceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sellerName => $composableBuilder(
    column: $table.sellerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sellerVatNumber => $composableBuilder(
    column: $table.sellerVatNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sellerKvkNumber => $composableBuilder(
    column: $table.sellerKvkNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sellerAddress => $composableBuilder(
    column: $table.sellerAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentTermDays => $composableBuilder(
    column: $table.paymentTermDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidDate => $composableBuilder(
    column: $table.paidDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isReverseCharge => $composableBuilder(
    column: $table.isReverseCharge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isIcp => $composableBuilder(
    column: $table.isIcp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reverseChargeNote => $composableBuilder(
    column: $table.reverseChargeNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalExclVat => $composableBuilder(
    column: $table.totalExclVat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalVat => $composableBuilder(
    column: $table.totalVat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalInclVat => $composableBuilder(
    column: $table.totalInclVat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quarter => $composableBuilder(
    column: $table.quarter,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoiceLinesRefs(
    Expression<bool> Function($$InvoiceLinesTableFilterComposer f) f,
  ) {
    final $$InvoiceLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceLines,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceLinesTableFilterComposer(
            $db: $db,
            $table: $db.invoiceLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get supplyDate => $composableBuilder(
    column: $table.supplyDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceType => $composableBuilder(
    column: $table.invoiceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sellerName => $composableBuilder(
    column: $table.sellerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sellerVatNumber => $composableBuilder(
    column: $table.sellerVatNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sellerKvkNumber => $composableBuilder(
    column: $table.sellerKvkNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sellerAddress => $composableBuilder(
    column: $table.sellerAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentTermDays => $composableBuilder(
    column: $table.paymentTermDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidDate => $composableBuilder(
    column: $table.paidDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isReverseCharge => $composableBuilder(
    column: $table.isReverseCharge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isIcp => $composableBuilder(
    column: $table.isIcp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reverseChargeNote => $composableBuilder(
    column: $table.reverseChargeNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalExclVat => $composableBuilder(
    column: $table.totalExclVat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalVat => $composableBuilder(
    column: $table.totalVat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalInclVat => $composableBuilder(
    column: $table.totalInclVat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quarter => $composableBuilder(
    column: $table.quarter,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get supplyDate => $composableBuilder(
    column: $table.supplyDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoiceType => $composableBuilder(
    column: $table.invoiceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sellerName => $composableBuilder(
    column: $table.sellerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sellerVatNumber => $composableBuilder(
    column: $table.sellerVatNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sellerKvkNumber => $composableBuilder(
    column: $table.sellerKvkNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sellerAddress => $composableBuilder(
    column: $table.sellerAddress,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paymentTermDays => $composableBuilder(
    column: $table.paymentTermDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get paidDate =>
      $composableBuilder(column: $table.paidDate, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isReverseCharge => $composableBuilder(
    column: $table.isReverseCharge,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isIcp =>
      $composableBuilder(column: $table.isIcp, builder: (column) => column);

  GeneratedColumn<String> get reverseChargeNote => $composableBuilder(
    column: $table.reverseChargeNote,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalExclVat => $composableBuilder(
    column: $table.totalExclVat,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalVat =>
      $composableBuilder(column: $table.totalVat, builder: (column) => column);

  GeneratedColumn<int> get totalInclVat => $composableBuilder(
    column: $table.totalInclVat,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quarter =>
      $composableBuilder(column: $table.quarter, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoiceLinesRefs<T extends Object>(
    Expression<T> Function($$InvoiceLinesTableAnnotationComposer a) f,
  ) {
    final $$InvoiceLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceLines,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, $$InvoicesTableReferences),
          Invoice,
          PrefetchHooks Function({bool clientId, bool invoiceLinesRefs})
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<DateTime> invoiceDate = const Value.absent(),
                Value<DateTime?> supplyDate = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<String> invoiceType = const Value.absent(),
                Value<String> sellerName = const Value.absent(),
                Value<String> sellerVatNumber = const Value.absent(),
                Value<String> sellerKvkNumber = const Value.absent(),
                Value<String> sellerAddress = const Value.absent(),
                Value<int> paymentTermDays = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> paidDate = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isReverseCharge = const Value.absent(),
                Value<bool> isIcp = const Value.absent(),
                Value<String?> reverseChargeNote = const Value.absent(),
                Value<int> totalExclVat = const Value.absent(),
                Value<int> totalVat = const Value.absent(),
                Value<int> totalInclVat = const Value.absent(),
                Value<int> fiscalYear = const Value.absent(),
                Value<String> quarter = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                invoiceNumber: invoiceNumber,
                invoiceDate: invoiceDate,
                supplyDate: supplyDate,
                clientId: clientId,
                invoiceType: invoiceType,
                sellerName: sellerName,
                sellerVatNumber: sellerVatNumber,
                sellerKvkNumber: sellerKvkNumber,
                sellerAddress: sellerAddress,
                paymentTermDays: paymentTermDays,
                dueDate: dueDate,
                status: status,
                paidDate: paidDate,
                paymentMethod: paymentMethod,
                notes: notes,
                isReverseCharge: isReverseCharge,
                isIcp: isIcp,
                reverseChargeNote: reverseChargeNote,
                totalExclVat: totalExclVat,
                totalVat: totalVat,
                totalInclVat: totalInclVat,
                fiscalYear: fiscalYear,
                quarter: quarter,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String invoiceNumber,
                required DateTime invoiceDate,
                Value<DateTime?> supplyDate = const Value.absent(),
                required int clientId,
                Value<String> invoiceType = const Value.absent(),
                required String sellerName,
                required String sellerVatNumber,
                required String sellerKvkNumber,
                required String sellerAddress,
                Value<int> paymentTermDays = const Value.absent(),
                required DateTime dueDate,
                Value<String> status = const Value.absent(),
                Value<DateTime?> paidDate = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isReverseCharge = const Value.absent(),
                Value<bool> isIcp = const Value.absent(),
                Value<String?> reverseChargeNote = const Value.absent(),
                Value<int> totalExclVat = const Value.absent(),
                Value<int> totalVat = const Value.absent(),
                Value<int> totalInclVat = const Value.absent(),
                required int fiscalYear,
                required String quarter,
              }) => InvoicesCompanion.insert(
                id: id,
                invoiceNumber: invoiceNumber,
                invoiceDate: invoiceDate,
                supplyDate: supplyDate,
                clientId: clientId,
                invoiceType: invoiceType,
                sellerName: sellerName,
                sellerVatNumber: sellerVatNumber,
                sellerKvkNumber: sellerKvkNumber,
                sellerAddress: sellerAddress,
                paymentTermDays: paymentTermDays,
                dueDate: dueDate,
                status: status,
                paidDate: paidDate,
                paymentMethod: paymentMethod,
                notes: notes,
                isReverseCharge: isReverseCharge,
                isIcp: isIcp,
                reverseChargeNote: reverseChargeNote,
                totalExclVat: totalExclVat,
                totalVat: totalVat,
                totalInclVat: totalInclVat,
                fiscalYear: fiscalYear,
                quarter: quarter,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({clientId = false, invoiceLinesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceLinesRefs) db.invoiceLines,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._clientIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._clientIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoiceLinesRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          InvoiceLine
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._invoiceLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceLinesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, $$InvoicesTableReferences),
      Invoice,
      PrefetchHooks Function({bool clientId, bool invoiceLinesRefs})
    >;
typedef $$InvoiceLinesTableCreateCompanionBuilder =
    InvoiceLinesCompanion Function({
      Value<int> id,
      required int invoiceId,
      required String description,
      Value<String> quantityUnit,
      Value<double> quantity,
      required int unitPriceExclVat,
      Value<String> vatRate,
      Value<int> vatAmount,
      Value<int> lineTotalExclVat,
      Value<int> sortOrder,
    });
typedef $$InvoiceLinesTableUpdateCompanionBuilder =
    InvoiceLinesCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<String> description,
      Value<String> quantityUnit,
      Value<double> quantity,
      Value<int> unitPriceExclVat,
      Value<String> vatRate,
      Value<int> vatAmount,
      Value<int> lineTotalExclVat,
      Value<int> sortOrder,
    });

final class $$InvoiceLinesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoiceLinesTable, InvoiceLine> {
  $$InvoiceLinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias(
        $_aliasNameGenerator(db.invoiceLines.invoiceId, db.invoices.id),
      );

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvoiceLinesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceLinesTable> {
  $$InvoiceLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quantityUnit => $composableBuilder(
    column: $table.quantityUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceExclVat => $composableBuilder(
    column: $table.unitPriceExclVat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vatRate => $composableBuilder(
    column: $table.vatRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vatAmount => $composableBuilder(
    column: $table.vatAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineTotalExclVat => $composableBuilder(
    column: $table.lineTotalExclVat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceLinesTable> {
  $$InvoiceLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quantityUnit => $composableBuilder(
    column: $table.quantityUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPriceExclVat => $composableBuilder(
    column: $table.unitPriceExclVat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vatRate => $composableBuilder(
    column: $table.vatRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vatAmount => $composableBuilder(
    column: $table.vatAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineTotalExclVat => $composableBuilder(
    column: $table.lineTotalExclVat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceLinesTable> {
  $$InvoiceLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quantityUnit => $composableBuilder(
    column: $table.quantityUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get unitPriceExclVat => $composableBuilder(
    column: $table.unitPriceExclVat,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vatRate =>
      $composableBuilder(column: $table.vatRate, builder: (column) => column);

  GeneratedColumn<int> get vatAmount =>
      $composableBuilder(column: $table.vatAmount, builder: (column) => column);

  GeneratedColumn<int> get lineTotalExclVat => $composableBuilder(
    column: $table.lineTotalExclVat,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceLinesTable,
          InvoiceLine,
          $$InvoiceLinesTableFilterComposer,
          $$InvoiceLinesTableOrderingComposer,
          $$InvoiceLinesTableAnnotationComposer,
          $$InvoiceLinesTableCreateCompanionBuilder,
          $$InvoiceLinesTableUpdateCompanionBuilder,
          (InvoiceLine, $$InvoiceLinesTableReferences),
          InvoiceLine,
          PrefetchHooks Function({bool invoiceId})
        > {
  $$InvoiceLinesTableTableManager(_$AppDatabase db, $InvoiceLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> quantityUnit = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<int> unitPriceExclVat = const Value.absent(),
                Value<String> vatRate = const Value.absent(),
                Value<int> vatAmount = const Value.absent(),
                Value<int> lineTotalExclVat = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => InvoiceLinesCompanion(
                id: id,
                invoiceId: invoiceId,
                description: description,
                quantityUnit: quantityUnit,
                quantity: quantity,
                unitPriceExclVat: unitPriceExclVat,
                vatRate: vatRate,
                vatAmount: vatAmount,
                lineTotalExclVat: lineTotalExclVat,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required String description,
                Value<String> quantityUnit = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                required int unitPriceExclVat,
                Value<String> vatRate = const Value.absent(),
                Value<int> vatAmount = const Value.absent(),
                Value<int> lineTotalExclVat = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => InvoiceLinesCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                description: description,
                quantityUnit: quantityUnit,
                quantity: quantity,
                unitPriceExclVat: unitPriceExclVat,
                vatRate: vatRate,
                vatAmount: vatAmount,
                lineTotalExclVat: lineTotalExclVat,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoiceLinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable: $$InvoiceLinesTableReferences
                                    ._invoiceIdTable(db),
                                referencedColumn: $$InvoiceLinesTableReferences
                                    ._invoiceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InvoiceLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceLinesTable,
      InvoiceLine,
      $$InvoiceLinesTableFilterComposer,
      $$InvoiceLinesTableOrderingComposer,
      $$InvoiceLinesTableAnnotationComposer,
      $$InvoiceLinesTableCreateCompanionBuilder,
      $$InvoiceLinesTableUpdateCompanionBuilder,
      (InvoiceLine, $$InvoiceLinesTableReferences),
      InvoiceLine,
      PrefetchHooks Function({bool invoiceId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      required DateTime date,
      required String supplier,
      required String description,
      required String category,
      Value<bool> receiptAttached,
      required int amountExclVat,
      Value<String> vatRate,
      Value<int> vatAmount,
      Value<int> totalInclVat,
      Value<double> businessUsePct,
      Value<int> deductibleAmount,
      Value<bool> vatReclaimable,
      Value<int> vatToReclaim,
      Value<bool> isMixedCost,
      Value<String?> notes,
      Value<String?> paidFrom,
      Value<String?> paymentReference,
      required int fiscalYear,
      required String quarter,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> supplier,
      Value<String> description,
      Value<String> category,
      Value<bool> receiptAttached,
      Value<int> amountExclVat,
      Value<String> vatRate,
      Value<int> vatAmount,
      Value<int> totalInclVat,
      Value<double> businessUsePct,
      Value<int> deductibleAmount,
      Value<bool> vatReclaimable,
      Value<int> vatToReclaim,
      Value<bool> isMixedCost,
      Value<String?> notes,
      Value<String?> paidFrom,
      Value<String?> paymentReference,
      Value<int> fiscalYear,
      Value<String> quarter,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get receiptAttached => $composableBuilder(
    column: $table.receiptAttached,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountExclVat => $composableBuilder(
    column: $table.amountExclVat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vatRate => $composableBuilder(
    column: $table.vatRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vatAmount => $composableBuilder(
    column: $table.vatAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalInclVat => $composableBuilder(
    column: $table.totalInclVat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get businessUsePct => $composableBuilder(
    column: $table.businessUsePct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deductibleAmount => $composableBuilder(
    column: $table.deductibleAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get vatReclaimable => $composableBuilder(
    column: $table.vatReclaimable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vatToReclaim => $composableBuilder(
    column: $table.vatToReclaim,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMixedCost => $composableBuilder(
    column: $table.isMixedCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paidFrom => $composableBuilder(
    column: $table.paidFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentReference => $composableBuilder(
    column: $table.paymentReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quarter => $composableBuilder(
    column: $table.quarter,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get receiptAttached => $composableBuilder(
    column: $table.receiptAttached,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountExclVat => $composableBuilder(
    column: $table.amountExclVat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vatRate => $composableBuilder(
    column: $table.vatRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vatAmount => $composableBuilder(
    column: $table.vatAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalInclVat => $composableBuilder(
    column: $table.totalInclVat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get businessUsePct => $composableBuilder(
    column: $table.businessUsePct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deductibleAmount => $composableBuilder(
    column: $table.deductibleAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get vatReclaimable => $composableBuilder(
    column: $table.vatReclaimable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vatToReclaim => $composableBuilder(
    column: $table.vatToReclaim,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMixedCost => $composableBuilder(
    column: $table.isMixedCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paidFrom => $composableBuilder(
    column: $table.paidFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentReference => $composableBuilder(
    column: $table.paymentReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quarter => $composableBuilder(
    column: $table.quarter,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get supplier =>
      $composableBuilder(column: $table.supplier, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get receiptAttached => $composableBuilder(
    column: $table.receiptAttached,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountExclVat => $composableBuilder(
    column: $table.amountExclVat,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vatRate =>
      $composableBuilder(column: $table.vatRate, builder: (column) => column);

  GeneratedColumn<int> get vatAmount =>
      $composableBuilder(column: $table.vatAmount, builder: (column) => column);

  GeneratedColumn<int> get totalInclVat => $composableBuilder(
    column: $table.totalInclVat,
    builder: (column) => column,
  );

  GeneratedColumn<double> get businessUsePct => $composableBuilder(
    column: $table.businessUsePct,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deductibleAmount => $composableBuilder(
    column: $table.deductibleAmount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get vatReclaimable => $composableBuilder(
    column: $table.vatReclaimable,
    builder: (column) => column,
  );

  GeneratedColumn<int> get vatToReclaim => $composableBuilder(
    column: $table.vatToReclaim,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMixedCost => $composableBuilder(
    column: $table.isMixedCost,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get paidFrom =>
      $composableBuilder(column: $table.paidFrom, builder: (column) => column);

  GeneratedColumn<String> get paymentReference => $composableBuilder(
    column: $table.paymentReference,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quarter =>
      $composableBuilder(column: $table.quarter, builder: (column) => column);
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> supplier = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> receiptAttached = const Value.absent(),
                Value<int> amountExclVat = const Value.absent(),
                Value<String> vatRate = const Value.absent(),
                Value<int> vatAmount = const Value.absent(),
                Value<int> totalInclVat = const Value.absent(),
                Value<double> businessUsePct = const Value.absent(),
                Value<int> deductibleAmount = const Value.absent(),
                Value<bool> vatReclaimable = const Value.absent(),
                Value<int> vatToReclaim = const Value.absent(),
                Value<bool> isMixedCost = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> paidFrom = const Value.absent(),
                Value<String?> paymentReference = const Value.absent(),
                Value<int> fiscalYear = const Value.absent(),
                Value<String> quarter = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                date: date,
                supplier: supplier,
                description: description,
                category: category,
                receiptAttached: receiptAttached,
                amountExclVat: amountExclVat,
                vatRate: vatRate,
                vatAmount: vatAmount,
                totalInclVat: totalInclVat,
                businessUsePct: businessUsePct,
                deductibleAmount: deductibleAmount,
                vatReclaimable: vatReclaimable,
                vatToReclaim: vatToReclaim,
                isMixedCost: isMixedCost,
                notes: notes,
                paidFrom: paidFrom,
                paymentReference: paymentReference,
                fiscalYear: fiscalYear,
                quarter: quarter,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String supplier,
                required String description,
                required String category,
                Value<bool> receiptAttached = const Value.absent(),
                required int amountExclVat,
                Value<String> vatRate = const Value.absent(),
                Value<int> vatAmount = const Value.absent(),
                Value<int> totalInclVat = const Value.absent(),
                Value<double> businessUsePct = const Value.absent(),
                Value<int> deductibleAmount = const Value.absent(),
                Value<bool> vatReclaimable = const Value.absent(),
                Value<int> vatToReclaim = const Value.absent(),
                Value<bool> isMixedCost = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> paidFrom = const Value.absent(),
                Value<String?> paymentReference = const Value.absent(),
                required int fiscalYear,
                required String quarter,
              }) => ExpensesCompanion.insert(
                id: id,
                date: date,
                supplier: supplier,
                description: description,
                category: category,
                receiptAttached: receiptAttached,
                amountExclVat: amountExclVat,
                vatRate: vatRate,
                vatAmount: vatAmount,
                totalInclVat: totalInclVat,
                businessUsePct: businessUsePct,
                deductibleAmount: deductibleAmount,
                vatReclaimable: vatReclaimable,
                vatToReclaim: vatToReclaim,
                isMixedCost: isMixedCost,
                notes: notes,
                paidFrom: paidFrom,
                paymentReference: paymentReference,
                fiscalYear: fiscalYear,
                quarter: quarter,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$HourEntriesTableCreateCompanionBuilder =
    HourEntriesCompanion Function({
      Value<int> id,
      required DateTime date,
      required String description,
      required String workType,
      required double hours,
      Value<bool> billable,
      Value<String?> clientProject,
      Value<bool> isWbso,
      Value<String?> notes,
      required int fiscalYear,
      required int weekNumber,
    });
typedef $$HourEntriesTableUpdateCompanionBuilder =
    HourEntriesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> description,
      Value<String> workType,
      Value<double> hours,
      Value<bool> billable,
      Value<String?> clientProject,
      Value<bool> isWbso,
      Value<String?> notes,
      Value<int> fiscalYear,
      Value<int> weekNumber,
    });

class $$HourEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $HourEntriesTable> {
  $$HourEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workType => $composableBuilder(
    column: $table.workType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hours => $composableBuilder(
    column: $table.hours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get billable => $composableBuilder(
    column: $table.billable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientProject => $composableBuilder(
    column: $table.clientProject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isWbso => $composableBuilder(
    column: $table.isWbso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HourEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $HourEntriesTable> {
  $$HourEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workType => $composableBuilder(
    column: $table.workType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hours => $composableBuilder(
    column: $table.hours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get billable => $composableBuilder(
    column: $table.billable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientProject => $composableBuilder(
    column: $table.clientProject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isWbso => $composableBuilder(
    column: $table.isWbso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HourEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HourEntriesTable> {
  $$HourEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workType =>
      $composableBuilder(column: $table.workType, builder: (column) => column);

  GeneratedColumn<double> get hours =>
      $composableBuilder(column: $table.hours, builder: (column) => column);

  GeneratedColumn<bool> get billable =>
      $composableBuilder(column: $table.billable, builder: (column) => column);

  GeneratedColumn<String> get clientProject => $composableBuilder(
    column: $table.clientProject,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isWbso =>
      $composableBuilder(column: $table.isWbso, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weekNumber => $composableBuilder(
    column: $table.weekNumber,
    builder: (column) => column,
  );
}

class $$HourEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HourEntriesTable,
          HourEntry,
          $$HourEntriesTableFilterComposer,
          $$HourEntriesTableOrderingComposer,
          $$HourEntriesTableAnnotationComposer,
          $$HourEntriesTableCreateCompanionBuilder,
          $$HourEntriesTableUpdateCompanionBuilder,
          (
            HourEntry,
            BaseReferences<_$AppDatabase, $HourEntriesTable, HourEntry>,
          ),
          HourEntry,
          PrefetchHooks Function()
        > {
  $$HourEntriesTableTableManager(_$AppDatabase db, $HourEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HourEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HourEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HourEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> workType = const Value.absent(),
                Value<double> hours = const Value.absent(),
                Value<bool> billable = const Value.absent(),
                Value<String?> clientProject = const Value.absent(),
                Value<bool> isWbso = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> fiscalYear = const Value.absent(),
                Value<int> weekNumber = const Value.absent(),
              }) => HourEntriesCompanion(
                id: id,
                date: date,
                description: description,
                workType: workType,
                hours: hours,
                billable: billable,
                clientProject: clientProject,
                isWbso: isWbso,
                notes: notes,
                fiscalYear: fiscalYear,
                weekNumber: weekNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String description,
                required String workType,
                required double hours,
                Value<bool> billable = const Value.absent(),
                Value<String?> clientProject = const Value.absent(),
                Value<bool> isWbso = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int fiscalYear,
                required int weekNumber,
              }) => HourEntriesCompanion.insert(
                id: id,
                date: date,
                description: description,
                workType: workType,
                hours: hours,
                billable: billable,
                clientProject: clientProject,
                isWbso: isWbso,
                notes: notes,
                fiscalYear: fiscalYear,
                weekNumber: weekNumber,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HourEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HourEntriesTable,
      HourEntry,
      $$HourEntriesTableFilterComposer,
      $$HourEntriesTableOrderingComposer,
      $$HourEntriesTableAnnotationComposer,
      $$HourEntriesTableCreateCompanionBuilder,
      $$HourEntriesTableUpdateCompanionBuilder,
      (HourEntry, BaseReferences<_$AppDatabase, $HourEntriesTable, HourEntry>),
      HourEntry,
      PrefetchHooks Function()
    >;
typedef $$MileageTripsTableCreateCompanionBuilder =
    MileageTripsCompanion Function({
      Value<int> id,
      required DateTime date,
      required String vehicleMakeModel,
      required String vehicleLicensePlate,
      required String departureAddress,
      required String arrivalAddress,
      required int odometerStart,
      required int odometerEnd,
      required int distanceKm,
      Value<String> tripType,
      required String purpose,
      Value<bool> routeDeviation,
      Value<String?> notes,
      required int fiscalYear,
    });
typedef $$MileageTripsTableUpdateCompanionBuilder =
    MileageTripsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> vehicleMakeModel,
      Value<String> vehicleLicensePlate,
      Value<String> departureAddress,
      Value<String> arrivalAddress,
      Value<int> odometerStart,
      Value<int> odometerEnd,
      Value<int> distanceKm,
      Value<String> tripType,
      Value<String> purpose,
      Value<bool> routeDeviation,
      Value<String?> notes,
      Value<int> fiscalYear,
    });

class $$MileageTripsTableFilterComposer
    extends Composer<_$AppDatabase, $MileageTripsTable> {
  $$MileageTripsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleMakeModel => $composableBuilder(
    column: $table.vehicleMakeModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleLicensePlate => $composableBuilder(
    column: $table.vehicleLicensePlate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get departureAddress => $composableBuilder(
    column: $table.departureAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arrivalAddress => $composableBuilder(
    column: $table.arrivalAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometerStart => $composableBuilder(
    column: $table.odometerStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get odometerEnd => $composableBuilder(
    column: $table.odometerEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tripType => $composableBuilder(
    column: $table.tripType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get routeDeviation => $composableBuilder(
    column: $table.routeDeviation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MileageTripsTableOrderingComposer
    extends Composer<_$AppDatabase, $MileageTripsTable> {
  $$MileageTripsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleMakeModel => $composableBuilder(
    column: $table.vehicleMakeModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleLicensePlate => $composableBuilder(
    column: $table.vehicleLicensePlate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get departureAddress => $composableBuilder(
    column: $table.departureAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arrivalAddress => $composableBuilder(
    column: $table.arrivalAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometerStart => $composableBuilder(
    column: $table.odometerStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get odometerEnd => $composableBuilder(
    column: $table.odometerEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tripType => $composableBuilder(
    column: $table.tripType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get routeDeviation => $composableBuilder(
    column: $table.routeDeviation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MileageTripsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MileageTripsTable> {
  $$MileageTripsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get vehicleMakeModel => $composableBuilder(
    column: $table.vehicleMakeModel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vehicleLicensePlate => $composableBuilder(
    column: $table.vehicleLicensePlate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get departureAddress => $composableBuilder(
    column: $table.departureAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get arrivalAddress => $composableBuilder(
    column: $table.arrivalAddress,
    builder: (column) => column,
  );

  GeneratedColumn<int> get odometerStart => $composableBuilder(
    column: $table.odometerStart,
    builder: (column) => column,
  );

  GeneratedColumn<int> get odometerEnd => $composableBuilder(
    column: $table.odometerEnd,
    builder: (column) => column,
  );

  GeneratedColumn<int> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tripType =>
      $composableBuilder(column: $table.tripType, builder: (column) => column);

  GeneratedColumn<String> get purpose =>
      $composableBuilder(column: $table.purpose, builder: (column) => column);

  GeneratedColumn<bool> get routeDeviation => $composableBuilder(
    column: $table.routeDeviation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => column,
  );
}

class $$MileageTripsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MileageTripsTable,
          MileageTrip,
          $$MileageTripsTableFilterComposer,
          $$MileageTripsTableOrderingComposer,
          $$MileageTripsTableAnnotationComposer,
          $$MileageTripsTableCreateCompanionBuilder,
          $$MileageTripsTableUpdateCompanionBuilder,
          (
            MileageTrip,
            BaseReferences<_$AppDatabase, $MileageTripsTable, MileageTrip>,
          ),
          MileageTrip,
          PrefetchHooks Function()
        > {
  $$MileageTripsTableTableManager(_$AppDatabase db, $MileageTripsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MileageTripsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MileageTripsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MileageTripsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> vehicleMakeModel = const Value.absent(),
                Value<String> vehicleLicensePlate = const Value.absent(),
                Value<String> departureAddress = const Value.absent(),
                Value<String> arrivalAddress = const Value.absent(),
                Value<int> odometerStart = const Value.absent(),
                Value<int> odometerEnd = const Value.absent(),
                Value<int> distanceKm = const Value.absent(),
                Value<String> tripType = const Value.absent(),
                Value<String> purpose = const Value.absent(),
                Value<bool> routeDeviation = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> fiscalYear = const Value.absent(),
              }) => MileageTripsCompanion(
                id: id,
                date: date,
                vehicleMakeModel: vehicleMakeModel,
                vehicleLicensePlate: vehicleLicensePlate,
                departureAddress: departureAddress,
                arrivalAddress: arrivalAddress,
                odometerStart: odometerStart,
                odometerEnd: odometerEnd,
                distanceKm: distanceKm,
                tripType: tripType,
                purpose: purpose,
                routeDeviation: routeDeviation,
                notes: notes,
                fiscalYear: fiscalYear,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String vehicleMakeModel,
                required String vehicleLicensePlate,
                required String departureAddress,
                required String arrivalAddress,
                required int odometerStart,
                required int odometerEnd,
                required int distanceKm,
                Value<String> tripType = const Value.absent(),
                required String purpose,
                Value<bool> routeDeviation = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int fiscalYear,
              }) => MileageTripsCompanion.insert(
                id: id,
                date: date,
                vehicleMakeModel: vehicleMakeModel,
                vehicleLicensePlate: vehicleLicensePlate,
                departureAddress: departureAddress,
                arrivalAddress: arrivalAddress,
                odometerStart: odometerStart,
                odometerEnd: odometerEnd,
                distanceKm: distanceKm,
                tripType: tripType,
                purpose: purpose,
                routeDeviation: routeDeviation,
                notes: notes,
                fiscalYear: fiscalYear,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MileageTripsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MileageTripsTable,
      MileageTrip,
      $$MileageTripsTableFilterComposer,
      $$MileageTripsTableOrderingComposer,
      $$MileageTripsTableAnnotationComposer,
      $$MileageTripsTableCreateCompanionBuilder,
      $$MileageTripsTableUpdateCompanionBuilder,
      (
        MileageTrip,
        BaseReferences<_$AppDatabase, $MileageTripsTable, MileageTrip>,
      ),
      MileageTrip,
      PrefetchHooks Function()
    >;
typedef $$FixedAssetsTableCreateCompanionBuilder =
    FixedAssetsCompanion Function({
      Value<int> id,
      required int fiscalYear,
      required String assetName,
      required int costExclVat,
      required DateTime purchaseDate,
      Value<double> businessUsePct,
      required int usefulLifeYears,
      Value<bool> kiaEligible,
      Value<bool> eiaOrMia,
      Value<String?> notes,
      Value<DateTime?> disposalDate,
      Value<int?> disposalProceeds,
    });
typedef $$FixedAssetsTableUpdateCompanionBuilder =
    FixedAssetsCompanion Function({
      Value<int> id,
      Value<int> fiscalYear,
      Value<String> assetName,
      Value<int> costExclVat,
      Value<DateTime> purchaseDate,
      Value<double> businessUsePct,
      Value<int> usefulLifeYears,
      Value<bool> kiaEligible,
      Value<bool> eiaOrMia,
      Value<String?> notes,
      Value<DateTime?> disposalDate,
      Value<int?> disposalProceeds,
    });

class $$FixedAssetsTableFilterComposer
    extends Composer<_$AppDatabase, $FixedAssetsTable> {
  $$FixedAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetName => $composableBuilder(
    column: $table.assetName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costExclVat => $composableBuilder(
    column: $table.costExclVat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get businessUsePct => $composableBuilder(
    column: $table.businessUsePct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usefulLifeYears => $composableBuilder(
    column: $table.usefulLifeYears,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get kiaEligible => $composableBuilder(
    column: $table.kiaEligible,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get eiaOrMia => $composableBuilder(
    column: $table.eiaOrMia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get disposalDate => $composableBuilder(
    column: $table.disposalDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get disposalProceeds => $composableBuilder(
    column: $table.disposalProceeds,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FixedAssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $FixedAssetsTable> {
  $$FixedAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetName => $composableBuilder(
    column: $table.assetName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costExclVat => $composableBuilder(
    column: $table.costExclVat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get businessUsePct => $composableBuilder(
    column: $table.businessUsePct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usefulLifeYears => $composableBuilder(
    column: $table.usefulLifeYears,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get kiaEligible => $composableBuilder(
    column: $table.kiaEligible,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get eiaOrMia => $composableBuilder(
    column: $table.eiaOrMia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get disposalDate => $composableBuilder(
    column: $table.disposalDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get disposalProceeds => $composableBuilder(
    column: $table.disposalProceeds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FixedAssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FixedAssetsTable> {
  $$FixedAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assetName =>
      $composableBuilder(column: $table.assetName, builder: (column) => column);

  GeneratedColumn<int> get costExclVat => $composableBuilder(
    column: $table.costExclVat,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get businessUsePct => $composableBuilder(
    column: $table.businessUsePct,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usefulLifeYears => $composableBuilder(
    column: $table.usefulLifeYears,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get kiaEligible => $composableBuilder(
    column: $table.kiaEligible,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get eiaOrMia =>
      $composableBuilder(column: $table.eiaOrMia, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get disposalDate => $composableBuilder(
    column: $table.disposalDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get disposalProceeds => $composableBuilder(
    column: $table.disposalProceeds,
    builder: (column) => column,
  );
}

class $$FixedAssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FixedAssetsTable,
          FixedAsset,
          $$FixedAssetsTableFilterComposer,
          $$FixedAssetsTableOrderingComposer,
          $$FixedAssetsTableAnnotationComposer,
          $$FixedAssetsTableCreateCompanionBuilder,
          $$FixedAssetsTableUpdateCompanionBuilder,
          (
            FixedAsset,
            BaseReferences<_$AppDatabase, $FixedAssetsTable, FixedAsset>,
          ),
          FixedAsset,
          PrefetchHooks Function()
        > {
  $$FixedAssetsTableTableManager(_$AppDatabase db, $FixedAssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FixedAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FixedAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FixedAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fiscalYear = const Value.absent(),
                Value<String> assetName = const Value.absent(),
                Value<int> costExclVat = const Value.absent(),
                Value<DateTime> purchaseDate = const Value.absent(),
                Value<double> businessUsePct = const Value.absent(),
                Value<int> usefulLifeYears = const Value.absent(),
                Value<bool> kiaEligible = const Value.absent(),
                Value<bool> eiaOrMia = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> disposalDate = const Value.absent(),
                Value<int?> disposalProceeds = const Value.absent(),
              }) => FixedAssetsCompanion(
                id: id,
                fiscalYear: fiscalYear,
                assetName: assetName,
                costExclVat: costExclVat,
                purchaseDate: purchaseDate,
                businessUsePct: businessUsePct,
                usefulLifeYears: usefulLifeYears,
                kiaEligible: kiaEligible,
                eiaOrMia: eiaOrMia,
                notes: notes,
                disposalDate: disposalDate,
                disposalProceeds: disposalProceeds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fiscalYear,
                required String assetName,
                required int costExclVat,
                required DateTime purchaseDate,
                Value<double> businessUsePct = const Value.absent(),
                required int usefulLifeYears,
                Value<bool> kiaEligible = const Value.absent(),
                Value<bool> eiaOrMia = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> disposalDate = const Value.absent(),
                Value<int?> disposalProceeds = const Value.absent(),
              }) => FixedAssetsCompanion.insert(
                id: id,
                fiscalYear: fiscalYear,
                assetName: assetName,
                costExclVat: costExclVat,
                purchaseDate: purchaseDate,
                businessUsePct: businessUsePct,
                usefulLifeYears: usefulLifeYears,
                kiaEligible: kiaEligible,
                eiaOrMia: eiaOrMia,
                notes: notes,
                disposalDate: disposalDate,
                disposalProceeds: disposalProceeds,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FixedAssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FixedAssetsTable,
      FixedAsset,
      $$FixedAssetsTableFilterComposer,
      $$FixedAssetsTableOrderingComposer,
      $$FixedAssetsTableAnnotationComposer,
      $$FixedAssetsTableCreateCompanionBuilder,
      $$FixedAssetsTableUpdateCompanionBuilder,
      (
        FixedAsset,
        BaseReferences<_$AppDatabase, $FixedAssetsTable, FixedAsset>,
      ),
      FixedAsset,
      PrefetchHooks Function()
    >;
typedef $$PensionEntriesTableCreateCompanionBuilder =
    PensionEntriesCompanion Function({
      Value<int> fiscalYear,
      Value<double> factorA,
      Value<int> unusedPriorYearsSpace,
      Value<int> plannedContribution,
      Value<bool> aovInsured,
      Value<int> monthlyAovPremium,
      Value<String?> notes,
    });
typedef $$PensionEntriesTableUpdateCompanionBuilder =
    PensionEntriesCompanion Function({
      Value<int> fiscalYear,
      Value<double> factorA,
      Value<int> unusedPriorYearsSpace,
      Value<int> plannedContribution,
      Value<bool> aovInsured,
      Value<int> monthlyAovPremium,
      Value<String?> notes,
    });

class $$PensionEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $PensionEntriesTable> {
  $$PensionEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get factorA => $composableBuilder(
    column: $table.factorA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unusedPriorYearsSpace => $composableBuilder(
    column: $table.unusedPriorYearsSpace,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedContribution => $composableBuilder(
    column: $table.plannedContribution,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aovInsured => $composableBuilder(
    column: $table.aovInsured,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monthlyAovPremium => $composableBuilder(
    column: $table.monthlyAovPremium,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PensionEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PensionEntriesTable> {
  $$PensionEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get factorA => $composableBuilder(
    column: $table.factorA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unusedPriorYearsSpace => $composableBuilder(
    column: $table.unusedPriorYearsSpace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedContribution => $composableBuilder(
    column: $table.plannedContribution,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aovInsured => $composableBuilder(
    column: $table.aovInsured,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthlyAovPremium => $composableBuilder(
    column: $table.monthlyAovPremium,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PensionEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PensionEntriesTable> {
  $$PensionEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get fiscalYear => $composableBuilder(
    column: $table.fiscalYear,
    builder: (column) => column,
  );

  GeneratedColumn<double> get factorA =>
      $composableBuilder(column: $table.factorA, builder: (column) => column);

  GeneratedColumn<int> get unusedPriorYearsSpace => $composableBuilder(
    column: $table.unusedPriorYearsSpace,
    builder: (column) => column,
  );

  GeneratedColumn<int> get plannedContribution => $composableBuilder(
    column: $table.plannedContribution,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get aovInsured => $composableBuilder(
    column: $table.aovInsured,
    builder: (column) => column,
  );

  GeneratedColumn<int> get monthlyAovPremium => $composableBuilder(
    column: $table.monthlyAovPremium,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$PensionEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PensionEntriesTable,
          PensionEntry,
          $$PensionEntriesTableFilterComposer,
          $$PensionEntriesTableOrderingComposer,
          $$PensionEntriesTableAnnotationComposer,
          $$PensionEntriesTableCreateCompanionBuilder,
          $$PensionEntriesTableUpdateCompanionBuilder,
          (
            PensionEntry,
            BaseReferences<_$AppDatabase, $PensionEntriesTable, PensionEntry>,
          ),
          PensionEntry,
          PrefetchHooks Function()
        > {
  $$PensionEntriesTableTableManager(
    _$AppDatabase db,
    $PensionEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PensionEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PensionEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PensionEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> fiscalYear = const Value.absent(),
                Value<double> factorA = const Value.absent(),
                Value<int> unusedPriorYearsSpace = const Value.absent(),
                Value<int> plannedContribution = const Value.absent(),
                Value<bool> aovInsured = const Value.absent(),
                Value<int> monthlyAovPremium = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PensionEntriesCompanion(
                fiscalYear: fiscalYear,
                factorA: factorA,
                unusedPriorYearsSpace: unusedPriorYearsSpace,
                plannedContribution: plannedContribution,
                aovInsured: aovInsured,
                monthlyAovPremium: monthlyAovPremium,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> fiscalYear = const Value.absent(),
                Value<double> factorA = const Value.absent(),
                Value<int> unusedPriorYearsSpace = const Value.absent(),
                Value<int> plannedContribution = const Value.absent(),
                Value<bool> aovInsured = const Value.absent(),
                Value<int> monthlyAovPremium = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PensionEntriesCompanion.insert(
                fiscalYear: fiscalYear,
                factorA: factorA,
                unusedPriorYearsSpace: unusedPriorYearsSpace,
                plannedContribution: plannedContribution,
                aovInsured: aovInsured,
                monthlyAovPremium: monthlyAovPremium,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PensionEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PensionEntriesTable,
      PensionEntry,
      $$PensionEntriesTableFilterComposer,
      $$PensionEntriesTableOrderingComposer,
      $$PensionEntriesTableAnnotationComposer,
      $$PensionEntriesTableCreateCompanionBuilder,
      $$PensionEntriesTableUpdateCompanionBuilder,
      (
        PensionEntry,
        BaseReferences<_$AppDatabase, $PensionEntriesTable, PensionEntry>,
      ),
      PensionEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TaxParamsTableTableManager get taxParams =>
      $$TaxParamsTableTableManager(_db, _db.taxParams);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$InvoiceLinesTableTableManager get invoiceLines =>
      $$InvoiceLinesTableTableManager(_db, _db.invoiceLines);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$HourEntriesTableTableManager get hourEntries =>
      $$HourEntriesTableTableManager(_db, _db.hourEntries);
  $$MileageTripsTableTableManager get mileageTrips =>
      $$MileageTripsTableTableManager(_db, _db.mileageTrips);
  $$FixedAssetsTableTableManager get fixedAssets =>
      $$FixedAssetsTableTableManager(_db, _db.fixedAssets);
  $$PensionEntriesTableTableManager get pensionEntries =>
      $$PensionEntriesTableTableManager(_db, _db.pensionEntries);
}
