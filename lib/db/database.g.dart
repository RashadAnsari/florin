// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BusinessProfilesTable extends BusinessProfiles
    with TableInfo<$BusinessProfilesTable, BusinessProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BusinessProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    check: () => id.equals(1),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _vatNumberMeta = const VerificationMeta(
    'vatNumber',
  );
  @override
  late final GeneratedColumn<String> vatNumber = GeneratedColumn<String>(
    'vat_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kvkNumberMeta = const VerificationMeta(
    'kvkNumber',
  );
  @override
  late final GeneratedColumn<String> kvkNumber = GeneratedColumn<String>(
    'kvk_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ibanMeta = const VerificationMeta('iban');
  @override
  late final GeneratedColumn<String> iban = GeneratedColumn<String>(
    'iban',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isStarterMeta = const VerificationMeta(
    'isStarter',
  );
  @override
  late final GeneratedColumn<bool> isStarter = GeneratedColumn<bool>(
    'is_starter',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_starter" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _korStartMeta = const VerificationMeta(
    'korStart',
  );
  @override
  late final GeneratedColumn<DateTime> korStart = GeneratedColumn<DateTime>(
    'kor_start',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _korEndMeta = const VerificationMeta('korEnd');
  @override
  late final GeneratedColumn<DateTime> korEnd = GeneratedColumn<DateTime>(
    'kor_end',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    vatNumber,
    kvkNumber,
    address,
    iban,
    isStarter,
    korStart,
    korEnd,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'business_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<BusinessProfile> instance, {
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
    if (data.containsKey('vat_number')) {
      context.handle(
        _vatNumberMeta,
        vatNumber.isAcceptableOrUnknown(data['vat_number']!, _vatNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_vatNumberMeta);
    }
    if (data.containsKey('kvk_number')) {
      context.handle(
        _kvkNumberMeta,
        kvkNumber.isAcceptableOrUnknown(data['kvk_number']!, _kvkNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_kvkNumberMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('iban')) {
      context.handle(
        _ibanMeta,
        iban.isAcceptableOrUnknown(data['iban']!, _ibanMeta),
      );
    } else if (isInserting) {
      context.missing(_ibanMeta);
    }
    if (data.containsKey('is_starter')) {
      context.handle(
        _isStarterMeta,
        isStarter.isAcceptableOrUnknown(data['is_starter']!, _isStarterMeta),
      );
    }
    if (data.containsKey('kor_start')) {
      context.handle(
        _korStartMeta,
        korStart.isAcceptableOrUnknown(data['kor_start']!, _korStartMeta),
      );
    }
    if (data.containsKey('kor_end')) {
      context.handle(
        _korEndMeta,
        korEnd.isAcceptableOrUnknown(data['kor_end']!, _korEndMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BusinessProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BusinessProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      vatNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vat_number'],
      )!,
      kvkNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kvk_number'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      iban: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}iban'],
      )!,
      isStarter: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_starter'],
      )!,
      korStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}kor_start'],
      ),
      korEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}kor_end'],
      ),
    );
  }

  @override
  $BusinessProfilesTable createAlias(String alias) {
    return $BusinessProfilesTable(attachedDatabase, alias);
  }
}

class BusinessProfile extends DataClass implements Insertable<BusinessProfile> {
  final int id;
  final String name;
  final String vatNumber;
  final String kvkNumber;
  final String address;
  final String iban;
  final bool isStarter;

  /// The first day the kleineondernemersregeling applies, as the
  /// Belastingdienst confirmed it (Wet OB 1968 art. 25a lid 5).
  final DateTime? korStart;

  /// The first day it no longer applies after a voluntary deregistration
  /// (art. 25a lid 7). Passing the turnover limit ends it without this.
  final DateTime? korEnd;
  const BusinessProfile({
    required this.id,
    required this.name,
    required this.vatNumber,
    required this.kvkNumber,
    required this.address,
    required this.iban,
    required this.isStarter,
    this.korStart,
    this.korEnd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['vat_number'] = Variable<String>(vatNumber);
    map['kvk_number'] = Variable<String>(kvkNumber);
    map['address'] = Variable<String>(address);
    map['iban'] = Variable<String>(iban);
    map['is_starter'] = Variable<bool>(isStarter);
    if (!nullToAbsent || korStart != null) {
      map['kor_start'] = Variable<DateTime>(korStart);
    }
    if (!nullToAbsent || korEnd != null) {
      map['kor_end'] = Variable<DateTime>(korEnd);
    }
    return map;
  }

  BusinessProfilesCompanion toCompanion(bool nullToAbsent) {
    return BusinessProfilesCompanion(
      id: Value(id),
      name: Value(name),
      vatNumber: Value(vatNumber),
      kvkNumber: Value(kvkNumber),
      address: Value(address),
      iban: Value(iban),
      isStarter: Value(isStarter),
      korStart: korStart == null && nullToAbsent
          ? const Value.absent()
          : Value(korStart),
      korEnd: korEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(korEnd),
    );
  }

  factory BusinessProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BusinessProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      vatNumber: serializer.fromJson<String>(json['vatNumber']),
      kvkNumber: serializer.fromJson<String>(json['kvkNumber']),
      address: serializer.fromJson<String>(json['address']),
      iban: serializer.fromJson<String>(json['iban']),
      isStarter: serializer.fromJson<bool>(json['isStarter']),
      korStart: serializer.fromJson<DateTime?>(json['korStart']),
      korEnd: serializer.fromJson<DateTime?>(json['korEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'vatNumber': serializer.toJson<String>(vatNumber),
      'kvkNumber': serializer.toJson<String>(kvkNumber),
      'address': serializer.toJson<String>(address),
      'iban': serializer.toJson<String>(iban),
      'isStarter': serializer.toJson<bool>(isStarter),
      'korStart': serializer.toJson<DateTime?>(korStart),
      'korEnd': serializer.toJson<DateTime?>(korEnd),
    };
  }

  BusinessProfile copyWith({
    int? id,
    String? name,
    String? vatNumber,
    String? kvkNumber,
    String? address,
    String? iban,
    bool? isStarter,
    Value<DateTime?> korStart = const Value.absent(),
    Value<DateTime?> korEnd = const Value.absent(),
  }) => BusinessProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    vatNumber: vatNumber ?? this.vatNumber,
    kvkNumber: kvkNumber ?? this.kvkNumber,
    address: address ?? this.address,
    iban: iban ?? this.iban,
    isStarter: isStarter ?? this.isStarter,
    korStart: korStart.present ? korStart.value : this.korStart,
    korEnd: korEnd.present ? korEnd.value : this.korEnd,
  );
  BusinessProfile copyWithCompanion(BusinessProfilesCompanion data) {
    return BusinessProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      vatNumber: data.vatNumber.present ? data.vatNumber.value : this.vatNumber,
      kvkNumber: data.kvkNumber.present ? data.kvkNumber.value : this.kvkNumber,
      address: data.address.present ? data.address.value : this.address,
      iban: data.iban.present ? data.iban.value : this.iban,
      isStarter: data.isStarter.present ? data.isStarter.value : this.isStarter,
      korStart: data.korStart.present ? data.korStart.value : this.korStart,
      korEnd: data.korEnd.present ? data.korEnd.value : this.korEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BusinessProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('vatNumber: $vatNumber, ')
          ..write('kvkNumber: $kvkNumber, ')
          ..write('address: $address, ')
          ..write('iban: $iban, ')
          ..write('isStarter: $isStarter, ')
          ..write('korStart: $korStart, ')
          ..write('korEnd: $korEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    vatNumber,
    kvkNumber,
    address,
    iban,
    isStarter,
    korStart,
    korEnd,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BusinessProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.vatNumber == this.vatNumber &&
          other.kvkNumber == this.kvkNumber &&
          other.address == this.address &&
          other.iban == this.iban &&
          other.isStarter == this.isStarter &&
          other.korStart == this.korStart &&
          other.korEnd == this.korEnd);
}

class BusinessProfilesCompanion extends UpdateCompanion<BusinessProfile> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> vatNumber;
  final Value<String> kvkNumber;
  final Value<String> address;
  final Value<String> iban;
  final Value<bool> isStarter;
  final Value<DateTime?> korStart;
  final Value<DateTime?> korEnd;
  const BusinessProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.vatNumber = const Value.absent(),
    this.kvkNumber = const Value.absent(),
    this.address = const Value.absent(),
    this.iban = const Value.absent(),
    this.isStarter = const Value.absent(),
    this.korStart = const Value.absent(),
    this.korEnd = const Value.absent(),
  });
  BusinessProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String vatNumber,
    required String kvkNumber,
    required String address,
    required String iban,
    this.isStarter = const Value.absent(),
    this.korStart = const Value.absent(),
    this.korEnd = const Value.absent(),
  }) : name = Value(name),
       vatNumber = Value(vatNumber),
       kvkNumber = Value(kvkNumber),
       address = Value(address),
       iban = Value(iban);
  static Insertable<BusinessProfile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? vatNumber,
    Expression<String>? kvkNumber,
    Expression<String>? address,
    Expression<String>? iban,
    Expression<bool>? isStarter,
    Expression<DateTime>? korStart,
    Expression<DateTime>? korEnd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (vatNumber != null) 'vat_number': vatNumber,
      if (kvkNumber != null) 'kvk_number': kvkNumber,
      if (address != null) 'address': address,
      if (iban != null) 'iban': iban,
      if (isStarter != null) 'is_starter': isStarter,
      if (korStart != null) 'kor_start': korStart,
      if (korEnd != null) 'kor_end': korEnd,
    });
  }

  BusinessProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? vatNumber,
    Value<String>? kvkNumber,
    Value<String>? address,
    Value<String>? iban,
    Value<bool>? isStarter,
    Value<DateTime?>? korStart,
    Value<DateTime?>? korEnd,
  }) {
    return BusinessProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      vatNumber: vatNumber ?? this.vatNumber,
      kvkNumber: kvkNumber ?? this.kvkNumber,
      address: address ?? this.address,
      iban: iban ?? this.iban,
      isStarter: isStarter ?? this.isStarter,
      korStart: korStart ?? this.korStart,
      korEnd: korEnd ?? this.korEnd,
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
    if (vatNumber.present) {
      map['vat_number'] = Variable<String>(vatNumber.value);
    }
    if (kvkNumber.present) {
      map['kvk_number'] = Variable<String>(kvkNumber.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (iban.present) {
      map['iban'] = Variable<String>(iban.value);
    }
    if (isStarter.present) {
      map['is_starter'] = Variable<bool>(isStarter.value);
    }
    if (korStart.present) {
      map['kor_start'] = Variable<DateTime>(korStart.value);
    }
    if (korEnd.present) {
      map['kor_end'] = Variable<DateTime>(korEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BusinessProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('vatNumber: $vatNumber, ')
          ..write('kvkNumber: $kvkNumber, ')
          ..write('address: $address, ')
          ..write('iban: $iban, ')
          ..write('isStarter: $isStarter, ')
          ..write('korStart: $korStart, ')
          ..write('korEnd: $korEnd')
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  late final GeneratedColumnWithTypeConverter<WetDbaRisk, String> wetDbaRisk =
      GeneratedColumn<String>(
        'wet_dba_risk',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WetDbaRisk>($ClientsTable.$converterwetDbaRisk);
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
  static const VerificationMeta _isMerchantOfRecordMeta =
      const VerificationMeta('isMerchantOfRecord');
  @override
  late final GeneratedColumn<bool> isMerchantOfRecord = GeneratedColumn<bool>(
    'is_merchant_of_record',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_merchant_of_record" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    wetDbaRisk,
    contractSigned,
    contractExpiry,
    notes,
    isActive,
    isMerchantOfRecord,
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
    } else if (isInserting) {
      context.missing(_addressMeta);
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
    if (data.containsKey('is_merchant_of_record')) {
      context.handle(
        _isMerchantOfRecordMeta,
        isMerchantOfRecord.isAcceptableOrUnknown(
          data['is_merchant_of_record']!,
          _isMerchantOfRecordMeta,
        ),
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
      )!,
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
      wetDbaRisk: $ClientsTable.$converterwetDbaRisk.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}wet_dba_risk'],
        )!,
      ),
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
      isMerchantOfRecord: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_merchant_of_record'],
      )!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WetDbaRisk, String, String> $converterwetDbaRisk =
      const EnumNameConverter<WetDbaRisk>(WetDbaRisk.values);
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final String name;
  final String country;
  final String? vatNumber;
  final String? kvkNumber;
  final String address;
  final String? contactPerson;
  final String? email;
  final String? phone;
  final WetDbaRisk wetDbaRisk;
  final bool contractSigned;
  final DateTime? contractExpiry;
  final String? notes;
  final bool isActive;

  /// A reseller that sells the user's product to end customers in its own
  /// name and pays the user, such as a merchant of record or an app store.
  final bool isMerchantOfRecord;
  const Client({
    required this.id,
    required this.name,
    required this.country,
    this.vatNumber,
    this.kvkNumber,
    required this.address,
    this.contactPerson,
    this.email,
    this.phone,
    required this.wetDbaRisk,
    required this.contractSigned,
    this.contractExpiry,
    this.notes,
    required this.isActive,
    required this.isMerchantOfRecord,
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
    map['address'] = Variable<String>(address);
    if (!nullToAbsent || contactPerson != null) {
      map['contact_person'] = Variable<String>(contactPerson);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    {
      map['wet_dba_risk'] = Variable<String>(
        $ClientsTable.$converterwetDbaRisk.toSql(wetDbaRisk),
      );
    }
    map['contract_signed'] = Variable<bool>(contractSigned);
    if (!nullToAbsent || contractExpiry != null) {
      map['contract_expiry'] = Variable<DateTime>(contractExpiry);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['is_merchant_of_record'] = Variable<bool>(isMerchantOfRecord);
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
      address: Value(address),
      contactPerson: contactPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPerson),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      wetDbaRisk: Value(wetDbaRisk),
      contractSigned: Value(contractSigned),
      contractExpiry: contractExpiry == null && nullToAbsent
          ? const Value.absent()
          : Value(contractExpiry),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      isMerchantOfRecord: Value(isMerchantOfRecord),
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
      address: serializer.fromJson<String>(json['address']),
      contactPerson: serializer.fromJson<String?>(json['contactPerson']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      wetDbaRisk: $ClientsTable.$converterwetDbaRisk.fromJson(
        serializer.fromJson<String>(json['wetDbaRisk']),
      ),
      contractSigned: serializer.fromJson<bool>(json['contractSigned']),
      contractExpiry: serializer.fromJson<DateTime?>(json['contractExpiry']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isMerchantOfRecord: serializer.fromJson<bool>(json['isMerchantOfRecord']),
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
      'address': serializer.toJson<String>(address),
      'contactPerson': serializer.toJson<String?>(contactPerson),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'wetDbaRisk': serializer.toJson<String>(
        $ClientsTable.$converterwetDbaRisk.toJson(wetDbaRisk),
      ),
      'contractSigned': serializer.toJson<bool>(contractSigned),
      'contractExpiry': serializer.toJson<DateTime?>(contractExpiry),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'isMerchantOfRecord': serializer.toJson<bool>(isMerchantOfRecord),
    };
  }

  Client copyWith({
    int? id,
    String? name,
    String? country,
    Value<String?> vatNumber = const Value.absent(),
    Value<String?> kvkNumber = const Value.absent(),
    String? address,
    Value<String?> contactPerson = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    WetDbaRisk? wetDbaRisk,
    bool? contractSigned,
    Value<DateTime?> contractExpiry = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    bool? isMerchantOfRecord,
  }) => Client(
    id: id ?? this.id,
    name: name ?? this.name,
    country: country ?? this.country,
    vatNumber: vatNumber.present ? vatNumber.value : this.vatNumber,
    kvkNumber: kvkNumber.present ? kvkNumber.value : this.kvkNumber,
    address: address ?? this.address,
    contactPerson: contactPerson.present
        ? contactPerson.value
        : this.contactPerson,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    wetDbaRisk: wetDbaRisk ?? this.wetDbaRisk,
    contractSigned: contractSigned ?? this.contractSigned,
    contractExpiry: contractExpiry.present
        ? contractExpiry.value
        : this.contractExpiry,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    isMerchantOfRecord: isMerchantOfRecord ?? this.isMerchantOfRecord,
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
      wetDbaRisk: data.wetDbaRisk.present
          ? data.wetDbaRisk.value
          : this.wetDbaRisk,
      contractSigned: data.contractSigned.present
          ? data.contractSigned.value
          : this.contractSigned,
      contractExpiry: data.contractExpiry.present
          ? data.contractExpiry.value
          : this.contractExpiry,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isMerchantOfRecord: data.isMerchantOfRecord.present
          ? data.isMerchantOfRecord.value
          : this.isMerchantOfRecord,
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
          ..write('wetDbaRisk: $wetDbaRisk, ')
          ..write('contractSigned: $contractSigned, ')
          ..write('contractExpiry: $contractExpiry, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('isMerchantOfRecord: $isMerchantOfRecord')
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
    wetDbaRisk,
    contractSigned,
    contractExpiry,
    notes,
    isActive,
    isMerchantOfRecord,
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
          other.wetDbaRisk == this.wetDbaRisk &&
          other.contractSigned == this.contractSigned &&
          other.contractExpiry == this.contractExpiry &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.isMerchantOfRecord == this.isMerchantOfRecord);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> country;
  final Value<String?> vatNumber;
  final Value<String?> kvkNumber;
  final Value<String> address;
  final Value<String?> contactPerson;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<WetDbaRisk> wetDbaRisk;
  final Value<bool> contractSigned;
  final Value<DateTime?> contractExpiry;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<bool> isMerchantOfRecord;
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
    this.wetDbaRisk = const Value.absent(),
    this.contractSigned = const Value.absent(),
    this.contractExpiry = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isMerchantOfRecord = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.country = const Value.absent(),
    this.vatNumber = const Value.absent(),
    this.kvkNumber = const Value.absent(),
    required String address,
    this.contactPerson = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    required WetDbaRisk wetDbaRisk,
    this.contractSigned = const Value.absent(),
    this.contractExpiry = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isMerchantOfRecord = const Value.absent(),
  }) : name = Value(name),
       address = Value(address),
       wetDbaRisk = Value(wetDbaRisk);
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
    Expression<String>? wetDbaRisk,
    Expression<bool>? contractSigned,
    Expression<DateTime>? contractExpiry,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<bool>? isMerchantOfRecord,
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
      if (wetDbaRisk != null) 'wet_dba_risk': wetDbaRisk,
      if (contractSigned != null) 'contract_signed': contractSigned,
      if (contractExpiry != null) 'contract_expiry': contractExpiry,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (isMerchantOfRecord != null)
        'is_merchant_of_record': isMerchantOfRecord,
    });
  }

  ClientsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? country,
    Value<String?>? vatNumber,
    Value<String?>? kvkNumber,
    Value<String>? address,
    Value<String?>? contactPerson,
    Value<String?>? email,
    Value<String?>? phone,
    Value<WetDbaRisk>? wetDbaRisk,
    Value<bool>? contractSigned,
    Value<DateTime?>? contractExpiry,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<bool>? isMerchantOfRecord,
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
      wetDbaRisk: wetDbaRisk ?? this.wetDbaRisk,
      contractSigned: contractSigned ?? this.contractSigned,
      contractExpiry: contractExpiry ?? this.contractExpiry,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      isMerchantOfRecord: isMerchantOfRecord ?? this.isMerchantOfRecord,
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
    if (wetDbaRisk.present) {
      map['wet_dba_risk'] = Variable<String>(
        $ClientsTable.$converterwetDbaRisk.toSql(wetDbaRisk.value),
      );
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
    if (isMerchantOfRecord.present) {
      map['is_merchant_of_record'] = Variable<bool>(isMerchantOfRecord.value);
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
          ..write('wetDbaRisk: $wetDbaRisk, ')
          ..write('contractSigned: $contractSigned, ')
          ..write('contractExpiry: $contractExpiry, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('isMerchantOfRecord: $isMerchantOfRecord')
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
  @override
  late final GeneratedColumnWithTypeConverter<InvoiceType, String> invoiceType =
      GeneratedColumn<String>(
        'invoice_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<InvoiceType>($InvoicesTable.$converterinvoiceType);
  static const VerificationMeta _correctedInvoiceIdMeta =
      const VerificationMeta('correctedInvoiceId');
  @override
  late final GeneratedColumn<int> correctedInvoiceId = GeneratedColumn<int>(
    'corrected_invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id) ON DELETE RESTRICT',
    ),
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
      'REFERENCES clients (id) ON DELETE RESTRICT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<VatTreatment, String>
  vatTreatment = GeneratedColumn<String>(
    'vat_treatment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<VatTreatment>($InvoicesTable.$convertervatTreatment);
  static const VerificationMeta _selfBilledMeta = const VerificationMeta(
    'selfBilled',
  );
  @override
  late final GeneratedColumn<bool> selfBilled = GeneratedColumn<bool>(
    'self_billed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("self_billed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  static const VerificationMeta _sellerIbanMeta = const VerificationMeta(
    'sellerIban',
  );
  @override
  late final GeneratedColumn<String> sellerIban = GeneratedColumn<String>(
    'seller_iban',
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
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<InvoiceStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<InvoiceStatus>($InvoicesTable.$converterstatus);
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
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceNumber,
    invoiceType,
    correctedInvoiceId,
    invoiceDate,
    supplyDate,
    clientId,
    vatTreatment,
    selfBilled,
    sellerName,
    sellerVatNumber,
    sellerKvkNumber,
    sellerAddress,
    sellerIban,
    paymentTermDays,
    status,
    paidDate,
    notes,
    totalExclVat,
    totalVat,
    totalInclVat,
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
    if (data.containsKey('corrected_invoice_id')) {
      context.handle(
        _correctedInvoiceIdMeta,
        correctedInvoiceId.isAcceptableOrUnknown(
          data['corrected_invoice_id']!,
          _correctedInvoiceIdMeta,
        ),
      );
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
    if (data.containsKey('self_billed')) {
      context.handle(
        _selfBilledMeta,
        selfBilled.isAcceptableOrUnknown(data['self_billed']!, _selfBilledMeta),
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
    if (data.containsKey('seller_iban')) {
      context.handle(
        _sellerIbanMeta,
        sellerIban.isAcceptableOrUnknown(data['seller_iban']!, _sellerIbanMeta),
      );
    } else if (isInserting) {
      context.missing(_sellerIbanMeta);
    }
    if (data.containsKey('payment_term_days')) {
      context.handle(
        _paymentTermDaysMeta,
        paymentTermDays.isAcceptableOrUnknown(
          data['payment_term_days']!,
          _paymentTermDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentTermDaysMeta);
    }
    if (data.containsKey('paid_date')) {
      context.handle(
        _paidDateMeta,
        paidDate.isAcceptableOrUnknown(data['paid_date']!, _paidDateMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
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
    } else if (isInserting) {
      context.missing(_totalExclVatMeta);
    }
    if (data.containsKey('total_vat')) {
      context.handle(
        _totalVatMeta,
        totalVat.isAcceptableOrUnknown(data['total_vat']!, _totalVatMeta),
      );
    } else if (isInserting) {
      context.missing(_totalVatMeta);
    }
    if (data.containsKey('total_incl_vat')) {
      context.handle(
        _totalInclVatMeta,
        totalInclVat.isAcceptableOrUnknown(
          data['total_incl_vat']!,
          _totalInclVatMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalInclVatMeta);
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
      invoiceType: $InvoicesTable.$converterinvoiceType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}invoice_type'],
        )!,
      ),
      correctedInvoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}corrected_invoice_id'],
      ),
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
      vatTreatment: $InvoicesTable.$convertervatTreatment.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}vat_treatment'],
        )!,
      ),
      selfBilled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}self_billed'],
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
      sellerIban: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seller_iban'],
      )!,
      paymentTermDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_term_days'],
      )!,
      status: $InvoicesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      paidDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
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
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InvoiceType, String, String> $converterinvoiceType =
      const EnumNameConverter<InvoiceType>(InvoiceType.values);
  static JsonTypeConverter2<VatTreatment, String, String>
  $convertervatTreatment = const EnumNameConverter<VatTreatment>(
    VatTreatment.values,
  );
  static JsonTypeConverter2<InvoiceStatus, String, String> $converterstatus =
      const EnumNameConverter<InvoiceStatus>(InvoiceStatus.values);
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final String invoiceNumber;
  final InvoiceType invoiceType;

  /// The invoice a credit note corrects (Wet OB 1968 art. 35a lid 2 e).
  final int? correctedInvoiceId;
  final DateTime invoiceDate;
  final DateTime? supplyDate;
  final int clientId;
  final VatTreatment vatTreatment;

  /// Issued by the customer instead of the user (Wet OB 1968 art. 35 lid 2).
  /// The number is the customer's and Florin makes no PDF.
  final bool selfBilled;
  final String sellerName;
  final String sellerVatNumber;
  final String sellerKvkNumber;
  final String sellerAddress;
  final String sellerIban;
  final int paymentTermDays;
  final InvoiceStatus status;
  final DateTime? paidDate;
  final String? notes;
  final int totalExclVat;
  final int totalVat;
  final int totalInclVat;
  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.invoiceType,
    this.correctedInvoiceId,
    required this.invoiceDate,
    this.supplyDate,
    required this.clientId,
    required this.vatTreatment,
    required this.selfBilled,
    required this.sellerName,
    required this.sellerVatNumber,
    required this.sellerKvkNumber,
    required this.sellerAddress,
    required this.sellerIban,
    required this.paymentTermDays,
    required this.status,
    this.paidDate,
    this.notes,
    required this.totalExclVat,
    required this.totalVat,
    required this.totalInclVat,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    {
      map['invoice_type'] = Variable<String>(
        $InvoicesTable.$converterinvoiceType.toSql(invoiceType),
      );
    }
    if (!nullToAbsent || correctedInvoiceId != null) {
      map['corrected_invoice_id'] = Variable<int>(correctedInvoiceId);
    }
    map['invoice_date'] = Variable<DateTime>(invoiceDate);
    if (!nullToAbsent || supplyDate != null) {
      map['supply_date'] = Variable<DateTime>(supplyDate);
    }
    map['client_id'] = Variable<int>(clientId);
    {
      map['vat_treatment'] = Variable<String>(
        $InvoicesTable.$convertervatTreatment.toSql(vatTreatment),
      );
    }
    map['self_billed'] = Variable<bool>(selfBilled);
    map['seller_name'] = Variable<String>(sellerName);
    map['seller_vat_number'] = Variable<String>(sellerVatNumber);
    map['seller_kvk_number'] = Variable<String>(sellerKvkNumber);
    map['seller_address'] = Variable<String>(sellerAddress);
    map['seller_iban'] = Variable<String>(sellerIban);
    map['payment_term_days'] = Variable<int>(paymentTermDays);
    {
      map['status'] = Variable<String>(
        $InvoicesTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || paidDate != null) {
      map['paid_date'] = Variable<DateTime>(paidDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['total_excl_vat'] = Variable<int>(totalExclVat);
    map['total_vat'] = Variable<int>(totalVat);
    map['total_incl_vat'] = Variable<int>(totalInclVat);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      invoiceNumber: Value(invoiceNumber),
      invoiceType: Value(invoiceType),
      correctedInvoiceId: correctedInvoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(correctedInvoiceId),
      invoiceDate: Value(invoiceDate),
      supplyDate: supplyDate == null && nullToAbsent
          ? const Value.absent()
          : Value(supplyDate),
      clientId: Value(clientId),
      vatTreatment: Value(vatTreatment),
      selfBilled: Value(selfBilled),
      sellerName: Value(sellerName),
      sellerVatNumber: Value(sellerVatNumber),
      sellerKvkNumber: Value(sellerKvkNumber),
      sellerAddress: Value(sellerAddress),
      sellerIban: Value(sellerIban),
      paymentTermDays: Value(paymentTermDays),
      status: Value(status),
      paidDate: paidDate == null && nullToAbsent
          ? const Value.absent()
          : Value(paidDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      totalExclVat: Value(totalExclVat),
      totalVat: Value(totalVat),
      totalInclVat: Value(totalInclVat),
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
      invoiceType: $InvoicesTable.$converterinvoiceType.fromJson(
        serializer.fromJson<String>(json['invoiceType']),
      ),
      correctedInvoiceId: serializer.fromJson<int?>(json['correctedInvoiceId']),
      invoiceDate: serializer.fromJson<DateTime>(json['invoiceDate']),
      supplyDate: serializer.fromJson<DateTime?>(json['supplyDate']),
      clientId: serializer.fromJson<int>(json['clientId']),
      vatTreatment: $InvoicesTable.$convertervatTreatment.fromJson(
        serializer.fromJson<String>(json['vatTreatment']),
      ),
      selfBilled: serializer.fromJson<bool>(json['selfBilled']),
      sellerName: serializer.fromJson<String>(json['sellerName']),
      sellerVatNumber: serializer.fromJson<String>(json['sellerVatNumber']),
      sellerKvkNumber: serializer.fromJson<String>(json['sellerKvkNumber']),
      sellerAddress: serializer.fromJson<String>(json['sellerAddress']),
      sellerIban: serializer.fromJson<String>(json['sellerIban']),
      paymentTermDays: serializer.fromJson<int>(json['paymentTermDays']),
      status: $InvoicesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      paidDate: serializer.fromJson<DateTime?>(json['paidDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      totalExclVat: serializer.fromJson<int>(json['totalExclVat']),
      totalVat: serializer.fromJson<int>(json['totalVat']),
      totalInclVat: serializer.fromJson<int>(json['totalInclVat']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'invoiceType': serializer.toJson<String>(
        $InvoicesTable.$converterinvoiceType.toJson(invoiceType),
      ),
      'correctedInvoiceId': serializer.toJson<int?>(correctedInvoiceId),
      'invoiceDate': serializer.toJson<DateTime>(invoiceDate),
      'supplyDate': serializer.toJson<DateTime?>(supplyDate),
      'clientId': serializer.toJson<int>(clientId),
      'vatTreatment': serializer.toJson<String>(
        $InvoicesTable.$convertervatTreatment.toJson(vatTreatment),
      ),
      'selfBilled': serializer.toJson<bool>(selfBilled),
      'sellerName': serializer.toJson<String>(sellerName),
      'sellerVatNumber': serializer.toJson<String>(sellerVatNumber),
      'sellerKvkNumber': serializer.toJson<String>(sellerKvkNumber),
      'sellerAddress': serializer.toJson<String>(sellerAddress),
      'sellerIban': serializer.toJson<String>(sellerIban),
      'paymentTermDays': serializer.toJson<int>(paymentTermDays),
      'status': serializer.toJson<String>(
        $InvoicesTable.$converterstatus.toJson(status),
      ),
      'paidDate': serializer.toJson<DateTime?>(paidDate),
      'notes': serializer.toJson<String?>(notes),
      'totalExclVat': serializer.toJson<int>(totalExclVat),
      'totalVat': serializer.toJson<int>(totalVat),
      'totalInclVat': serializer.toJson<int>(totalInclVat),
    };
  }

  Invoice copyWith({
    int? id,
    String? invoiceNumber,
    InvoiceType? invoiceType,
    Value<int?> correctedInvoiceId = const Value.absent(),
    DateTime? invoiceDate,
    Value<DateTime?> supplyDate = const Value.absent(),
    int? clientId,
    VatTreatment? vatTreatment,
    bool? selfBilled,
    String? sellerName,
    String? sellerVatNumber,
    String? sellerKvkNumber,
    String? sellerAddress,
    String? sellerIban,
    int? paymentTermDays,
    InvoiceStatus? status,
    Value<DateTime?> paidDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? totalExclVat,
    int? totalVat,
    int? totalInclVat,
  }) => Invoice(
    id: id ?? this.id,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    invoiceType: invoiceType ?? this.invoiceType,
    correctedInvoiceId: correctedInvoiceId.present
        ? correctedInvoiceId.value
        : this.correctedInvoiceId,
    invoiceDate: invoiceDate ?? this.invoiceDate,
    supplyDate: supplyDate.present ? supplyDate.value : this.supplyDate,
    clientId: clientId ?? this.clientId,
    vatTreatment: vatTreatment ?? this.vatTreatment,
    selfBilled: selfBilled ?? this.selfBilled,
    sellerName: sellerName ?? this.sellerName,
    sellerVatNumber: sellerVatNumber ?? this.sellerVatNumber,
    sellerKvkNumber: sellerKvkNumber ?? this.sellerKvkNumber,
    sellerAddress: sellerAddress ?? this.sellerAddress,
    sellerIban: sellerIban ?? this.sellerIban,
    paymentTermDays: paymentTermDays ?? this.paymentTermDays,
    status: status ?? this.status,
    paidDate: paidDate.present ? paidDate.value : this.paidDate,
    notes: notes.present ? notes.value : this.notes,
    totalExclVat: totalExclVat ?? this.totalExclVat,
    totalVat: totalVat ?? this.totalVat,
    totalInclVat: totalInclVat ?? this.totalInclVat,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      invoiceType: data.invoiceType.present
          ? data.invoiceType.value
          : this.invoiceType,
      correctedInvoiceId: data.correctedInvoiceId.present
          ? data.correctedInvoiceId.value
          : this.correctedInvoiceId,
      invoiceDate: data.invoiceDate.present
          ? data.invoiceDate.value
          : this.invoiceDate,
      supplyDate: data.supplyDate.present
          ? data.supplyDate.value
          : this.supplyDate,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      vatTreatment: data.vatTreatment.present
          ? data.vatTreatment.value
          : this.vatTreatment,
      selfBilled: data.selfBilled.present
          ? data.selfBilled.value
          : this.selfBilled,
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
      sellerIban: data.sellerIban.present
          ? data.sellerIban.value
          : this.sellerIban,
      paymentTermDays: data.paymentTermDays.present
          ? data.paymentTermDays.value
          : this.paymentTermDays,
      status: data.status.present ? data.status.value : this.status,
      paidDate: data.paidDate.present ? data.paidDate.value : this.paidDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      totalExclVat: data.totalExclVat.present
          ? data.totalExclVat.value
          : this.totalExclVat,
      totalVat: data.totalVat.present ? data.totalVat.value : this.totalVat,
      totalInclVat: data.totalInclVat.present
          ? data.totalInclVat.value
          : this.totalInclVat,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('invoiceType: $invoiceType, ')
          ..write('correctedInvoiceId: $correctedInvoiceId, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('supplyDate: $supplyDate, ')
          ..write('clientId: $clientId, ')
          ..write('vatTreatment: $vatTreatment, ')
          ..write('selfBilled: $selfBilled, ')
          ..write('sellerName: $sellerName, ')
          ..write('sellerVatNumber: $sellerVatNumber, ')
          ..write('sellerKvkNumber: $sellerKvkNumber, ')
          ..write('sellerAddress: $sellerAddress, ')
          ..write('sellerIban: $sellerIban, ')
          ..write('paymentTermDays: $paymentTermDays, ')
          ..write('status: $status, ')
          ..write('paidDate: $paidDate, ')
          ..write('notes: $notes, ')
          ..write('totalExclVat: $totalExclVat, ')
          ..write('totalVat: $totalVat, ')
          ..write('totalInclVat: $totalInclVat')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    invoiceNumber,
    invoiceType,
    correctedInvoiceId,
    invoiceDate,
    supplyDate,
    clientId,
    vatTreatment,
    selfBilled,
    sellerName,
    sellerVatNumber,
    sellerKvkNumber,
    sellerAddress,
    sellerIban,
    paymentTermDays,
    status,
    paidDate,
    notes,
    totalExclVat,
    totalVat,
    totalInclVat,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.invoiceNumber == this.invoiceNumber &&
          other.invoiceType == this.invoiceType &&
          other.correctedInvoiceId == this.correctedInvoiceId &&
          other.invoiceDate == this.invoiceDate &&
          other.supplyDate == this.supplyDate &&
          other.clientId == this.clientId &&
          other.vatTreatment == this.vatTreatment &&
          other.selfBilled == this.selfBilled &&
          other.sellerName == this.sellerName &&
          other.sellerVatNumber == this.sellerVatNumber &&
          other.sellerKvkNumber == this.sellerKvkNumber &&
          other.sellerAddress == this.sellerAddress &&
          other.sellerIban == this.sellerIban &&
          other.paymentTermDays == this.paymentTermDays &&
          other.status == this.status &&
          other.paidDate == this.paidDate &&
          other.notes == this.notes &&
          other.totalExclVat == this.totalExclVat &&
          other.totalVat == this.totalVat &&
          other.totalInclVat == this.totalInclVat);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<String> invoiceNumber;
  final Value<InvoiceType> invoiceType;
  final Value<int?> correctedInvoiceId;
  final Value<DateTime> invoiceDate;
  final Value<DateTime?> supplyDate;
  final Value<int> clientId;
  final Value<VatTreatment> vatTreatment;
  final Value<bool> selfBilled;
  final Value<String> sellerName;
  final Value<String> sellerVatNumber;
  final Value<String> sellerKvkNumber;
  final Value<String> sellerAddress;
  final Value<String> sellerIban;
  final Value<int> paymentTermDays;
  final Value<InvoiceStatus> status;
  final Value<DateTime?> paidDate;
  final Value<String?> notes;
  final Value<int> totalExclVat;
  final Value<int> totalVat;
  final Value<int> totalInclVat;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.invoiceType = const Value.absent(),
    this.correctedInvoiceId = const Value.absent(),
    this.invoiceDate = const Value.absent(),
    this.supplyDate = const Value.absent(),
    this.clientId = const Value.absent(),
    this.vatTreatment = const Value.absent(),
    this.selfBilled = const Value.absent(),
    this.sellerName = const Value.absent(),
    this.sellerVatNumber = const Value.absent(),
    this.sellerKvkNumber = const Value.absent(),
    this.sellerAddress = const Value.absent(),
    this.sellerIban = const Value.absent(),
    this.paymentTermDays = const Value.absent(),
    this.status = const Value.absent(),
    this.paidDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.totalExclVat = const Value.absent(),
    this.totalVat = const Value.absent(),
    this.totalInclVat = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required String invoiceNumber,
    required InvoiceType invoiceType,
    this.correctedInvoiceId = const Value.absent(),
    required DateTime invoiceDate,
    this.supplyDate = const Value.absent(),
    required int clientId,
    required VatTreatment vatTreatment,
    this.selfBilled = const Value.absent(),
    required String sellerName,
    required String sellerVatNumber,
    required String sellerKvkNumber,
    required String sellerAddress,
    required String sellerIban,
    required int paymentTermDays,
    required InvoiceStatus status,
    this.paidDate = const Value.absent(),
    this.notes = const Value.absent(),
    required int totalExclVat,
    required int totalVat,
    required int totalInclVat,
  }) : invoiceNumber = Value(invoiceNumber),
       invoiceType = Value(invoiceType),
       invoiceDate = Value(invoiceDate),
       clientId = Value(clientId),
       vatTreatment = Value(vatTreatment),
       sellerName = Value(sellerName),
       sellerVatNumber = Value(sellerVatNumber),
       sellerKvkNumber = Value(sellerKvkNumber),
       sellerAddress = Value(sellerAddress),
       sellerIban = Value(sellerIban),
       paymentTermDays = Value(paymentTermDays),
       status = Value(status),
       totalExclVat = Value(totalExclVat),
       totalVat = Value(totalVat),
       totalInclVat = Value(totalInclVat);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<String>? invoiceNumber,
    Expression<String>? invoiceType,
    Expression<int>? correctedInvoiceId,
    Expression<DateTime>? invoiceDate,
    Expression<DateTime>? supplyDate,
    Expression<int>? clientId,
    Expression<String>? vatTreatment,
    Expression<bool>? selfBilled,
    Expression<String>? sellerName,
    Expression<String>? sellerVatNumber,
    Expression<String>? sellerKvkNumber,
    Expression<String>? sellerAddress,
    Expression<String>? sellerIban,
    Expression<int>? paymentTermDays,
    Expression<String>? status,
    Expression<DateTime>? paidDate,
    Expression<String>? notes,
    Expression<int>? totalExclVat,
    Expression<int>? totalVat,
    Expression<int>? totalInclVat,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (invoiceType != null) 'invoice_type': invoiceType,
      if (correctedInvoiceId != null)
        'corrected_invoice_id': correctedInvoiceId,
      if (invoiceDate != null) 'invoice_date': invoiceDate,
      if (supplyDate != null) 'supply_date': supplyDate,
      if (clientId != null) 'client_id': clientId,
      if (vatTreatment != null) 'vat_treatment': vatTreatment,
      if (selfBilled != null) 'self_billed': selfBilled,
      if (sellerName != null) 'seller_name': sellerName,
      if (sellerVatNumber != null) 'seller_vat_number': sellerVatNumber,
      if (sellerKvkNumber != null) 'seller_kvk_number': sellerKvkNumber,
      if (sellerAddress != null) 'seller_address': sellerAddress,
      if (sellerIban != null) 'seller_iban': sellerIban,
      if (paymentTermDays != null) 'payment_term_days': paymentTermDays,
      if (status != null) 'status': status,
      if (paidDate != null) 'paid_date': paidDate,
      if (notes != null) 'notes': notes,
      if (totalExclVat != null) 'total_excl_vat': totalExclVat,
      if (totalVat != null) 'total_vat': totalVat,
      if (totalInclVat != null) 'total_incl_vat': totalInclVat,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? id,
    Value<String>? invoiceNumber,
    Value<InvoiceType>? invoiceType,
    Value<int?>? correctedInvoiceId,
    Value<DateTime>? invoiceDate,
    Value<DateTime?>? supplyDate,
    Value<int>? clientId,
    Value<VatTreatment>? vatTreatment,
    Value<bool>? selfBilled,
    Value<String>? sellerName,
    Value<String>? sellerVatNumber,
    Value<String>? sellerKvkNumber,
    Value<String>? sellerAddress,
    Value<String>? sellerIban,
    Value<int>? paymentTermDays,
    Value<InvoiceStatus>? status,
    Value<DateTime?>? paidDate,
    Value<String?>? notes,
    Value<int>? totalExclVat,
    Value<int>? totalVat,
    Value<int>? totalInclVat,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceType: invoiceType ?? this.invoiceType,
      correctedInvoiceId: correctedInvoiceId ?? this.correctedInvoiceId,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      supplyDate: supplyDate ?? this.supplyDate,
      clientId: clientId ?? this.clientId,
      vatTreatment: vatTreatment ?? this.vatTreatment,
      selfBilled: selfBilled ?? this.selfBilled,
      sellerName: sellerName ?? this.sellerName,
      sellerVatNumber: sellerVatNumber ?? this.sellerVatNumber,
      sellerKvkNumber: sellerKvkNumber ?? this.sellerKvkNumber,
      sellerAddress: sellerAddress ?? this.sellerAddress,
      sellerIban: sellerIban ?? this.sellerIban,
      paymentTermDays: paymentTermDays ?? this.paymentTermDays,
      status: status ?? this.status,
      paidDate: paidDate ?? this.paidDate,
      notes: notes ?? this.notes,
      totalExclVat: totalExclVat ?? this.totalExclVat,
      totalVat: totalVat ?? this.totalVat,
      totalInclVat: totalInclVat ?? this.totalInclVat,
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
    if (invoiceType.present) {
      map['invoice_type'] = Variable<String>(
        $InvoicesTable.$converterinvoiceType.toSql(invoiceType.value),
      );
    }
    if (correctedInvoiceId.present) {
      map['corrected_invoice_id'] = Variable<int>(correctedInvoiceId.value);
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
    if (vatTreatment.present) {
      map['vat_treatment'] = Variable<String>(
        $InvoicesTable.$convertervatTreatment.toSql(vatTreatment.value),
      );
    }
    if (selfBilled.present) {
      map['self_billed'] = Variable<bool>(selfBilled.value);
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
    if (sellerIban.present) {
      map['seller_iban'] = Variable<String>(sellerIban.value);
    }
    if (paymentTermDays.present) {
      map['payment_term_days'] = Variable<int>(paymentTermDays.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $InvoicesTable.$converterstatus.toSql(status.value),
      );
    }
    if (paidDate.present) {
      map['paid_date'] = Variable<DateTime>(paidDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('invoiceType: $invoiceType, ')
          ..write('correctedInvoiceId: $correctedInvoiceId, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('supplyDate: $supplyDate, ')
          ..write('clientId: $clientId, ')
          ..write('vatTreatment: $vatTreatment, ')
          ..write('selfBilled: $selfBilled, ')
          ..write('sellerName: $sellerName, ')
          ..write('sellerVatNumber: $sellerVatNumber, ')
          ..write('sellerKvkNumber: $sellerKvkNumber, ')
          ..write('sellerAddress: $sellerAddress, ')
          ..write('sellerIban: $sellerIban, ')
          ..write('paymentTermDays: $paymentTermDays, ')
          ..write('status: $status, ')
          ..write('paidDate: $paidDate, ')
          ..write('notes: $notes, ')
          ..write('totalExclVat: $totalExclVat, ')
          ..write('totalVat: $totalVat, ')
          ..write('totalInclVat: $totalInclVat')
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
      'REFERENCES invoices (id) ON DELETE CASCADE',
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
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  @override
  late final GeneratedColumnWithTypeConverter<VatRate, String> vatRate =
      GeneratedColumn<String>(
        'vat_rate',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VatRate>($InvoiceLinesTable.$convertervatRate);
  static const VerificationMeta _vatAmountMeta = const VerificationMeta(
    'vatAmount',
  );
  @override
  late final GeneratedColumn<int> vatAmount = GeneratedColumn<int>(
    'vat_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    description,
    quantity,
    unit,
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
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
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
    if (data.containsKey('vat_amount')) {
      context.handle(
        _vatAmountMeta,
        vatAmount.isAcceptableOrUnknown(data['vat_amount']!, _vatAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_vatAmountMeta);
    }
    if (data.containsKey('line_total_excl_vat')) {
      context.handle(
        _lineTotalExclVatMeta,
        lineTotalExclVat.isAcceptableOrUnknown(
          data['line_total_excl_vat']!,
          _lineTotalExclVatMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lineTotalExclVatMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
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
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      unitPriceExclVat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_excl_vat'],
      )!,
      vatRate: $InvoiceLinesTable.$convertervatRate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}vat_rate'],
        )!,
      ),
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

  static JsonTypeConverter2<VatRate, String, String> $convertervatRate =
      const EnumNameConverter<VatRate>(VatRate.values);
}

class InvoiceLine extends DataClass implements Insertable<InvoiceLine> {
  final int id;
  final int invoiceId;
  final String description;
  final double quantity;
  final String? unit;
  final int unitPriceExclVat;
  final VatRate vatRate;
  final int vatAmount;
  final int lineTotalExclVat;
  final int sortOrder;
  const InvoiceLine({
    required this.id,
    required this.invoiceId,
    required this.description,
    required this.quantity,
    this.unit,
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
    map['quantity'] = Variable<double>(quantity);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    map['unit_price_excl_vat'] = Variable<int>(unitPriceExclVat);
    {
      map['vat_rate'] = Variable<String>(
        $InvoiceLinesTable.$convertervatRate.toSql(vatRate),
      );
    }
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
      quantity: Value(quantity),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
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
      quantity: serializer.fromJson<double>(json['quantity']),
      unit: serializer.fromJson<String?>(json['unit']),
      unitPriceExclVat: serializer.fromJson<int>(json['unitPriceExclVat']),
      vatRate: $InvoiceLinesTable.$convertervatRate.fromJson(
        serializer.fromJson<String>(json['vatRate']),
      ),
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
      'quantity': serializer.toJson<double>(quantity),
      'unit': serializer.toJson<String?>(unit),
      'unitPriceExclVat': serializer.toJson<int>(unitPriceExclVat),
      'vatRate': serializer.toJson<String>(
        $InvoiceLinesTable.$convertervatRate.toJson(vatRate),
      ),
      'vatAmount': serializer.toJson<int>(vatAmount),
      'lineTotalExclVat': serializer.toJson<int>(lineTotalExclVat),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  InvoiceLine copyWith({
    int? id,
    int? invoiceId,
    String? description,
    double? quantity,
    Value<String?> unit = const Value.absent(),
    int? unitPriceExclVat,
    VatRate? vatRate,
    int? vatAmount,
    int? lineTotalExclVat,
    int? sortOrder,
  }) => InvoiceLine(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    unit: unit.present ? unit.value : this.unit,
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
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
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
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
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
    quantity,
    unit,
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
          other.quantity == this.quantity &&
          other.unit == this.unit &&
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
  final Value<double> quantity;
  final Value<String?> unit;
  final Value<int> unitPriceExclVat;
  final Value<VatRate> vatRate;
  final Value<int> vatAmount;
  final Value<int> lineTotalExclVat;
  final Value<int> sortOrder;
  const InvoiceLinesCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
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
    required double quantity,
    this.unit = const Value.absent(),
    required int unitPriceExclVat,
    required VatRate vatRate,
    required int vatAmount,
    required int lineTotalExclVat,
    required int sortOrder,
  }) : invoiceId = Value(invoiceId),
       description = Value(description),
       quantity = Value(quantity),
       unitPriceExclVat = Value(unitPriceExclVat),
       vatRate = Value(vatRate),
       vatAmount = Value(vatAmount),
       lineTotalExclVat = Value(lineTotalExclVat),
       sortOrder = Value(sortOrder);
  static Insertable<InvoiceLine> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<String>? description,
    Expression<double>? quantity,
    Expression<String>? unit,
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
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
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
    Value<double>? quantity,
    Value<String?>? unit,
    Value<int>? unitPriceExclVat,
    Value<VatRate>? vatRate,
    Value<int>? vatAmount,
    Value<int>? lineTotalExclVat,
    Value<int>? sortOrder,
  }) {
    return InvoiceLinesCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
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
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (unitPriceExclVat.present) {
      map['unit_price_excl_vat'] = Variable<int>(unitPriceExclVat.value);
    }
    if (vatRate.present) {
      map['vat_rate'] = Variable<String>(
        $InvoiceLinesTable.$convertervatRate.toSql(vatRate.value),
      );
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
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('unitPriceExclVat: $unitPriceExclVat, ')
          ..write('vatRate: $vatRate, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('lineTotalExclVat: $lineTotalExclVat, ')
          ..write('sortOrder: $sortOrder')
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
  @override
  late final GeneratedColumnWithTypeConverter<AssetKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(AssetKind.general.name),
      ).withConverter<AssetKind>($FixedAssetsTable.$converterkind);
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
  @override
  late final GeneratedColumnWithTypeConverter<VatRate?, String> vatRate =
      GeneratedColumn<String>(
        'vat_rate',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<VatRate?>($FixedAssetsTable.$convertervatRaten);
  @override
  late final GeneratedColumnWithTypeConverter<PurchaseVat, String> purchaseVat =
      GeneratedColumn<String>(
        'purchase_vat',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(PurchaseVat.domestic.name),
      ).withConverter<PurchaseVat>($FixedAssetsTable.$converterpurchaseVat);
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
  static const VerificationMeta _residualValueMeta = const VerificationMeta(
    'residualValue',
  );
  @override
  late final GeneratedColumn<int> residualValue = GeneratedColumn<int>(
    'residual_value',
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
    requiredDuringInsert: true,
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
  static const VerificationMeta _eiaEligibleMeta = const VerificationMeta(
    'eiaEligible',
  );
  @override
  late final GeneratedColumn<bool> eiaEligible = GeneratedColumn<bool>(
    'eia_eligible',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("eia_eligible" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MiaCategory?, String>
  miaCategory = GeneratedColumn<String>(
    'mia_category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<MiaCategory?>($FixedAssetsTable.$convertermiaCategoryn);
  static const VerificationMeta _investmentDeductionReceivedMeta =
      const VerificationMeta('investmentDeductionReceived');
  @override
  late final GeneratedColumn<int> investmentDeductionReceived =
      GeneratedColumn<int>(
        'investment_deduction_received',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _reinvestmentReserveAppliedMeta =
      const VerificationMeta('reinvestmentReserveApplied');
  @override
  late final GeneratedColumn<int> reinvestmentReserveApplied =
      GeneratedColumn<int>(
        'reinvestment_reserve_applied',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _reserveGainMeta = const VerificationMeta(
    'reserveGain',
  );
  @override
  late final GeneratedColumn<bool> reserveGain = GeneratedColumn<bool>(
    'reserve_gain',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reserve_gain" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _catalogueValueMeta = const VerificationMeta(
    'catalogueValue',
  );
  @override
  late final GeneratedColumn<int> catalogueValue = GeneratedColumn<int>(
    'catalogue_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstRegistrationMeta = const VerificationMeta(
    'firstRegistration',
  );
  @override
  late final GeneratedColumn<DateTime> firstRegistration =
      GeneratedColumn<DateTime>(
        'first_registration',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<ZeroEmission, String>
  zeroEmission = GeneratedColumn<String>(
    'zero_emission',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(ZeroEmission.none.name),
  ).withConverter<ZeroEmission>($FixedAssetsTable.$converterzeroEmission);
  static const VerificationMeta _marketValueMeta = const VerificationMeta(
    'marketValue',
  );
  @override
  late final GeneratedColumn<int> marketValue = GeneratedColumn<int>(
    'market_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keepsTripLogMeta = const VerificationMeta(
    'keepsTripLog',
  );
  @override
  late final GeneratedColumn<bool> keepsTripLog = GeneratedColumn<bool>(
    'keeps_trip_log',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("keeps_trip_log" IN (0, 1))',
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
  static const VerificationMeta _disposalInvoiceIdMeta = const VerificationMeta(
    'disposalInvoiceId',
  );
  @override
  late final GeneratedColumn<int> disposalInvoiceId = GeneratedColumn<int>(
    'disposal_invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id) ON DELETE RESTRICT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<VatRate?, String>
  disposalVatRate = GeneratedColumn<String>(
    'disposal_vat_rate',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<VatRate?>($FixedAssetsTable.$converterdisposalVatRaten);
  static const VerificationMeta _disposalVatAmountMeta = const VerificationMeta(
    'disposalVatAmount',
  );
  @override
  late final GeneratedColumn<int> disposalVatAmount = GeneratedColumn<int>(
    'disposal_vat_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kind,
    assetName,
    costExclVat,
    vatRate,
    purchaseVat,
    vatAmount,
    vatReclaimable,
    vatToReclaim,
    residualValue,
    purchaseDate,
    businessUsePct,
    usefulLifeYears,
    kiaEligible,
    eiaEligible,
    miaCategory,
    investmentDeductionReceived,
    reinvestmentReserveApplied,
    reserveGain,
    catalogueValue,
    firstRegistration,
    zeroEmission,
    marketValue,
    keepsTripLog,
    notes,
    disposalDate,
    disposalProceeds,
    disposalInvoiceId,
    disposalVatRate,
    disposalVatAmount,
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
    if (data.containsKey('vat_amount')) {
      context.handle(
        _vatAmountMeta,
        vatAmount.isAcceptableOrUnknown(data['vat_amount']!, _vatAmountMeta),
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
    if (data.containsKey('residual_value')) {
      context.handle(
        _residualValueMeta,
        residualValue.isAcceptableOrUnknown(
          data['residual_value']!,
          _residualValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_residualValueMeta);
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
    } else if (isInserting) {
      context.missing(_businessUsePctMeta);
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
    if (data.containsKey('eia_eligible')) {
      context.handle(
        _eiaEligibleMeta,
        eiaEligible.isAcceptableOrUnknown(
          data['eia_eligible']!,
          _eiaEligibleMeta,
        ),
      );
    }
    if (data.containsKey('investment_deduction_received')) {
      context.handle(
        _investmentDeductionReceivedMeta,
        investmentDeductionReceived.isAcceptableOrUnknown(
          data['investment_deduction_received']!,
          _investmentDeductionReceivedMeta,
        ),
      );
    }
    if (data.containsKey('reinvestment_reserve_applied')) {
      context.handle(
        _reinvestmentReserveAppliedMeta,
        reinvestmentReserveApplied.isAcceptableOrUnknown(
          data['reinvestment_reserve_applied']!,
          _reinvestmentReserveAppliedMeta,
        ),
      );
    }
    if (data.containsKey('reserve_gain')) {
      context.handle(
        _reserveGainMeta,
        reserveGain.isAcceptableOrUnknown(
          data['reserve_gain']!,
          _reserveGainMeta,
        ),
      );
    }
    if (data.containsKey('catalogue_value')) {
      context.handle(
        _catalogueValueMeta,
        catalogueValue.isAcceptableOrUnknown(
          data['catalogue_value']!,
          _catalogueValueMeta,
        ),
      );
    }
    if (data.containsKey('first_registration')) {
      context.handle(
        _firstRegistrationMeta,
        firstRegistration.isAcceptableOrUnknown(
          data['first_registration']!,
          _firstRegistrationMeta,
        ),
      );
    }
    if (data.containsKey('market_value')) {
      context.handle(
        _marketValueMeta,
        marketValue.isAcceptableOrUnknown(
          data['market_value']!,
          _marketValueMeta,
        ),
      );
    }
    if (data.containsKey('keeps_trip_log')) {
      context.handle(
        _keepsTripLogMeta,
        keepsTripLog.isAcceptableOrUnknown(
          data['keeps_trip_log']!,
          _keepsTripLogMeta,
        ),
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
    if (data.containsKey('disposal_invoice_id')) {
      context.handle(
        _disposalInvoiceIdMeta,
        disposalInvoiceId.isAcceptableOrUnknown(
          data['disposal_invoice_id']!,
          _disposalInvoiceIdMeta,
        ),
      );
    }
    if (data.containsKey('disposal_vat_amount')) {
      context.handle(
        _disposalVatAmountMeta,
        disposalVatAmount.isAcceptableOrUnknown(
          data['disposal_vat_amount']!,
          _disposalVatAmountMeta,
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
      kind: $FixedAssetsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      assetName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_name'],
      )!,
      costExclVat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_excl_vat'],
      )!,
      vatRate: $FixedAssetsTable.$convertervatRaten.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}vat_rate'],
        ),
      ),
      purchaseVat: $FixedAssetsTable.$converterpurchaseVat.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}purchase_vat'],
        )!,
      ),
      vatAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vat_amount'],
      )!,
      vatReclaimable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}vat_reclaimable'],
      )!,
      vatToReclaim: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vat_to_reclaim'],
      )!,
      residualValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}residual_value'],
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
      eiaEligible: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}eia_eligible'],
      )!,
      miaCategory: $FixedAssetsTable.$convertermiaCategoryn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}mia_category'],
        ),
      ),
      investmentDeductionReceived: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}investment_deduction_received'],
      ),
      reinvestmentReserveApplied: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reinvestment_reserve_applied'],
      )!,
      reserveGain: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reserve_gain'],
      )!,
      catalogueValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}catalogue_value'],
      ),
      firstRegistration: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}first_registration'],
      ),
      zeroEmission: $FixedAssetsTable.$converterzeroEmission.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}zero_emission'],
        )!,
      ),
      marketValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}market_value'],
      ),
      keepsTripLog: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}keeps_trip_log'],
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
      disposalInvoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disposal_invoice_id'],
      ),
      disposalVatRate: $FixedAssetsTable.$converterdisposalVatRaten.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}disposal_vat_rate'],
        ),
      ),
      disposalVatAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disposal_vat_amount'],
      ),
    );
  }

  @override
  $FixedAssetsTable createAlias(String alias) {
    return $FixedAssetsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AssetKind, String, String> $converterkind =
      const EnumNameConverter<AssetKind>(AssetKind.values);
  static JsonTypeConverter2<VatRate, String, String> $convertervatRate =
      const EnumNameConverter<VatRate>(VatRate.values);
  static JsonTypeConverter2<VatRate?, String?, String?> $convertervatRaten =
      JsonTypeConverter2.asNullable($convertervatRate);
  static JsonTypeConverter2<PurchaseVat, String, String> $converterpurchaseVat =
      const EnumNameConverter<PurchaseVat>(PurchaseVat.values);
  static JsonTypeConverter2<MiaCategory, String, String> $convertermiaCategory =
      const EnumNameConverter<MiaCategory>(MiaCategory.values);
  static JsonTypeConverter2<MiaCategory?, String?, String?>
  $convertermiaCategoryn = JsonTypeConverter2.asNullable($convertermiaCategory);
  static JsonTypeConverter2<ZeroEmission, String, String>
  $converterzeroEmission = const EnumNameConverter<ZeroEmission>(
    ZeroEmission.values,
  );
  static JsonTypeConverter2<VatRate, String, String> $converterdisposalVatRate =
      const EnumNameConverter<VatRate>(VatRate.values);
  static JsonTypeConverter2<VatRate?, String?, String?>
  $converterdisposalVatRaten = JsonTypeConverter2.asNullable(
    $converterdisposalVatRate,
  );
}

class FixedAsset extends DataClass implements Insertable<FixedAsset> {
  final int id;
  final AssetKind kind;
  final String assetName;
  final int costExclVat;
  final VatRate? vatRate;
  final PurchaseVat purchaseVat;
  final int vatAmount;
  final bool vatReclaimable;
  final int vatToReclaim;

  /// Depreciation stops at this value.
  final int residualValue;
  final DateTime purchaseDate;
  final double businessUsePct;
  final int usefulLifeYears;
  final bool kiaEligible;
  final bool eiaEligible;
  final MiaCategory? miaCategory;

  /// Investeringsaftrek received, for a purchase year Florin has no rules
  /// for; used for the desinvesteringsbijtelling.
  final int? investmentDeductionReceived;

  /// Herinvesteringsreserve booked off on this asset's cost.
  final int reinvestmentReserveApplied;

  /// The gain on sale goes to the herinvesteringsreserve.
  final bool reserveGain;
  final int? catalogueValue;
  final DateTime? firstRegistration;
  final ZeroEmission zeroEmission;
  final int? marketValue;
  final bool keepsTripLog;
  final String? notes;
  final DateTime? disposalDate;
  final int? disposalProceeds;

  /// The issued invoice for the sale, which then carries its BTW.
  final int? disposalInvoiceId;

  /// BTW on a sale or withdrawal without an invoice in Florin, over the
  /// business share of the proceeds.
  final VatRate? disposalVatRate;
  final int? disposalVatAmount;
  const FixedAsset({
    required this.id,
    required this.kind,
    required this.assetName,
    required this.costExclVat,
    this.vatRate,
    required this.purchaseVat,
    required this.vatAmount,
    required this.vatReclaimable,
    required this.vatToReclaim,
    required this.residualValue,
    required this.purchaseDate,
    required this.businessUsePct,
    required this.usefulLifeYears,
    required this.kiaEligible,
    required this.eiaEligible,
    this.miaCategory,
    this.investmentDeductionReceived,
    required this.reinvestmentReserveApplied,
    required this.reserveGain,
    this.catalogueValue,
    this.firstRegistration,
    required this.zeroEmission,
    this.marketValue,
    required this.keepsTripLog,
    this.notes,
    this.disposalDate,
    this.disposalProceeds,
    this.disposalInvoiceId,
    this.disposalVatRate,
    this.disposalVatAmount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['kind'] = Variable<String>(
        $FixedAssetsTable.$converterkind.toSql(kind),
      );
    }
    map['asset_name'] = Variable<String>(assetName);
    map['cost_excl_vat'] = Variable<int>(costExclVat);
    if (!nullToAbsent || vatRate != null) {
      map['vat_rate'] = Variable<String>(
        $FixedAssetsTable.$convertervatRaten.toSql(vatRate),
      );
    }
    {
      map['purchase_vat'] = Variable<String>(
        $FixedAssetsTable.$converterpurchaseVat.toSql(purchaseVat),
      );
    }
    map['vat_amount'] = Variable<int>(vatAmount);
    map['vat_reclaimable'] = Variable<bool>(vatReclaimable);
    map['vat_to_reclaim'] = Variable<int>(vatToReclaim);
    map['residual_value'] = Variable<int>(residualValue);
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    map['business_use_pct'] = Variable<double>(businessUsePct);
    map['useful_life_years'] = Variable<int>(usefulLifeYears);
    map['kia_eligible'] = Variable<bool>(kiaEligible);
    map['eia_eligible'] = Variable<bool>(eiaEligible);
    if (!nullToAbsent || miaCategory != null) {
      map['mia_category'] = Variable<String>(
        $FixedAssetsTable.$convertermiaCategoryn.toSql(miaCategory),
      );
    }
    if (!nullToAbsent || investmentDeductionReceived != null) {
      map['investment_deduction_received'] = Variable<int>(
        investmentDeductionReceived,
      );
    }
    map['reinvestment_reserve_applied'] = Variable<int>(
      reinvestmentReserveApplied,
    );
    map['reserve_gain'] = Variable<bool>(reserveGain);
    if (!nullToAbsent || catalogueValue != null) {
      map['catalogue_value'] = Variable<int>(catalogueValue);
    }
    if (!nullToAbsent || firstRegistration != null) {
      map['first_registration'] = Variable<DateTime>(firstRegistration);
    }
    {
      map['zero_emission'] = Variable<String>(
        $FixedAssetsTable.$converterzeroEmission.toSql(zeroEmission),
      );
    }
    if (!nullToAbsent || marketValue != null) {
      map['market_value'] = Variable<int>(marketValue);
    }
    map['keeps_trip_log'] = Variable<bool>(keepsTripLog);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || disposalDate != null) {
      map['disposal_date'] = Variable<DateTime>(disposalDate);
    }
    if (!nullToAbsent || disposalProceeds != null) {
      map['disposal_proceeds'] = Variable<int>(disposalProceeds);
    }
    if (!nullToAbsent || disposalInvoiceId != null) {
      map['disposal_invoice_id'] = Variable<int>(disposalInvoiceId);
    }
    if (!nullToAbsent || disposalVatRate != null) {
      map['disposal_vat_rate'] = Variable<String>(
        $FixedAssetsTable.$converterdisposalVatRaten.toSql(disposalVatRate),
      );
    }
    if (!nullToAbsent || disposalVatAmount != null) {
      map['disposal_vat_amount'] = Variable<int>(disposalVatAmount);
    }
    return map;
  }

  FixedAssetsCompanion toCompanion(bool nullToAbsent) {
    return FixedAssetsCompanion(
      id: Value(id),
      kind: Value(kind),
      assetName: Value(assetName),
      costExclVat: Value(costExclVat),
      vatRate: vatRate == null && nullToAbsent
          ? const Value.absent()
          : Value(vatRate),
      purchaseVat: Value(purchaseVat),
      vatAmount: Value(vatAmount),
      vatReclaimable: Value(vatReclaimable),
      vatToReclaim: Value(vatToReclaim),
      residualValue: Value(residualValue),
      purchaseDate: Value(purchaseDate),
      businessUsePct: Value(businessUsePct),
      usefulLifeYears: Value(usefulLifeYears),
      kiaEligible: Value(kiaEligible),
      eiaEligible: Value(eiaEligible),
      miaCategory: miaCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(miaCategory),
      investmentDeductionReceived:
          investmentDeductionReceived == null && nullToAbsent
          ? const Value.absent()
          : Value(investmentDeductionReceived),
      reinvestmentReserveApplied: Value(reinvestmentReserveApplied),
      reserveGain: Value(reserveGain),
      catalogueValue: catalogueValue == null && nullToAbsent
          ? const Value.absent()
          : Value(catalogueValue),
      firstRegistration: firstRegistration == null && nullToAbsent
          ? const Value.absent()
          : Value(firstRegistration),
      zeroEmission: Value(zeroEmission),
      marketValue: marketValue == null && nullToAbsent
          ? const Value.absent()
          : Value(marketValue),
      keepsTripLog: Value(keepsTripLog),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      disposalDate: disposalDate == null && nullToAbsent
          ? const Value.absent()
          : Value(disposalDate),
      disposalProceeds: disposalProceeds == null && nullToAbsent
          ? const Value.absent()
          : Value(disposalProceeds),
      disposalInvoiceId: disposalInvoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(disposalInvoiceId),
      disposalVatRate: disposalVatRate == null && nullToAbsent
          ? const Value.absent()
          : Value(disposalVatRate),
      disposalVatAmount: disposalVatAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(disposalVatAmount),
    );
  }

  factory FixedAsset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FixedAsset(
      id: serializer.fromJson<int>(json['id']),
      kind: $FixedAssetsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      assetName: serializer.fromJson<String>(json['assetName']),
      costExclVat: serializer.fromJson<int>(json['costExclVat']),
      vatRate: $FixedAssetsTable.$convertervatRaten.fromJson(
        serializer.fromJson<String?>(json['vatRate']),
      ),
      purchaseVat: $FixedAssetsTable.$converterpurchaseVat.fromJson(
        serializer.fromJson<String>(json['purchaseVat']),
      ),
      vatAmount: serializer.fromJson<int>(json['vatAmount']),
      vatReclaimable: serializer.fromJson<bool>(json['vatReclaimable']),
      vatToReclaim: serializer.fromJson<int>(json['vatToReclaim']),
      residualValue: serializer.fromJson<int>(json['residualValue']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
      businessUsePct: serializer.fromJson<double>(json['businessUsePct']),
      usefulLifeYears: serializer.fromJson<int>(json['usefulLifeYears']),
      kiaEligible: serializer.fromJson<bool>(json['kiaEligible']),
      eiaEligible: serializer.fromJson<bool>(json['eiaEligible']),
      miaCategory: $FixedAssetsTable.$convertermiaCategoryn.fromJson(
        serializer.fromJson<String?>(json['miaCategory']),
      ),
      investmentDeductionReceived: serializer.fromJson<int?>(
        json['investmentDeductionReceived'],
      ),
      reinvestmentReserveApplied: serializer.fromJson<int>(
        json['reinvestmentReserveApplied'],
      ),
      reserveGain: serializer.fromJson<bool>(json['reserveGain']),
      catalogueValue: serializer.fromJson<int?>(json['catalogueValue']),
      firstRegistration: serializer.fromJson<DateTime?>(
        json['firstRegistration'],
      ),
      zeroEmission: $FixedAssetsTable.$converterzeroEmission.fromJson(
        serializer.fromJson<String>(json['zeroEmission']),
      ),
      marketValue: serializer.fromJson<int?>(json['marketValue']),
      keepsTripLog: serializer.fromJson<bool>(json['keepsTripLog']),
      notes: serializer.fromJson<String?>(json['notes']),
      disposalDate: serializer.fromJson<DateTime?>(json['disposalDate']),
      disposalProceeds: serializer.fromJson<int?>(json['disposalProceeds']),
      disposalInvoiceId: serializer.fromJson<int?>(json['disposalInvoiceId']),
      disposalVatRate: $FixedAssetsTable.$converterdisposalVatRaten.fromJson(
        serializer.fromJson<String?>(json['disposalVatRate']),
      ),
      disposalVatAmount: serializer.fromJson<int?>(json['disposalVatAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer.toJson<String>(
        $FixedAssetsTable.$converterkind.toJson(kind),
      ),
      'assetName': serializer.toJson<String>(assetName),
      'costExclVat': serializer.toJson<int>(costExclVat),
      'vatRate': serializer.toJson<String?>(
        $FixedAssetsTable.$convertervatRaten.toJson(vatRate),
      ),
      'purchaseVat': serializer.toJson<String>(
        $FixedAssetsTable.$converterpurchaseVat.toJson(purchaseVat),
      ),
      'vatAmount': serializer.toJson<int>(vatAmount),
      'vatReclaimable': serializer.toJson<bool>(vatReclaimable),
      'vatToReclaim': serializer.toJson<int>(vatToReclaim),
      'residualValue': serializer.toJson<int>(residualValue),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
      'businessUsePct': serializer.toJson<double>(businessUsePct),
      'usefulLifeYears': serializer.toJson<int>(usefulLifeYears),
      'kiaEligible': serializer.toJson<bool>(kiaEligible),
      'eiaEligible': serializer.toJson<bool>(eiaEligible),
      'miaCategory': serializer.toJson<String?>(
        $FixedAssetsTable.$convertermiaCategoryn.toJson(miaCategory),
      ),
      'investmentDeductionReceived': serializer.toJson<int?>(
        investmentDeductionReceived,
      ),
      'reinvestmentReserveApplied': serializer.toJson<int>(
        reinvestmentReserveApplied,
      ),
      'reserveGain': serializer.toJson<bool>(reserveGain),
      'catalogueValue': serializer.toJson<int?>(catalogueValue),
      'firstRegistration': serializer.toJson<DateTime?>(firstRegistration),
      'zeroEmission': serializer.toJson<String>(
        $FixedAssetsTable.$converterzeroEmission.toJson(zeroEmission),
      ),
      'marketValue': serializer.toJson<int?>(marketValue),
      'keepsTripLog': serializer.toJson<bool>(keepsTripLog),
      'notes': serializer.toJson<String?>(notes),
      'disposalDate': serializer.toJson<DateTime?>(disposalDate),
      'disposalProceeds': serializer.toJson<int?>(disposalProceeds),
      'disposalInvoiceId': serializer.toJson<int?>(disposalInvoiceId),
      'disposalVatRate': serializer.toJson<String?>(
        $FixedAssetsTable.$converterdisposalVatRaten.toJson(disposalVatRate),
      ),
      'disposalVatAmount': serializer.toJson<int?>(disposalVatAmount),
    };
  }

  FixedAsset copyWith({
    int? id,
    AssetKind? kind,
    String? assetName,
    int? costExclVat,
    Value<VatRate?> vatRate = const Value.absent(),
    PurchaseVat? purchaseVat,
    int? vatAmount,
    bool? vatReclaimable,
    int? vatToReclaim,
    int? residualValue,
    DateTime? purchaseDate,
    double? businessUsePct,
    int? usefulLifeYears,
    bool? kiaEligible,
    bool? eiaEligible,
    Value<MiaCategory?> miaCategory = const Value.absent(),
    Value<int?> investmentDeductionReceived = const Value.absent(),
    int? reinvestmentReserveApplied,
    bool? reserveGain,
    Value<int?> catalogueValue = const Value.absent(),
    Value<DateTime?> firstRegistration = const Value.absent(),
    ZeroEmission? zeroEmission,
    Value<int?> marketValue = const Value.absent(),
    bool? keepsTripLog,
    Value<String?> notes = const Value.absent(),
    Value<DateTime?> disposalDate = const Value.absent(),
    Value<int?> disposalProceeds = const Value.absent(),
    Value<int?> disposalInvoiceId = const Value.absent(),
    Value<VatRate?> disposalVatRate = const Value.absent(),
    Value<int?> disposalVatAmount = const Value.absent(),
  }) => FixedAsset(
    id: id ?? this.id,
    kind: kind ?? this.kind,
    assetName: assetName ?? this.assetName,
    costExclVat: costExclVat ?? this.costExclVat,
    vatRate: vatRate.present ? vatRate.value : this.vatRate,
    purchaseVat: purchaseVat ?? this.purchaseVat,
    vatAmount: vatAmount ?? this.vatAmount,
    vatReclaimable: vatReclaimable ?? this.vatReclaimable,
    vatToReclaim: vatToReclaim ?? this.vatToReclaim,
    residualValue: residualValue ?? this.residualValue,
    purchaseDate: purchaseDate ?? this.purchaseDate,
    businessUsePct: businessUsePct ?? this.businessUsePct,
    usefulLifeYears: usefulLifeYears ?? this.usefulLifeYears,
    kiaEligible: kiaEligible ?? this.kiaEligible,
    eiaEligible: eiaEligible ?? this.eiaEligible,
    miaCategory: miaCategory.present ? miaCategory.value : this.miaCategory,
    investmentDeductionReceived: investmentDeductionReceived.present
        ? investmentDeductionReceived.value
        : this.investmentDeductionReceived,
    reinvestmentReserveApplied:
        reinvestmentReserveApplied ?? this.reinvestmentReserveApplied,
    reserveGain: reserveGain ?? this.reserveGain,
    catalogueValue: catalogueValue.present
        ? catalogueValue.value
        : this.catalogueValue,
    firstRegistration: firstRegistration.present
        ? firstRegistration.value
        : this.firstRegistration,
    zeroEmission: zeroEmission ?? this.zeroEmission,
    marketValue: marketValue.present ? marketValue.value : this.marketValue,
    keepsTripLog: keepsTripLog ?? this.keepsTripLog,
    notes: notes.present ? notes.value : this.notes,
    disposalDate: disposalDate.present ? disposalDate.value : this.disposalDate,
    disposalProceeds: disposalProceeds.present
        ? disposalProceeds.value
        : this.disposalProceeds,
    disposalInvoiceId: disposalInvoiceId.present
        ? disposalInvoiceId.value
        : this.disposalInvoiceId,
    disposalVatRate: disposalVatRate.present
        ? disposalVatRate.value
        : this.disposalVatRate,
    disposalVatAmount: disposalVatAmount.present
        ? disposalVatAmount.value
        : this.disposalVatAmount,
  );
  FixedAsset copyWithCompanion(FixedAssetsCompanion data) {
    return FixedAsset(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      assetName: data.assetName.present ? data.assetName.value : this.assetName,
      costExclVat: data.costExclVat.present
          ? data.costExclVat.value
          : this.costExclVat,
      vatRate: data.vatRate.present ? data.vatRate.value : this.vatRate,
      purchaseVat: data.purchaseVat.present
          ? data.purchaseVat.value
          : this.purchaseVat,
      vatAmount: data.vatAmount.present ? data.vatAmount.value : this.vatAmount,
      vatReclaimable: data.vatReclaimable.present
          ? data.vatReclaimable.value
          : this.vatReclaimable,
      vatToReclaim: data.vatToReclaim.present
          ? data.vatToReclaim.value
          : this.vatToReclaim,
      residualValue: data.residualValue.present
          ? data.residualValue.value
          : this.residualValue,
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
      eiaEligible: data.eiaEligible.present
          ? data.eiaEligible.value
          : this.eiaEligible,
      miaCategory: data.miaCategory.present
          ? data.miaCategory.value
          : this.miaCategory,
      investmentDeductionReceived: data.investmentDeductionReceived.present
          ? data.investmentDeductionReceived.value
          : this.investmentDeductionReceived,
      reinvestmentReserveApplied: data.reinvestmentReserveApplied.present
          ? data.reinvestmentReserveApplied.value
          : this.reinvestmentReserveApplied,
      reserveGain: data.reserveGain.present
          ? data.reserveGain.value
          : this.reserveGain,
      catalogueValue: data.catalogueValue.present
          ? data.catalogueValue.value
          : this.catalogueValue,
      firstRegistration: data.firstRegistration.present
          ? data.firstRegistration.value
          : this.firstRegistration,
      zeroEmission: data.zeroEmission.present
          ? data.zeroEmission.value
          : this.zeroEmission,
      marketValue: data.marketValue.present
          ? data.marketValue.value
          : this.marketValue,
      keepsTripLog: data.keepsTripLog.present
          ? data.keepsTripLog.value
          : this.keepsTripLog,
      notes: data.notes.present ? data.notes.value : this.notes,
      disposalDate: data.disposalDate.present
          ? data.disposalDate.value
          : this.disposalDate,
      disposalProceeds: data.disposalProceeds.present
          ? data.disposalProceeds.value
          : this.disposalProceeds,
      disposalInvoiceId: data.disposalInvoiceId.present
          ? data.disposalInvoiceId.value
          : this.disposalInvoiceId,
      disposalVatRate: data.disposalVatRate.present
          ? data.disposalVatRate.value
          : this.disposalVatRate,
      disposalVatAmount: data.disposalVatAmount.present
          ? data.disposalVatAmount.value
          : this.disposalVatAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FixedAsset(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('assetName: $assetName, ')
          ..write('costExclVat: $costExclVat, ')
          ..write('vatRate: $vatRate, ')
          ..write('purchaseVat: $purchaseVat, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('vatReclaimable: $vatReclaimable, ')
          ..write('vatToReclaim: $vatToReclaim, ')
          ..write('residualValue: $residualValue, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('businessUsePct: $businessUsePct, ')
          ..write('usefulLifeYears: $usefulLifeYears, ')
          ..write('kiaEligible: $kiaEligible, ')
          ..write('eiaEligible: $eiaEligible, ')
          ..write('miaCategory: $miaCategory, ')
          ..write('investmentDeductionReceived: $investmentDeductionReceived, ')
          ..write('reinvestmentReserveApplied: $reinvestmentReserveApplied, ')
          ..write('reserveGain: $reserveGain, ')
          ..write('catalogueValue: $catalogueValue, ')
          ..write('firstRegistration: $firstRegistration, ')
          ..write('zeroEmission: $zeroEmission, ')
          ..write('marketValue: $marketValue, ')
          ..write('keepsTripLog: $keepsTripLog, ')
          ..write('notes: $notes, ')
          ..write('disposalDate: $disposalDate, ')
          ..write('disposalProceeds: $disposalProceeds, ')
          ..write('disposalInvoiceId: $disposalInvoiceId, ')
          ..write('disposalVatRate: $disposalVatRate, ')
          ..write('disposalVatAmount: $disposalVatAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    kind,
    assetName,
    costExclVat,
    vatRate,
    purchaseVat,
    vatAmount,
    vatReclaimable,
    vatToReclaim,
    residualValue,
    purchaseDate,
    businessUsePct,
    usefulLifeYears,
    kiaEligible,
    eiaEligible,
    miaCategory,
    investmentDeductionReceived,
    reinvestmentReserveApplied,
    reserveGain,
    catalogueValue,
    firstRegistration,
    zeroEmission,
    marketValue,
    keepsTripLog,
    notes,
    disposalDate,
    disposalProceeds,
    disposalInvoiceId,
    disposalVatRate,
    disposalVatAmount,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FixedAsset &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.assetName == this.assetName &&
          other.costExclVat == this.costExclVat &&
          other.vatRate == this.vatRate &&
          other.purchaseVat == this.purchaseVat &&
          other.vatAmount == this.vatAmount &&
          other.vatReclaimable == this.vatReclaimable &&
          other.vatToReclaim == this.vatToReclaim &&
          other.residualValue == this.residualValue &&
          other.purchaseDate == this.purchaseDate &&
          other.businessUsePct == this.businessUsePct &&
          other.usefulLifeYears == this.usefulLifeYears &&
          other.kiaEligible == this.kiaEligible &&
          other.eiaEligible == this.eiaEligible &&
          other.miaCategory == this.miaCategory &&
          other.investmentDeductionReceived ==
              this.investmentDeductionReceived &&
          other.reinvestmentReserveApplied == this.reinvestmentReserveApplied &&
          other.reserveGain == this.reserveGain &&
          other.catalogueValue == this.catalogueValue &&
          other.firstRegistration == this.firstRegistration &&
          other.zeroEmission == this.zeroEmission &&
          other.marketValue == this.marketValue &&
          other.keepsTripLog == this.keepsTripLog &&
          other.notes == this.notes &&
          other.disposalDate == this.disposalDate &&
          other.disposalProceeds == this.disposalProceeds &&
          other.disposalInvoiceId == this.disposalInvoiceId &&
          other.disposalVatRate == this.disposalVatRate &&
          other.disposalVatAmount == this.disposalVatAmount);
}

class FixedAssetsCompanion extends UpdateCompanion<FixedAsset> {
  final Value<int> id;
  final Value<AssetKind> kind;
  final Value<String> assetName;
  final Value<int> costExclVat;
  final Value<VatRate?> vatRate;
  final Value<PurchaseVat> purchaseVat;
  final Value<int> vatAmount;
  final Value<bool> vatReclaimable;
  final Value<int> vatToReclaim;
  final Value<int> residualValue;
  final Value<DateTime> purchaseDate;
  final Value<double> businessUsePct;
  final Value<int> usefulLifeYears;
  final Value<bool> kiaEligible;
  final Value<bool> eiaEligible;
  final Value<MiaCategory?> miaCategory;
  final Value<int?> investmentDeductionReceived;
  final Value<int> reinvestmentReserveApplied;
  final Value<bool> reserveGain;
  final Value<int?> catalogueValue;
  final Value<DateTime?> firstRegistration;
  final Value<ZeroEmission> zeroEmission;
  final Value<int?> marketValue;
  final Value<bool> keepsTripLog;
  final Value<String?> notes;
  final Value<DateTime?> disposalDate;
  final Value<int?> disposalProceeds;
  final Value<int?> disposalInvoiceId;
  final Value<VatRate?> disposalVatRate;
  final Value<int?> disposalVatAmount;
  const FixedAssetsCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.assetName = const Value.absent(),
    this.costExclVat = const Value.absent(),
    this.vatRate = const Value.absent(),
    this.purchaseVat = const Value.absent(),
    this.vatAmount = const Value.absent(),
    this.vatReclaimable = const Value.absent(),
    this.vatToReclaim = const Value.absent(),
    this.residualValue = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.businessUsePct = const Value.absent(),
    this.usefulLifeYears = const Value.absent(),
    this.kiaEligible = const Value.absent(),
    this.eiaEligible = const Value.absent(),
    this.miaCategory = const Value.absent(),
    this.investmentDeductionReceived = const Value.absent(),
    this.reinvestmentReserveApplied = const Value.absent(),
    this.reserveGain = const Value.absent(),
    this.catalogueValue = const Value.absent(),
    this.firstRegistration = const Value.absent(),
    this.zeroEmission = const Value.absent(),
    this.marketValue = const Value.absent(),
    this.keepsTripLog = const Value.absent(),
    this.notes = const Value.absent(),
    this.disposalDate = const Value.absent(),
    this.disposalProceeds = const Value.absent(),
    this.disposalInvoiceId = const Value.absent(),
    this.disposalVatRate = const Value.absent(),
    this.disposalVatAmount = const Value.absent(),
  });
  FixedAssetsCompanion.insert({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    required String assetName,
    required int costExclVat,
    this.vatRate = const Value.absent(),
    this.purchaseVat = const Value.absent(),
    this.vatAmount = const Value.absent(),
    this.vatReclaimable = const Value.absent(),
    this.vatToReclaim = const Value.absent(),
    required int residualValue,
    required DateTime purchaseDate,
    required double businessUsePct,
    required int usefulLifeYears,
    this.kiaEligible = const Value.absent(),
    this.eiaEligible = const Value.absent(),
    this.miaCategory = const Value.absent(),
    this.investmentDeductionReceived = const Value.absent(),
    this.reinvestmentReserveApplied = const Value.absent(),
    this.reserveGain = const Value.absent(),
    this.catalogueValue = const Value.absent(),
    this.firstRegistration = const Value.absent(),
    this.zeroEmission = const Value.absent(),
    this.marketValue = const Value.absent(),
    this.keepsTripLog = const Value.absent(),
    this.notes = const Value.absent(),
    this.disposalDate = const Value.absent(),
    this.disposalProceeds = const Value.absent(),
    this.disposalInvoiceId = const Value.absent(),
    this.disposalVatRate = const Value.absent(),
    this.disposalVatAmount = const Value.absent(),
  }) : assetName = Value(assetName),
       costExclVat = Value(costExclVat),
       residualValue = Value(residualValue),
       purchaseDate = Value(purchaseDate),
       businessUsePct = Value(businessUsePct),
       usefulLifeYears = Value(usefulLifeYears);
  static Insertable<FixedAsset> custom({
    Expression<int>? id,
    Expression<String>? kind,
    Expression<String>? assetName,
    Expression<int>? costExclVat,
    Expression<String>? vatRate,
    Expression<String>? purchaseVat,
    Expression<int>? vatAmount,
    Expression<bool>? vatReclaimable,
    Expression<int>? vatToReclaim,
    Expression<int>? residualValue,
    Expression<DateTime>? purchaseDate,
    Expression<double>? businessUsePct,
    Expression<int>? usefulLifeYears,
    Expression<bool>? kiaEligible,
    Expression<bool>? eiaEligible,
    Expression<String>? miaCategory,
    Expression<int>? investmentDeductionReceived,
    Expression<int>? reinvestmentReserveApplied,
    Expression<bool>? reserveGain,
    Expression<int>? catalogueValue,
    Expression<DateTime>? firstRegistration,
    Expression<String>? zeroEmission,
    Expression<int>? marketValue,
    Expression<bool>? keepsTripLog,
    Expression<String>? notes,
    Expression<DateTime>? disposalDate,
    Expression<int>? disposalProceeds,
    Expression<int>? disposalInvoiceId,
    Expression<String>? disposalVatRate,
    Expression<int>? disposalVatAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (assetName != null) 'asset_name': assetName,
      if (costExclVat != null) 'cost_excl_vat': costExclVat,
      if (vatRate != null) 'vat_rate': vatRate,
      if (purchaseVat != null) 'purchase_vat': purchaseVat,
      if (vatAmount != null) 'vat_amount': vatAmount,
      if (vatReclaimable != null) 'vat_reclaimable': vatReclaimable,
      if (vatToReclaim != null) 'vat_to_reclaim': vatToReclaim,
      if (residualValue != null) 'residual_value': residualValue,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (businessUsePct != null) 'business_use_pct': businessUsePct,
      if (usefulLifeYears != null) 'useful_life_years': usefulLifeYears,
      if (kiaEligible != null) 'kia_eligible': kiaEligible,
      if (eiaEligible != null) 'eia_eligible': eiaEligible,
      if (miaCategory != null) 'mia_category': miaCategory,
      if (investmentDeductionReceived != null)
        'investment_deduction_received': investmentDeductionReceived,
      if (reinvestmentReserveApplied != null)
        'reinvestment_reserve_applied': reinvestmentReserveApplied,
      if (reserveGain != null) 'reserve_gain': reserveGain,
      if (catalogueValue != null) 'catalogue_value': catalogueValue,
      if (firstRegistration != null) 'first_registration': firstRegistration,
      if (zeroEmission != null) 'zero_emission': zeroEmission,
      if (marketValue != null) 'market_value': marketValue,
      if (keepsTripLog != null) 'keeps_trip_log': keepsTripLog,
      if (notes != null) 'notes': notes,
      if (disposalDate != null) 'disposal_date': disposalDate,
      if (disposalProceeds != null) 'disposal_proceeds': disposalProceeds,
      if (disposalInvoiceId != null) 'disposal_invoice_id': disposalInvoiceId,
      if (disposalVatRate != null) 'disposal_vat_rate': disposalVatRate,
      if (disposalVatAmount != null) 'disposal_vat_amount': disposalVatAmount,
    });
  }

  FixedAssetsCompanion copyWith({
    Value<int>? id,
    Value<AssetKind>? kind,
    Value<String>? assetName,
    Value<int>? costExclVat,
    Value<VatRate?>? vatRate,
    Value<PurchaseVat>? purchaseVat,
    Value<int>? vatAmount,
    Value<bool>? vatReclaimable,
    Value<int>? vatToReclaim,
    Value<int>? residualValue,
    Value<DateTime>? purchaseDate,
    Value<double>? businessUsePct,
    Value<int>? usefulLifeYears,
    Value<bool>? kiaEligible,
    Value<bool>? eiaEligible,
    Value<MiaCategory?>? miaCategory,
    Value<int?>? investmentDeductionReceived,
    Value<int>? reinvestmentReserveApplied,
    Value<bool>? reserveGain,
    Value<int?>? catalogueValue,
    Value<DateTime?>? firstRegistration,
    Value<ZeroEmission>? zeroEmission,
    Value<int?>? marketValue,
    Value<bool>? keepsTripLog,
    Value<String?>? notes,
    Value<DateTime?>? disposalDate,
    Value<int?>? disposalProceeds,
    Value<int?>? disposalInvoiceId,
    Value<VatRate?>? disposalVatRate,
    Value<int?>? disposalVatAmount,
  }) {
    return FixedAssetsCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      assetName: assetName ?? this.assetName,
      costExclVat: costExclVat ?? this.costExclVat,
      vatRate: vatRate ?? this.vatRate,
      purchaseVat: purchaseVat ?? this.purchaseVat,
      vatAmount: vatAmount ?? this.vatAmount,
      vatReclaimable: vatReclaimable ?? this.vatReclaimable,
      vatToReclaim: vatToReclaim ?? this.vatToReclaim,
      residualValue: residualValue ?? this.residualValue,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      businessUsePct: businessUsePct ?? this.businessUsePct,
      usefulLifeYears: usefulLifeYears ?? this.usefulLifeYears,
      kiaEligible: kiaEligible ?? this.kiaEligible,
      eiaEligible: eiaEligible ?? this.eiaEligible,
      miaCategory: miaCategory ?? this.miaCategory,
      investmentDeductionReceived:
          investmentDeductionReceived ?? this.investmentDeductionReceived,
      reinvestmentReserveApplied:
          reinvestmentReserveApplied ?? this.reinvestmentReserveApplied,
      reserveGain: reserveGain ?? this.reserveGain,
      catalogueValue: catalogueValue ?? this.catalogueValue,
      firstRegistration: firstRegistration ?? this.firstRegistration,
      zeroEmission: zeroEmission ?? this.zeroEmission,
      marketValue: marketValue ?? this.marketValue,
      keepsTripLog: keepsTripLog ?? this.keepsTripLog,
      notes: notes ?? this.notes,
      disposalDate: disposalDate ?? this.disposalDate,
      disposalProceeds: disposalProceeds ?? this.disposalProceeds,
      disposalInvoiceId: disposalInvoiceId ?? this.disposalInvoiceId,
      disposalVatRate: disposalVatRate ?? this.disposalVatRate,
      disposalVatAmount: disposalVatAmount ?? this.disposalVatAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $FixedAssetsTable.$converterkind.toSql(kind.value),
      );
    }
    if (assetName.present) {
      map['asset_name'] = Variable<String>(assetName.value);
    }
    if (costExclVat.present) {
      map['cost_excl_vat'] = Variable<int>(costExclVat.value);
    }
    if (vatRate.present) {
      map['vat_rate'] = Variable<String>(
        $FixedAssetsTable.$convertervatRaten.toSql(vatRate.value),
      );
    }
    if (purchaseVat.present) {
      map['purchase_vat'] = Variable<String>(
        $FixedAssetsTable.$converterpurchaseVat.toSql(purchaseVat.value),
      );
    }
    if (vatAmount.present) {
      map['vat_amount'] = Variable<int>(vatAmount.value);
    }
    if (vatReclaimable.present) {
      map['vat_reclaimable'] = Variable<bool>(vatReclaimable.value);
    }
    if (vatToReclaim.present) {
      map['vat_to_reclaim'] = Variable<int>(vatToReclaim.value);
    }
    if (residualValue.present) {
      map['residual_value'] = Variable<int>(residualValue.value);
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
    if (eiaEligible.present) {
      map['eia_eligible'] = Variable<bool>(eiaEligible.value);
    }
    if (miaCategory.present) {
      map['mia_category'] = Variable<String>(
        $FixedAssetsTable.$convertermiaCategoryn.toSql(miaCategory.value),
      );
    }
    if (investmentDeductionReceived.present) {
      map['investment_deduction_received'] = Variable<int>(
        investmentDeductionReceived.value,
      );
    }
    if (reinvestmentReserveApplied.present) {
      map['reinvestment_reserve_applied'] = Variable<int>(
        reinvestmentReserveApplied.value,
      );
    }
    if (reserveGain.present) {
      map['reserve_gain'] = Variable<bool>(reserveGain.value);
    }
    if (catalogueValue.present) {
      map['catalogue_value'] = Variable<int>(catalogueValue.value);
    }
    if (firstRegistration.present) {
      map['first_registration'] = Variable<DateTime>(firstRegistration.value);
    }
    if (zeroEmission.present) {
      map['zero_emission'] = Variable<String>(
        $FixedAssetsTable.$converterzeroEmission.toSql(zeroEmission.value),
      );
    }
    if (marketValue.present) {
      map['market_value'] = Variable<int>(marketValue.value);
    }
    if (keepsTripLog.present) {
      map['keeps_trip_log'] = Variable<bool>(keepsTripLog.value);
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
    if (disposalInvoiceId.present) {
      map['disposal_invoice_id'] = Variable<int>(disposalInvoiceId.value);
    }
    if (disposalVatRate.present) {
      map['disposal_vat_rate'] = Variable<String>(
        $FixedAssetsTable.$converterdisposalVatRaten.toSql(
          disposalVatRate.value,
        ),
      );
    }
    if (disposalVatAmount.present) {
      map['disposal_vat_amount'] = Variable<int>(disposalVatAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FixedAssetsCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('assetName: $assetName, ')
          ..write('costExclVat: $costExclVat, ')
          ..write('vatRate: $vatRate, ')
          ..write('purchaseVat: $purchaseVat, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('vatReclaimable: $vatReclaimable, ')
          ..write('vatToReclaim: $vatToReclaim, ')
          ..write('residualValue: $residualValue, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('businessUsePct: $businessUsePct, ')
          ..write('usefulLifeYears: $usefulLifeYears, ')
          ..write('kiaEligible: $kiaEligible, ')
          ..write('eiaEligible: $eiaEligible, ')
          ..write('miaCategory: $miaCategory, ')
          ..write('investmentDeductionReceived: $investmentDeductionReceived, ')
          ..write('reinvestmentReserveApplied: $reinvestmentReserveApplied, ')
          ..write('reserveGain: $reserveGain, ')
          ..write('catalogueValue: $catalogueValue, ')
          ..write('firstRegistration: $firstRegistration, ')
          ..write('zeroEmission: $zeroEmission, ')
          ..write('marketValue: $marketValue, ')
          ..write('keepsTripLog: $keepsTripLog, ')
          ..write('notes: $notes, ')
          ..write('disposalDate: $disposalDate, ')
          ..write('disposalProceeds: $disposalProceeds, ')
          ..write('disposalInvoiceId: $disposalInvoiceId, ')
          ..write('disposalVatRate: $disposalVatRate, ')
          ..write('disposalVatAmount: $disposalVatAmount')
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
  @override
  late final GeneratedColumnWithTypeConverter<ExpenseCategory, String>
  category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<ExpenseCategory>($ExpensesTable.$convertercategory);
  static const VerificationMeta _paperOriginalKeptMeta = const VerificationMeta(
    'paperOriginalKept',
  );
  @override
  late final GeneratedColumn<bool> paperOriginalKept = GeneratedColumn<bool>(
    'paper_original_kept',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("paper_original_kept" IN (0, 1))',
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
  @override
  late final GeneratedColumnWithTypeConverter<VatRate, String> vatRate =
      GeneratedColumn<String>(
        'vat_rate',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VatRate>($ExpensesTable.$convertervatRate);
  @override
  late final GeneratedColumnWithTypeConverter<PurchaseVat, String> purchaseVat =
      GeneratedColumn<String>(
        'purchase_vat',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(PurchaseVat.domestic.name),
      ).withConverter<PurchaseVat>($ExpensesTable.$converterpurchaseVat);
  static const VerificationMeta _vatAmountMeta = const VerificationMeta(
    'vatAmount',
  );
  @override
  late final GeneratedColumn<int> vatAmount = GeneratedColumn<int>(
    'vat_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("vat_reclaimable" IN (0, 1))',
    ),
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
    requiredDuringInsert: true,
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
  static const VerificationMeta _carAssetIdMeta = const VerificationMeta(
    'carAssetId',
  );
  @override
  late final GeneratedColumn<int> carAssetId = GeneratedColumn<int>(
    'car_asset_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fixed_assets (id) ON DELETE RESTRICT',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    supplier,
    description,
    category,
    paperOriginalKept,
    amountExclVat,
    vatRate,
    purchaseVat,
    vatAmount,
    totalInclVat,
    businessUsePct,
    deductibleAmount,
    vatReclaimable,
    vatToReclaim,
    notes,
    paidFrom,
    paymentReference,
    carAssetId,
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
    if (data.containsKey('paper_original_kept')) {
      context.handle(
        _paperOriginalKeptMeta,
        paperOriginalKept.isAcceptableOrUnknown(
          data['paper_original_kept']!,
          _paperOriginalKeptMeta,
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
    if (data.containsKey('vat_amount')) {
      context.handle(
        _vatAmountMeta,
        vatAmount.isAcceptableOrUnknown(data['vat_amount']!, _vatAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_vatAmountMeta);
    }
    if (data.containsKey('total_incl_vat')) {
      context.handle(
        _totalInclVatMeta,
        totalInclVat.isAcceptableOrUnknown(
          data['total_incl_vat']!,
          _totalInclVatMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalInclVatMeta);
    }
    if (data.containsKey('business_use_pct')) {
      context.handle(
        _businessUsePctMeta,
        businessUsePct.isAcceptableOrUnknown(
          data['business_use_pct']!,
          _businessUsePctMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_businessUsePctMeta);
    }
    if (data.containsKey('deductible_amount')) {
      context.handle(
        _deductibleAmountMeta,
        deductibleAmount.isAcceptableOrUnknown(
          data['deductible_amount']!,
          _deductibleAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deductibleAmountMeta);
    }
    if (data.containsKey('vat_reclaimable')) {
      context.handle(
        _vatReclaimableMeta,
        vatReclaimable.isAcceptableOrUnknown(
          data['vat_reclaimable']!,
          _vatReclaimableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vatReclaimableMeta);
    }
    if (data.containsKey('vat_to_reclaim')) {
      context.handle(
        _vatToReclaimMeta,
        vatToReclaim.isAcceptableOrUnknown(
          data['vat_to_reclaim']!,
          _vatToReclaimMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vatToReclaimMeta);
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
    if (data.containsKey('car_asset_id')) {
      context.handle(
        _carAssetIdMeta,
        carAssetId.isAcceptableOrUnknown(
          data['car_asset_id']!,
          _carAssetIdMeta,
        ),
      );
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
      category: $ExpensesTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        )!,
      ),
      paperOriginalKept: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}paper_original_kept'],
      )!,
      amountExclVat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_excl_vat'],
      )!,
      vatRate: $ExpensesTable.$convertervatRate.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}vat_rate'],
        )!,
      ),
      purchaseVat: $ExpensesTable.$converterpurchaseVat.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}purchase_vat'],
        )!,
      ),
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
      carAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}car_asset_id'],
      ),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ExpenseCategory, String, String>
  $convertercategory = const EnumNameConverter<ExpenseCategory>(
    ExpenseCategory.values,
  );
  static JsonTypeConverter2<VatRate, String, String> $convertervatRate =
      const EnumNameConverter<VatRate>(VatRate.values);
  static JsonTypeConverter2<PurchaseVat, String, String> $converterpurchaseVat =
      const EnumNameConverter<PurchaseVat>(PurchaseVat.values);
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final DateTime date;
  final String supplier;
  final String description;
  final ExpenseCategory category;

  /// The user keeps the paper receipt; files are in the receipts table.
  final bool paperOriginalKept;
  final int amountExclVat;
  final VatRate vatRate;
  final PurchaseVat purchaseVat;
  final int vatAmount;
  final int totalInclVat;
  final double businessUsePct;
  final int deductibleAmount;
  final bool vatReclaimable;
  final int vatToReclaim;
  final String? notes;
  final String? paidFrom;
  final String? paymentReference;

  /// The business car this cost belongs to.
  final int? carAssetId;
  const Expense({
    required this.id,
    required this.date,
    required this.supplier,
    required this.description,
    required this.category,
    required this.paperOriginalKept,
    required this.amountExclVat,
    required this.vatRate,
    required this.purchaseVat,
    required this.vatAmount,
    required this.totalInclVat,
    required this.businessUsePct,
    required this.deductibleAmount,
    required this.vatReclaimable,
    required this.vatToReclaim,
    this.notes,
    this.paidFrom,
    this.paymentReference,
    this.carAssetId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['supplier'] = Variable<String>(supplier);
    map['description'] = Variable<String>(description);
    {
      map['category'] = Variable<String>(
        $ExpensesTable.$convertercategory.toSql(category),
      );
    }
    map['paper_original_kept'] = Variable<bool>(paperOriginalKept);
    map['amount_excl_vat'] = Variable<int>(amountExclVat);
    {
      map['vat_rate'] = Variable<String>(
        $ExpensesTable.$convertervatRate.toSql(vatRate),
      );
    }
    {
      map['purchase_vat'] = Variable<String>(
        $ExpensesTable.$converterpurchaseVat.toSql(purchaseVat),
      );
    }
    map['vat_amount'] = Variable<int>(vatAmount);
    map['total_incl_vat'] = Variable<int>(totalInclVat);
    map['business_use_pct'] = Variable<double>(businessUsePct);
    map['deductible_amount'] = Variable<int>(deductibleAmount);
    map['vat_reclaimable'] = Variable<bool>(vatReclaimable);
    map['vat_to_reclaim'] = Variable<int>(vatToReclaim);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || paidFrom != null) {
      map['paid_from'] = Variable<String>(paidFrom);
    }
    if (!nullToAbsent || paymentReference != null) {
      map['payment_reference'] = Variable<String>(paymentReference);
    }
    if (!nullToAbsent || carAssetId != null) {
      map['car_asset_id'] = Variable<int>(carAssetId);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      date: Value(date),
      supplier: Value(supplier),
      description: Value(description),
      category: Value(category),
      paperOriginalKept: Value(paperOriginalKept),
      amountExclVat: Value(amountExclVat),
      vatRate: Value(vatRate),
      purchaseVat: Value(purchaseVat),
      vatAmount: Value(vatAmount),
      totalInclVat: Value(totalInclVat),
      businessUsePct: Value(businessUsePct),
      deductibleAmount: Value(deductibleAmount),
      vatReclaimable: Value(vatReclaimable),
      vatToReclaim: Value(vatToReclaim),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      paidFrom: paidFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(paidFrom),
      paymentReference: paymentReference == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentReference),
      carAssetId: carAssetId == null && nullToAbsent
          ? const Value.absent()
          : Value(carAssetId),
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
      category: $ExpensesTable.$convertercategory.fromJson(
        serializer.fromJson<String>(json['category']),
      ),
      paperOriginalKept: serializer.fromJson<bool>(json['paperOriginalKept']),
      amountExclVat: serializer.fromJson<int>(json['amountExclVat']),
      vatRate: $ExpensesTable.$convertervatRate.fromJson(
        serializer.fromJson<String>(json['vatRate']),
      ),
      purchaseVat: $ExpensesTable.$converterpurchaseVat.fromJson(
        serializer.fromJson<String>(json['purchaseVat']),
      ),
      vatAmount: serializer.fromJson<int>(json['vatAmount']),
      totalInclVat: serializer.fromJson<int>(json['totalInclVat']),
      businessUsePct: serializer.fromJson<double>(json['businessUsePct']),
      deductibleAmount: serializer.fromJson<int>(json['deductibleAmount']),
      vatReclaimable: serializer.fromJson<bool>(json['vatReclaimable']),
      vatToReclaim: serializer.fromJson<int>(json['vatToReclaim']),
      notes: serializer.fromJson<String?>(json['notes']),
      paidFrom: serializer.fromJson<String?>(json['paidFrom']),
      paymentReference: serializer.fromJson<String?>(json['paymentReference']),
      carAssetId: serializer.fromJson<int?>(json['carAssetId']),
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
      'category': serializer.toJson<String>(
        $ExpensesTable.$convertercategory.toJson(category),
      ),
      'paperOriginalKept': serializer.toJson<bool>(paperOriginalKept),
      'amountExclVat': serializer.toJson<int>(amountExclVat),
      'vatRate': serializer.toJson<String>(
        $ExpensesTable.$convertervatRate.toJson(vatRate),
      ),
      'purchaseVat': serializer.toJson<String>(
        $ExpensesTable.$converterpurchaseVat.toJson(purchaseVat),
      ),
      'vatAmount': serializer.toJson<int>(vatAmount),
      'totalInclVat': serializer.toJson<int>(totalInclVat),
      'businessUsePct': serializer.toJson<double>(businessUsePct),
      'deductibleAmount': serializer.toJson<int>(deductibleAmount),
      'vatReclaimable': serializer.toJson<bool>(vatReclaimable),
      'vatToReclaim': serializer.toJson<int>(vatToReclaim),
      'notes': serializer.toJson<String?>(notes),
      'paidFrom': serializer.toJson<String?>(paidFrom),
      'paymentReference': serializer.toJson<String?>(paymentReference),
      'carAssetId': serializer.toJson<int?>(carAssetId),
    };
  }

  Expense copyWith({
    int? id,
    DateTime? date,
    String? supplier,
    String? description,
    ExpenseCategory? category,
    bool? paperOriginalKept,
    int? amountExclVat,
    VatRate? vatRate,
    PurchaseVat? purchaseVat,
    int? vatAmount,
    int? totalInclVat,
    double? businessUsePct,
    int? deductibleAmount,
    bool? vatReclaimable,
    int? vatToReclaim,
    Value<String?> notes = const Value.absent(),
    Value<String?> paidFrom = const Value.absent(),
    Value<String?> paymentReference = const Value.absent(),
    Value<int?> carAssetId = const Value.absent(),
  }) => Expense(
    id: id ?? this.id,
    date: date ?? this.date,
    supplier: supplier ?? this.supplier,
    description: description ?? this.description,
    category: category ?? this.category,
    paperOriginalKept: paperOriginalKept ?? this.paperOriginalKept,
    amountExclVat: amountExclVat ?? this.amountExclVat,
    vatRate: vatRate ?? this.vatRate,
    purchaseVat: purchaseVat ?? this.purchaseVat,
    vatAmount: vatAmount ?? this.vatAmount,
    totalInclVat: totalInclVat ?? this.totalInclVat,
    businessUsePct: businessUsePct ?? this.businessUsePct,
    deductibleAmount: deductibleAmount ?? this.deductibleAmount,
    vatReclaimable: vatReclaimable ?? this.vatReclaimable,
    vatToReclaim: vatToReclaim ?? this.vatToReclaim,
    notes: notes.present ? notes.value : this.notes,
    paidFrom: paidFrom.present ? paidFrom.value : this.paidFrom,
    paymentReference: paymentReference.present
        ? paymentReference.value
        : this.paymentReference,
    carAssetId: carAssetId.present ? carAssetId.value : this.carAssetId,
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
      paperOriginalKept: data.paperOriginalKept.present
          ? data.paperOriginalKept.value
          : this.paperOriginalKept,
      amountExclVat: data.amountExclVat.present
          ? data.amountExclVat.value
          : this.amountExclVat,
      vatRate: data.vatRate.present ? data.vatRate.value : this.vatRate,
      purchaseVat: data.purchaseVat.present
          ? data.purchaseVat.value
          : this.purchaseVat,
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
      notes: data.notes.present ? data.notes.value : this.notes,
      paidFrom: data.paidFrom.present ? data.paidFrom.value : this.paidFrom,
      paymentReference: data.paymentReference.present
          ? data.paymentReference.value
          : this.paymentReference,
      carAssetId: data.carAssetId.present
          ? data.carAssetId.value
          : this.carAssetId,
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
          ..write('paperOriginalKept: $paperOriginalKept, ')
          ..write('amountExclVat: $amountExclVat, ')
          ..write('vatRate: $vatRate, ')
          ..write('purchaseVat: $purchaseVat, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('totalInclVat: $totalInclVat, ')
          ..write('businessUsePct: $businessUsePct, ')
          ..write('deductibleAmount: $deductibleAmount, ')
          ..write('vatReclaimable: $vatReclaimable, ')
          ..write('vatToReclaim: $vatToReclaim, ')
          ..write('notes: $notes, ')
          ..write('paidFrom: $paidFrom, ')
          ..write('paymentReference: $paymentReference, ')
          ..write('carAssetId: $carAssetId')
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
    paperOriginalKept,
    amountExclVat,
    vatRate,
    purchaseVat,
    vatAmount,
    totalInclVat,
    businessUsePct,
    deductibleAmount,
    vatReclaimable,
    vatToReclaim,
    notes,
    paidFrom,
    paymentReference,
    carAssetId,
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
          other.paperOriginalKept == this.paperOriginalKept &&
          other.amountExclVat == this.amountExclVat &&
          other.vatRate == this.vatRate &&
          other.purchaseVat == this.purchaseVat &&
          other.vatAmount == this.vatAmount &&
          other.totalInclVat == this.totalInclVat &&
          other.businessUsePct == this.businessUsePct &&
          other.deductibleAmount == this.deductibleAmount &&
          other.vatReclaimable == this.vatReclaimable &&
          other.vatToReclaim == this.vatToReclaim &&
          other.notes == this.notes &&
          other.paidFrom == this.paidFrom &&
          other.paymentReference == this.paymentReference &&
          other.carAssetId == this.carAssetId);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> supplier;
  final Value<String> description;
  final Value<ExpenseCategory> category;
  final Value<bool> paperOriginalKept;
  final Value<int> amountExclVat;
  final Value<VatRate> vatRate;
  final Value<PurchaseVat> purchaseVat;
  final Value<int> vatAmount;
  final Value<int> totalInclVat;
  final Value<double> businessUsePct;
  final Value<int> deductibleAmount;
  final Value<bool> vatReclaimable;
  final Value<int> vatToReclaim;
  final Value<String?> notes;
  final Value<String?> paidFrom;
  final Value<String?> paymentReference;
  final Value<int?> carAssetId;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.supplier = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.paperOriginalKept = const Value.absent(),
    this.amountExclVat = const Value.absent(),
    this.vatRate = const Value.absent(),
    this.purchaseVat = const Value.absent(),
    this.vatAmount = const Value.absent(),
    this.totalInclVat = const Value.absent(),
    this.businessUsePct = const Value.absent(),
    this.deductibleAmount = const Value.absent(),
    this.vatReclaimable = const Value.absent(),
    this.vatToReclaim = const Value.absent(),
    this.notes = const Value.absent(),
    this.paidFrom = const Value.absent(),
    this.paymentReference = const Value.absent(),
    this.carAssetId = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String supplier,
    required String description,
    required ExpenseCategory category,
    this.paperOriginalKept = const Value.absent(),
    required int amountExclVat,
    required VatRate vatRate,
    this.purchaseVat = const Value.absent(),
    required int vatAmount,
    required int totalInclVat,
    required double businessUsePct,
    required int deductibleAmount,
    required bool vatReclaimable,
    required int vatToReclaim,
    this.notes = const Value.absent(),
    this.paidFrom = const Value.absent(),
    this.paymentReference = const Value.absent(),
    this.carAssetId = const Value.absent(),
  }) : date = Value(date),
       supplier = Value(supplier),
       description = Value(description),
       category = Value(category),
       amountExclVat = Value(amountExclVat),
       vatRate = Value(vatRate),
       vatAmount = Value(vatAmount),
       totalInclVat = Value(totalInclVat),
       businessUsePct = Value(businessUsePct),
       deductibleAmount = Value(deductibleAmount),
       vatReclaimable = Value(vatReclaimable),
       vatToReclaim = Value(vatToReclaim);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? supplier,
    Expression<String>? description,
    Expression<String>? category,
    Expression<bool>? paperOriginalKept,
    Expression<int>? amountExclVat,
    Expression<String>? vatRate,
    Expression<String>? purchaseVat,
    Expression<int>? vatAmount,
    Expression<int>? totalInclVat,
    Expression<double>? businessUsePct,
    Expression<int>? deductibleAmount,
    Expression<bool>? vatReclaimable,
    Expression<int>? vatToReclaim,
    Expression<String>? notes,
    Expression<String>? paidFrom,
    Expression<String>? paymentReference,
    Expression<int>? carAssetId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (supplier != null) 'supplier': supplier,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (paperOriginalKept != null) 'paper_original_kept': paperOriginalKept,
      if (amountExclVat != null) 'amount_excl_vat': amountExclVat,
      if (vatRate != null) 'vat_rate': vatRate,
      if (purchaseVat != null) 'purchase_vat': purchaseVat,
      if (vatAmount != null) 'vat_amount': vatAmount,
      if (totalInclVat != null) 'total_incl_vat': totalInclVat,
      if (businessUsePct != null) 'business_use_pct': businessUsePct,
      if (deductibleAmount != null) 'deductible_amount': deductibleAmount,
      if (vatReclaimable != null) 'vat_reclaimable': vatReclaimable,
      if (vatToReclaim != null) 'vat_to_reclaim': vatToReclaim,
      if (notes != null) 'notes': notes,
      if (paidFrom != null) 'paid_from': paidFrom,
      if (paymentReference != null) 'payment_reference': paymentReference,
      if (carAssetId != null) 'car_asset_id': carAssetId,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? supplier,
    Value<String>? description,
    Value<ExpenseCategory>? category,
    Value<bool>? paperOriginalKept,
    Value<int>? amountExclVat,
    Value<VatRate>? vatRate,
    Value<PurchaseVat>? purchaseVat,
    Value<int>? vatAmount,
    Value<int>? totalInclVat,
    Value<double>? businessUsePct,
    Value<int>? deductibleAmount,
    Value<bool>? vatReclaimable,
    Value<int>? vatToReclaim,
    Value<String?>? notes,
    Value<String?>? paidFrom,
    Value<String?>? paymentReference,
    Value<int?>? carAssetId,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      supplier: supplier ?? this.supplier,
      description: description ?? this.description,
      category: category ?? this.category,
      paperOriginalKept: paperOriginalKept ?? this.paperOriginalKept,
      amountExclVat: amountExclVat ?? this.amountExclVat,
      vatRate: vatRate ?? this.vatRate,
      purchaseVat: purchaseVat ?? this.purchaseVat,
      vatAmount: vatAmount ?? this.vatAmount,
      totalInclVat: totalInclVat ?? this.totalInclVat,
      businessUsePct: businessUsePct ?? this.businessUsePct,
      deductibleAmount: deductibleAmount ?? this.deductibleAmount,
      vatReclaimable: vatReclaimable ?? this.vatReclaimable,
      vatToReclaim: vatToReclaim ?? this.vatToReclaim,
      notes: notes ?? this.notes,
      paidFrom: paidFrom ?? this.paidFrom,
      paymentReference: paymentReference ?? this.paymentReference,
      carAssetId: carAssetId ?? this.carAssetId,
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
      map['category'] = Variable<String>(
        $ExpensesTable.$convertercategory.toSql(category.value),
      );
    }
    if (paperOriginalKept.present) {
      map['paper_original_kept'] = Variable<bool>(paperOriginalKept.value);
    }
    if (amountExclVat.present) {
      map['amount_excl_vat'] = Variable<int>(amountExclVat.value);
    }
    if (vatRate.present) {
      map['vat_rate'] = Variable<String>(
        $ExpensesTable.$convertervatRate.toSql(vatRate.value),
      );
    }
    if (purchaseVat.present) {
      map['purchase_vat'] = Variable<String>(
        $ExpensesTable.$converterpurchaseVat.toSql(purchaseVat.value),
      );
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
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (paidFrom.present) {
      map['paid_from'] = Variable<String>(paidFrom.value);
    }
    if (paymentReference.present) {
      map['payment_reference'] = Variable<String>(paymentReference.value);
    }
    if (carAssetId.present) {
      map['car_asset_id'] = Variable<int>(carAssetId.value);
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
          ..write('paperOriginalKept: $paperOriginalKept, ')
          ..write('amountExclVat: $amountExclVat, ')
          ..write('vatRate: $vatRate, ')
          ..write('purchaseVat: $purchaseVat, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('totalInclVat: $totalInclVat, ')
          ..write('businessUsePct: $businessUsePct, ')
          ..write('deductibleAmount: $deductibleAmount, ')
          ..write('vatReclaimable: $vatReclaimable, ')
          ..write('vatToReclaim: $vatToReclaim, ')
          ..write('notes: $notes, ')
          ..write('paidFrom: $paidFrom, ')
          ..write('paymentReference: $paymentReference, ')
          ..write('carAssetId: $carAssetId')
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
  @override
  late final GeneratedColumnWithTypeConverter<WorkType, String> workType =
      GeneratedColumn<String>(
        'work_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WorkType>($HourEntriesTable.$converterworkType);
  static const VerificationMeta _hoursMeta = const VerificationMeta('hours');
  @override
  late final GeneratedColumn<double> hours = GeneratedColumn<double>(
    'hours',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
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
    id,
    date,
    description,
    workType,
    hours,
    clientProject,
    notes,
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
    if (data.containsKey('hours')) {
      context.handle(
        _hoursMeta,
        hours.isAcceptableOrUnknown(data['hours']!, _hoursMeta),
      );
    } else if (isInserting) {
      context.missing(_hoursMeta);
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
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
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
      workType: $HourEntriesTable.$converterworkType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}work_type'],
        )!,
      ),
      hours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hours'],
      )!,
      clientProject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_project'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $HourEntriesTable createAlias(String alias) {
    return $HourEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WorkType, String, String> $converterworkType =
      const EnumNameConverter<WorkType>(WorkType.values);
}

class HourEntry extends DataClass implements Insertable<HourEntry> {
  final int id;
  final DateTime date;
  final String description;
  final WorkType workType;
  final double hours;
  final String? clientProject;
  final String? notes;
  const HourEntry({
    required this.id,
    required this.date,
    required this.description,
    required this.workType,
    required this.hours,
    this.clientProject,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['description'] = Variable<String>(description);
    {
      map['work_type'] = Variable<String>(
        $HourEntriesTable.$converterworkType.toSql(workType),
      );
    }
    map['hours'] = Variable<double>(hours);
    if (!nullToAbsent || clientProject != null) {
      map['client_project'] = Variable<String>(clientProject);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  HourEntriesCompanion toCompanion(bool nullToAbsent) {
    return HourEntriesCompanion(
      id: Value(id),
      date: Value(date),
      description: Value(description),
      workType: Value(workType),
      hours: Value(hours),
      clientProject: clientProject == null && nullToAbsent
          ? const Value.absent()
          : Value(clientProject),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
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
      workType: $HourEntriesTable.$converterworkType.fromJson(
        serializer.fromJson<String>(json['workType']),
      ),
      hours: serializer.fromJson<double>(json['hours']),
      clientProject: serializer.fromJson<String?>(json['clientProject']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String>(description),
      'workType': serializer.toJson<String>(
        $HourEntriesTable.$converterworkType.toJson(workType),
      ),
      'hours': serializer.toJson<double>(hours),
      'clientProject': serializer.toJson<String?>(clientProject),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  HourEntry copyWith({
    int? id,
    DateTime? date,
    String? description,
    WorkType? workType,
    double? hours,
    Value<String?> clientProject = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => HourEntry(
    id: id ?? this.id,
    date: date ?? this.date,
    description: description ?? this.description,
    workType: workType ?? this.workType,
    hours: hours ?? this.hours,
    clientProject: clientProject.present
        ? clientProject.value
        : this.clientProject,
    notes: notes.present ? notes.value : this.notes,
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
      clientProject: data.clientProject.present
          ? data.clientProject.value
          : this.clientProject,
      notes: data.notes.present ? data.notes.value : this.notes,
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
          ..write('clientProject: $clientProject, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, description, workType, hours, clientProject, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HourEntry &&
          other.id == this.id &&
          other.date == this.date &&
          other.description == this.description &&
          other.workType == this.workType &&
          other.hours == this.hours &&
          other.clientProject == this.clientProject &&
          other.notes == this.notes);
}

class HourEntriesCompanion extends UpdateCompanion<HourEntry> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> description;
  final Value<WorkType> workType;
  final Value<double> hours;
  final Value<String?> clientProject;
  final Value<String?> notes;
  const HourEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.workType = const Value.absent(),
    this.hours = const Value.absent(),
    this.clientProject = const Value.absent(),
    this.notes = const Value.absent(),
  });
  HourEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String description,
    required WorkType workType,
    required double hours,
    this.clientProject = const Value.absent(),
    this.notes = const Value.absent(),
  }) : date = Value(date),
       description = Value(description),
       workType = Value(workType),
       hours = Value(hours);
  static Insertable<HourEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<String>? workType,
    Expression<double>? hours,
    Expression<String>? clientProject,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (workType != null) 'work_type': workType,
      if (hours != null) 'hours': hours,
      if (clientProject != null) 'client_project': clientProject,
      if (notes != null) 'notes': notes,
    });
  }

  HourEntriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? description,
    Value<WorkType>? workType,
    Value<double>? hours,
    Value<String?>? clientProject,
    Value<String?>? notes,
  }) {
    return HourEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      description: description ?? this.description,
      workType: workType ?? this.workType,
      hours: hours ?? this.hours,
      clientProject: clientProject ?? this.clientProject,
      notes: notes ?? this.notes,
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
      map['work_type'] = Variable<String>(
        $HourEntriesTable.$converterworkType.toSql(workType.value),
      );
    }
    if (hours.present) {
      map['hours'] = Variable<double>(hours.value);
    }
    if (clientProject.present) {
      map['client_project'] = Variable<String>(clientProject.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
          ..write('clientProject: $clientProject, ')
          ..write('notes: $notes')
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
  static const VerificationMeta _carAssetIdMeta = const VerificationMeta(
    'carAssetId',
  );
  @override
  late final GeneratedColumn<int> carAssetId = GeneratedColumn<int>(
    'car_asset_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fixed_assets (id) ON DELETE RESTRICT',
    ),
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
  @override
  late final GeneratedColumnWithTypeConverter<TripType, String> tripType =
      GeneratedColumn<String>(
        'trip_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TripType>($MileageTripsTable.$convertertripType);
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    carAssetId,
    vehicleMakeModel,
    vehicleLicensePlate,
    departureAddress,
    arrivalAddress,
    odometerStart,
    odometerEnd,
    tripType,
    purpose,
    routeDeviation,
    notes,
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
    if (data.containsKey('car_asset_id')) {
      context.handle(
        _carAssetIdMeta,
        carAssetId.isAcceptableOrUnknown(
          data['car_asset_id']!,
          _carAssetIdMeta,
        ),
      );
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
      carAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}car_asset_id'],
      ),
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
      tripType: $MileageTripsTable.$convertertripType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}trip_type'],
        )!,
      ),
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
    );
  }

  @override
  $MileageTripsTable createAlias(String alias) {
    return $MileageTripsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TripType, String, String> $convertertripType =
      const EnumNameConverter<TripType>(TripType.values);
}

class MileageTrip extends DataClass implements Insertable<MileageTrip> {
  final int id;
  final DateTime date;

  /// The business car driven, or null for a private vehicle.
  final int? carAssetId;
  final String vehicleMakeModel;
  final String vehicleLicensePlate;
  final String departureAddress;
  final String arrivalAddress;
  final int odometerStart;
  final int odometerEnd;
  final TripType tripType;
  final String purpose;
  final bool routeDeviation;
  final String? notes;
  const MileageTrip({
    required this.id,
    required this.date,
    this.carAssetId,
    required this.vehicleMakeModel,
    required this.vehicleLicensePlate,
    required this.departureAddress,
    required this.arrivalAddress,
    required this.odometerStart,
    required this.odometerEnd,
    required this.tripType,
    required this.purpose,
    required this.routeDeviation,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || carAssetId != null) {
      map['car_asset_id'] = Variable<int>(carAssetId);
    }
    map['vehicle_make_model'] = Variable<String>(vehicleMakeModel);
    map['vehicle_license_plate'] = Variable<String>(vehicleLicensePlate);
    map['departure_address'] = Variable<String>(departureAddress);
    map['arrival_address'] = Variable<String>(arrivalAddress);
    map['odometer_start'] = Variable<int>(odometerStart);
    map['odometer_end'] = Variable<int>(odometerEnd);
    {
      map['trip_type'] = Variable<String>(
        $MileageTripsTable.$convertertripType.toSql(tripType),
      );
    }
    map['purpose'] = Variable<String>(purpose);
    map['route_deviation'] = Variable<bool>(routeDeviation);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MileageTripsCompanion toCompanion(bool nullToAbsent) {
    return MileageTripsCompanion(
      id: Value(id),
      date: Value(date),
      carAssetId: carAssetId == null && nullToAbsent
          ? const Value.absent()
          : Value(carAssetId),
      vehicleMakeModel: Value(vehicleMakeModel),
      vehicleLicensePlate: Value(vehicleLicensePlate),
      departureAddress: Value(departureAddress),
      arrivalAddress: Value(arrivalAddress),
      odometerStart: Value(odometerStart),
      odometerEnd: Value(odometerEnd),
      tripType: Value(tripType),
      purpose: Value(purpose),
      routeDeviation: Value(routeDeviation),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
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
      carAssetId: serializer.fromJson<int?>(json['carAssetId']),
      vehicleMakeModel: serializer.fromJson<String>(json['vehicleMakeModel']),
      vehicleLicensePlate: serializer.fromJson<String>(
        json['vehicleLicensePlate'],
      ),
      departureAddress: serializer.fromJson<String>(json['departureAddress']),
      arrivalAddress: serializer.fromJson<String>(json['arrivalAddress']),
      odometerStart: serializer.fromJson<int>(json['odometerStart']),
      odometerEnd: serializer.fromJson<int>(json['odometerEnd']),
      tripType: $MileageTripsTable.$convertertripType.fromJson(
        serializer.fromJson<String>(json['tripType']),
      ),
      purpose: serializer.fromJson<String>(json['purpose']),
      routeDeviation: serializer.fromJson<bool>(json['routeDeviation']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'carAssetId': serializer.toJson<int?>(carAssetId),
      'vehicleMakeModel': serializer.toJson<String>(vehicleMakeModel),
      'vehicleLicensePlate': serializer.toJson<String>(vehicleLicensePlate),
      'departureAddress': serializer.toJson<String>(departureAddress),
      'arrivalAddress': serializer.toJson<String>(arrivalAddress),
      'odometerStart': serializer.toJson<int>(odometerStart),
      'odometerEnd': serializer.toJson<int>(odometerEnd),
      'tripType': serializer.toJson<String>(
        $MileageTripsTable.$convertertripType.toJson(tripType),
      ),
      'purpose': serializer.toJson<String>(purpose),
      'routeDeviation': serializer.toJson<bool>(routeDeviation),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MileageTrip copyWith({
    int? id,
    DateTime? date,
    Value<int?> carAssetId = const Value.absent(),
    String? vehicleMakeModel,
    String? vehicleLicensePlate,
    String? departureAddress,
    String? arrivalAddress,
    int? odometerStart,
    int? odometerEnd,
    TripType? tripType,
    String? purpose,
    bool? routeDeviation,
    Value<String?> notes = const Value.absent(),
  }) => MileageTrip(
    id: id ?? this.id,
    date: date ?? this.date,
    carAssetId: carAssetId.present ? carAssetId.value : this.carAssetId,
    vehicleMakeModel: vehicleMakeModel ?? this.vehicleMakeModel,
    vehicleLicensePlate: vehicleLicensePlate ?? this.vehicleLicensePlate,
    departureAddress: departureAddress ?? this.departureAddress,
    arrivalAddress: arrivalAddress ?? this.arrivalAddress,
    odometerStart: odometerStart ?? this.odometerStart,
    odometerEnd: odometerEnd ?? this.odometerEnd,
    tripType: tripType ?? this.tripType,
    purpose: purpose ?? this.purpose,
    routeDeviation: routeDeviation ?? this.routeDeviation,
    notes: notes.present ? notes.value : this.notes,
  );
  MileageTrip copyWithCompanion(MileageTripsCompanion data) {
    return MileageTrip(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      carAssetId: data.carAssetId.present
          ? data.carAssetId.value
          : this.carAssetId,
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
      tripType: data.tripType.present ? data.tripType.value : this.tripType,
      purpose: data.purpose.present ? data.purpose.value : this.purpose,
      routeDeviation: data.routeDeviation.present
          ? data.routeDeviation.value
          : this.routeDeviation,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MileageTrip(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('carAssetId: $carAssetId, ')
          ..write('vehicleMakeModel: $vehicleMakeModel, ')
          ..write('vehicleLicensePlate: $vehicleLicensePlate, ')
          ..write('departureAddress: $departureAddress, ')
          ..write('arrivalAddress: $arrivalAddress, ')
          ..write('odometerStart: $odometerStart, ')
          ..write('odometerEnd: $odometerEnd, ')
          ..write('tripType: $tripType, ')
          ..write('purpose: $purpose, ')
          ..write('routeDeviation: $routeDeviation, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    carAssetId,
    vehicleMakeModel,
    vehicleLicensePlate,
    departureAddress,
    arrivalAddress,
    odometerStart,
    odometerEnd,
    tripType,
    purpose,
    routeDeviation,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MileageTrip &&
          other.id == this.id &&
          other.date == this.date &&
          other.carAssetId == this.carAssetId &&
          other.vehicleMakeModel == this.vehicleMakeModel &&
          other.vehicleLicensePlate == this.vehicleLicensePlate &&
          other.departureAddress == this.departureAddress &&
          other.arrivalAddress == this.arrivalAddress &&
          other.odometerStart == this.odometerStart &&
          other.odometerEnd == this.odometerEnd &&
          other.tripType == this.tripType &&
          other.purpose == this.purpose &&
          other.routeDeviation == this.routeDeviation &&
          other.notes == this.notes);
}

class MileageTripsCompanion extends UpdateCompanion<MileageTrip> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int?> carAssetId;
  final Value<String> vehicleMakeModel;
  final Value<String> vehicleLicensePlate;
  final Value<String> departureAddress;
  final Value<String> arrivalAddress;
  final Value<int> odometerStart;
  final Value<int> odometerEnd;
  final Value<TripType> tripType;
  final Value<String> purpose;
  final Value<bool> routeDeviation;
  final Value<String?> notes;
  const MileageTripsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.carAssetId = const Value.absent(),
    this.vehicleMakeModel = const Value.absent(),
    this.vehicleLicensePlate = const Value.absent(),
    this.departureAddress = const Value.absent(),
    this.arrivalAddress = const Value.absent(),
    this.odometerStart = const Value.absent(),
    this.odometerEnd = const Value.absent(),
    this.tripType = const Value.absent(),
    this.purpose = const Value.absent(),
    this.routeDeviation = const Value.absent(),
    this.notes = const Value.absent(),
  });
  MileageTripsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.carAssetId = const Value.absent(),
    required String vehicleMakeModel,
    required String vehicleLicensePlate,
    required String departureAddress,
    required String arrivalAddress,
    required int odometerStart,
    required int odometerEnd,
    required TripType tripType,
    required String purpose,
    this.routeDeviation = const Value.absent(),
    this.notes = const Value.absent(),
  }) : date = Value(date),
       vehicleMakeModel = Value(vehicleMakeModel),
       vehicleLicensePlate = Value(vehicleLicensePlate),
       departureAddress = Value(departureAddress),
       arrivalAddress = Value(arrivalAddress),
       odometerStart = Value(odometerStart),
       odometerEnd = Value(odometerEnd),
       tripType = Value(tripType),
       purpose = Value(purpose);
  static Insertable<MileageTrip> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? carAssetId,
    Expression<String>? vehicleMakeModel,
    Expression<String>? vehicleLicensePlate,
    Expression<String>? departureAddress,
    Expression<String>? arrivalAddress,
    Expression<int>? odometerStart,
    Expression<int>? odometerEnd,
    Expression<String>? tripType,
    Expression<String>? purpose,
    Expression<bool>? routeDeviation,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (carAssetId != null) 'car_asset_id': carAssetId,
      if (vehicleMakeModel != null) 'vehicle_make_model': vehicleMakeModel,
      if (vehicleLicensePlate != null)
        'vehicle_license_plate': vehicleLicensePlate,
      if (departureAddress != null) 'departure_address': departureAddress,
      if (arrivalAddress != null) 'arrival_address': arrivalAddress,
      if (odometerStart != null) 'odometer_start': odometerStart,
      if (odometerEnd != null) 'odometer_end': odometerEnd,
      if (tripType != null) 'trip_type': tripType,
      if (purpose != null) 'purpose': purpose,
      if (routeDeviation != null) 'route_deviation': routeDeviation,
      if (notes != null) 'notes': notes,
    });
  }

  MileageTripsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int?>? carAssetId,
    Value<String>? vehicleMakeModel,
    Value<String>? vehicleLicensePlate,
    Value<String>? departureAddress,
    Value<String>? arrivalAddress,
    Value<int>? odometerStart,
    Value<int>? odometerEnd,
    Value<TripType>? tripType,
    Value<String>? purpose,
    Value<bool>? routeDeviation,
    Value<String?>? notes,
  }) {
    return MileageTripsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      carAssetId: carAssetId ?? this.carAssetId,
      vehicleMakeModel: vehicleMakeModel ?? this.vehicleMakeModel,
      vehicleLicensePlate: vehicleLicensePlate ?? this.vehicleLicensePlate,
      departureAddress: departureAddress ?? this.departureAddress,
      arrivalAddress: arrivalAddress ?? this.arrivalAddress,
      odometerStart: odometerStart ?? this.odometerStart,
      odometerEnd: odometerEnd ?? this.odometerEnd,
      tripType: tripType ?? this.tripType,
      purpose: purpose ?? this.purpose,
      routeDeviation: routeDeviation ?? this.routeDeviation,
      notes: notes ?? this.notes,
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
    if (carAssetId.present) {
      map['car_asset_id'] = Variable<int>(carAssetId.value);
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
    if (tripType.present) {
      map['trip_type'] = Variable<String>(
        $MileageTripsTable.$convertertripType.toSql(tripType.value),
      );
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MileageTripsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('carAssetId: $carAssetId, ')
          ..write('vehicleMakeModel: $vehicleMakeModel, ')
          ..write('vehicleLicensePlate: $vehicleLicensePlate, ')
          ..write('departureAddress: $departureAddress, ')
          ..write('arrivalAddress: $arrivalAddress, ')
          ..write('odometerStart: $odometerStart, ')
          ..write('odometerEnd: $odometerEnd, ')
          ..write('tripType: $tripType, ')
          ..write('purpose: $purpose, ')
          ..write('routeDeviation: $routeDeviation, ')
          ..write('notes: $notes')
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
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorYearIncomeMeta = const VerificationMeta(
    'priorYearIncome',
  );
  @override
  late final GeneratedColumn<int> priorYearIncome = GeneratedColumn<int>(
    'prior_year_income',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _factorAMeta = const VerificationMeta(
    'factorA',
  );
  @override
  late final GeneratedColumn<int> factorA = GeneratedColumn<int>(
    'factor_a',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reserveringsruimteMeta =
      const VerificationMeta('reserveringsruimte');
  @override
  late final GeneratedColumn<int> reserveringsruimte = GeneratedColumn<int>(
    'reserveringsruimte',
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
  @override
  List<GeneratedColumn> get $columns => [
    year,
    priorYearIncome,
    factorA,
    reserveringsruimte,
    plannedContribution,
    aovInsured,
    monthlyAovPremium,
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
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    if (data.containsKey('prior_year_income')) {
      context.handle(
        _priorYearIncomeMeta,
        priorYearIncome.isAcceptableOrUnknown(
          data['prior_year_income']!,
          _priorYearIncomeMeta,
        ),
      );
    }
    if (data.containsKey('factor_a')) {
      context.handle(
        _factorAMeta,
        factorA.isAcceptableOrUnknown(data['factor_a']!, _factorAMeta),
      );
    }
    if (data.containsKey('reserveringsruimte')) {
      context.handle(
        _reserveringsruimteMeta,
        reserveringsruimte.isAcceptableOrUnknown(
          data['reserveringsruimte']!,
          _reserveringsruimteMeta,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {year};
  @override
  PensionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PensionEntry(
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      priorYearIncome: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prior_year_income'],
      )!,
      factorA: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}factor_a'],
      )!,
      reserveringsruimte: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reserveringsruimte'],
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
    );
  }

  @override
  $PensionEntriesTable createAlias(String alias) {
    return $PensionEntriesTable(attachedDatabase, alias);
  }
}

class PensionEntry extends DataClass implements Insertable<PensionEntry> {
  final int year;

  /// Income from work in the previous year, the basis of the premiegrondslag
  /// (Wet IB 2001 art. 3.127).
  final int priorYearIncome;
  final int factorA;
  final int reserveringsruimte;
  final int plannedContribution;
  final bool aovInsured;
  final int monthlyAovPremium;
  const PensionEntry({
    required this.year,
    required this.priorYearIncome,
    required this.factorA,
    required this.reserveringsruimte,
    required this.plannedContribution,
    required this.aovInsured,
    required this.monthlyAovPremium,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['year'] = Variable<int>(year);
    map['prior_year_income'] = Variable<int>(priorYearIncome);
    map['factor_a'] = Variable<int>(factorA);
    map['reserveringsruimte'] = Variable<int>(reserveringsruimte);
    map['planned_contribution'] = Variable<int>(plannedContribution);
    map['aov_insured'] = Variable<bool>(aovInsured);
    map['monthly_aov_premium'] = Variable<int>(monthlyAovPremium);
    return map;
  }

  PensionEntriesCompanion toCompanion(bool nullToAbsent) {
    return PensionEntriesCompanion(
      year: Value(year),
      priorYearIncome: Value(priorYearIncome),
      factorA: Value(factorA),
      reserveringsruimte: Value(reserveringsruimte),
      plannedContribution: Value(plannedContribution),
      aovInsured: Value(aovInsured),
      monthlyAovPremium: Value(monthlyAovPremium),
    );
  }

  factory PensionEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PensionEntry(
      year: serializer.fromJson<int>(json['year']),
      priorYearIncome: serializer.fromJson<int>(json['priorYearIncome']),
      factorA: serializer.fromJson<int>(json['factorA']),
      reserveringsruimte: serializer.fromJson<int>(json['reserveringsruimte']),
      plannedContribution: serializer.fromJson<int>(
        json['plannedContribution'],
      ),
      aovInsured: serializer.fromJson<bool>(json['aovInsured']),
      monthlyAovPremium: serializer.fromJson<int>(json['monthlyAovPremium']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'year': serializer.toJson<int>(year),
      'priorYearIncome': serializer.toJson<int>(priorYearIncome),
      'factorA': serializer.toJson<int>(factorA),
      'reserveringsruimte': serializer.toJson<int>(reserveringsruimte),
      'plannedContribution': serializer.toJson<int>(plannedContribution),
      'aovInsured': serializer.toJson<bool>(aovInsured),
      'monthlyAovPremium': serializer.toJson<int>(monthlyAovPremium),
    };
  }

  PensionEntry copyWith({
    int? year,
    int? priorYearIncome,
    int? factorA,
    int? reserveringsruimte,
    int? plannedContribution,
    bool? aovInsured,
    int? monthlyAovPremium,
  }) => PensionEntry(
    year: year ?? this.year,
    priorYearIncome: priorYearIncome ?? this.priorYearIncome,
    factorA: factorA ?? this.factorA,
    reserveringsruimte: reserveringsruimte ?? this.reserveringsruimte,
    plannedContribution: plannedContribution ?? this.plannedContribution,
    aovInsured: aovInsured ?? this.aovInsured,
    monthlyAovPremium: monthlyAovPremium ?? this.monthlyAovPremium,
  );
  PensionEntry copyWithCompanion(PensionEntriesCompanion data) {
    return PensionEntry(
      year: data.year.present ? data.year.value : this.year,
      priorYearIncome: data.priorYearIncome.present
          ? data.priorYearIncome.value
          : this.priorYearIncome,
      factorA: data.factorA.present ? data.factorA.value : this.factorA,
      reserveringsruimte: data.reserveringsruimte.present
          ? data.reserveringsruimte.value
          : this.reserveringsruimte,
      plannedContribution: data.plannedContribution.present
          ? data.plannedContribution.value
          : this.plannedContribution,
      aovInsured: data.aovInsured.present
          ? data.aovInsured.value
          : this.aovInsured,
      monthlyAovPremium: data.monthlyAovPremium.present
          ? data.monthlyAovPremium.value
          : this.monthlyAovPremium,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PensionEntry(')
          ..write('year: $year, ')
          ..write('priorYearIncome: $priorYearIncome, ')
          ..write('factorA: $factorA, ')
          ..write('reserveringsruimte: $reserveringsruimte, ')
          ..write('plannedContribution: $plannedContribution, ')
          ..write('aovInsured: $aovInsured, ')
          ..write('monthlyAovPremium: $monthlyAovPremium')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    year,
    priorYearIncome,
    factorA,
    reserveringsruimte,
    plannedContribution,
    aovInsured,
    monthlyAovPremium,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PensionEntry &&
          other.year == this.year &&
          other.priorYearIncome == this.priorYearIncome &&
          other.factorA == this.factorA &&
          other.reserveringsruimte == this.reserveringsruimte &&
          other.plannedContribution == this.plannedContribution &&
          other.aovInsured == this.aovInsured &&
          other.monthlyAovPremium == this.monthlyAovPremium);
}

class PensionEntriesCompanion extends UpdateCompanion<PensionEntry> {
  final Value<int> year;
  final Value<int> priorYearIncome;
  final Value<int> factorA;
  final Value<int> reserveringsruimte;
  final Value<int> plannedContribution;
  final Value<bool> aovInsured;
  final Value<int> monthlyAovPremium;
  const PensionEntriesCompanion({
    this.year = const Value.absent(),
    this.priorYearIncome = const Value.absent(),
    this.factorA = const Value.absent(),
    this.reserveringsruimte = const Value.absent(),
    this.plannedContribution = const Value.absent(),
    this.aovInsured = const Value.absent(),
    this.monthlyAovPremium = const Value.absent(),
  });
  PensionEntriesCompanion.insert({
    this.year = const Value.absent(),
    this.priorYearIncome = const Value.absent(),
    this.factorA = const Value.absent(),
    this.reserveringsruimte = const Value.absent(),
    this.plannedContribution = const Value.absent(),
    this.aovInsured = const Value.absent(),
    this.monthlyAovPremium = const Value.absent(),
  });
  static Insertable<PensionEntry> custom({
    Expression<int>? year,
    Expression<int>? priorYearIncome,
    Expression<int>? factorA,
    Expression<int>? reserveringsruimte,
    Expression<int>? plannedContribution,
    Expression<bool>? aovInsured,
    Expression<int>? monthlyAovPremium,
  }) {
    return RawValuesInsertable({
      if (year != null) 'year': year,
      if (priorYearIncome != null) 'prior_year_income': priorYearIncome,
      if (factorA != null) 'factor_a': factorA,
      if (reserveringsruimte != null) 'reserveringsruimte': reserveringsruimte,
      if (plannedContribution != null)
        'planned_contribution': plannedContribution,
      if (aovInsured != null) 'aov_insured': aovInsured,
      if (monthlyAovPremium != null) 'monthly_aov_premium': monthlyAovPremium,
    });
  }

  PensionEntriesCompanion copyWith({
    Value<int>? year,
    Value<int>? priorYearIncome,
    Value<int>? factorA,
    Value<int>? reserveringsruimte,
    Value<int>? plannedContribution,
    Value<bool>? aovInsured,
    Value<int>? monthlyAovPremium,
  }) {
    return PensionEntriesCompanion(
      year: year ?? this.year,
      priorYearIncome: priorYearIncome ?? this.priorYearIncome,
      factorA: factorA ?? this.factorA,
      reserveringsruimte: reserveringsruimte ?? this.reserveringsruimte,
      plannedContribution: plannedContribution ?? this.plannedContribution,
      aovInsured: aovInsured ?? this.aovInsured,
      monthlyAovPremium: monthlyAovPremium ?? this.monthlyAovPremium,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (priorYearIncome.present) {
      map['prior_year_income'] = Variable<int>(priorYearIncome.value);
    }
    if (factorA.present) {
      map['factor_a'] = Variable<int>(factorA.value);
    }
    if (reserveringsruimte.present) {
      map['reserveringsruimte'] = Variable<int>(reserveringsruimte.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PensionEntriesCompanion(')
          ..write('year: $year, ')
          ..write('priorYearIncome: $priorYearIncome, ')
          ..write('factorA: $factorA, ')
          ..write('reserveringsruimte: $reserveringsruimte, ')
          ..write('plannedContribution: $plannedContribution, ')
          ..write('aovInsured: $aovInsured, ')
          ..write('monthlyAovPremium: $monthlyAovPremium')
          ..write(')'))
        .toString();
  }
}

class $VatReturnsTable extends VatReturns
    with TableInfo<$VatReturnsTable, VatReturn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VatReturnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quarterMeta = const VerificationMeta(
    'quarter',
  );
  @override
  late final GeneratedColumn<int> quarter = GeneratedColumn<int>(
    'quarter',
    aliasedName,
    false,
    check: () => ComparableExpr(quarter).isBetweenValues(1, 4),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filedMeta = const VerificationMeta('filed');
  @override
  late final GeneratedColumn<bool> filed = GeneratedColumn<bool>(
    'filed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("filed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _paidMeta = const VerificationMeta('paid');
  @override
  late final GeneratedColumn<bool> paid = GeneratedColumn<bool>(
    'paid',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("paid" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [year, quarter, filed, paid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vat_returns';
  @override
  VerificationContext validateIntegrity(
    Insertable<VatReturn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('quarter')) {
      context.handle(
        _quarterMeta,
        quarter.isAcceptableOrUnknown(data['quarter']!, _quarterMeta),
      );
    } else if (isInserting) {
      context.missing(_quarterMeta);
    }
    if (data.containsKey('filed')) {
      context.handle(
        _filedMeta,
        filed.isAcceptableOrUnknown(data['filed']!, _filedMeta),
      );
    }
    if (data.containsKey('paid')) {
      context.handle(
        _paidMeta,
        paid.isAcceptableOrUnknown(data['paid']!, _paidMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {year, quarter};
  @override
  VatReturn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VatReturn(
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      quarter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quarter'],
      )!,
      filed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}filed'],
      )!,
      paid: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}paid'],
      )!,
    );
  }

  @override
  $VatReturnsTable createAlias(String alias) {
    return $VatReturnsTable(attachedDatabase, alias);
  }
}

class VatReturn extends DataClass implements Insertable<VatReturn> {
  final int year;
  final int quarter;
  final bool filed;
  final bool paid;
  const VatReturn({
    required this.year,
    required this.quarter,
    required this.filed,
    required this.paid,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['year'] = Variable<int>(year);
    map['quarter'] = Variable<int>(quarter);
    map['filed'] = Variable<bool>(filed);
    map['paid'] = Variable<bool>(paid);
    return map;
  }

  VatReturnsCompanion toCompanion(bool nullToAbsent) {
    return VatReturnsCompanion(
      year: Value(year),
      quarter: Value(quarter),
      filed: Value(filed),
      paid: Value(paid),
    );
  }

  factory VatReturn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VatReturn(
      year: serializer.fromJson<int>(json['year']),
      quarter: serializer.fromJson<int>(json['quarter']),
      filed: serializer.fromJson<bool>(json['filed']),
      paid: serializer.fromJson<bool>(json['paid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'year': serializer.toJson<int>(year),
      'quarter': serializer.toJson<int>(quarter),
      'filed': serializer.toJson<bool>(filed),
      'paid': serializer.toJson<bool>(paid),
    };
  }

  VatReturn copyWith({int? year, int? quarter, bool? filed, bool? paid}) =>
      VatReturn(
        year: year ?? this.year,
        quarter: quarter ?? this.quarter,
        filed: filed ?? this.filed,
        paid: paid ?? this.paid,
      );
  VatReturn copyWithCompanion(VatReturnsCompanion data) {
    return VatReturn(
      year: data.year.present ? data.year.value : this.year,
      quarter: data.quarter.present ? data.quarter.value : this.quarter,
      filed: data.filed.present ? data.filed.value : this.filed,
      paid: data.paid.present ? data.paid.value : this.paid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VatReturn(')
          ..write('year: $year, ')
          ..write('quarter: $quarter, ')
          ..write('filed: $filed, ')
          ..write('paid: $paid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(year, quarter, filed, paid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VatReturn &&
          other.year == this.year &&
          other.quarter == this.quarter &&
          other.filed == this.filed &&
          other.paid == this.paid);
}

class VatReturnsCompanion extends UpdateCompanion<VatReturn> {
  final Value<int> year;
  final Value<int> quarter;
  final Value<bool> filed;
  final Value<bool> paid;
  final Value<int> rowid;
  const VatReturnsCompanion({
    this.year = const Value.absent(),
    this.quarter = const Value.absent(),
    this.filed = const Value.absent(),
    this.paid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VatReturnsCompanion.insert({
    required int year,
    required int quarter,
    this.filed = const Value.absent(),
    this.paid = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : year = Value(year),
       quarter = Value(quarter);
  static Insertable<VatReturn> custom({
    Expression<int>? year,
    Expression<int>? quarter,
    Expression<bool>? filed,
    Expression<bool>? paid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (year != null) 'year': year,
      if (quarter != null) 'quarter': quarter,
      if (filed != null) 'filed': filed,
      if (paid != null) 'paid': paid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VatReturnsCompanion copyWith({
    Value<int>? year,
    Value<int>? quarter,
    Value<bool>? filed,
    Value<bool>? paid,
    Value<int>? rowid,
  }) {
    return VatReturnsCompanion(
      year: year ?? this.year,
      quarter: quarter ?? this.quarter,
      filed: filed ?? this.filed,
      paid: paid ?? this.paid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (quarter.present) {
      map['quarter'] = Variable<int>(quarter.value);
    }
    if (filed.present) {
      map['filed'] = Variable<bool>(filed.value);
    }
    if (paid.present) {
      map['paid'] = Variable<bool>(paid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VatReturnsCompanion(')
          ..write('year: $year, ')
          ..write('quarter: $quarter, ')
          ..write('filed: $filed, ')
          ..write('paid: $paid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaxYearInputsTable extends TaxYearInputs
    with TableInfo<$TaxYearInputsTable, TaxYearInput> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaxYearInputsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partnerHoursMeta = const VerificationMeta(
    'partnerHours',
  );
  @override
  late final GeneratedColumn<int> partnerHours = GeneratedColumn<int>(
    'partner_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hasSoVerklaringMeta = const VerificationMeta(
    'hasSoVerklaring',
  );
  @override
  late final GeneratedColumn<bool> hasSoVerklaring = GeneratedColumn<bool>(
    'has_so_verklaring',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_so_verklaring" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _soStarterMeta = const VerificationMeta(
    'soStarter',
  );
  @override
  late final GeneratedColumn<bool> soStarter = GeneratedColumn<bool>(
    'so_starter',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("so_starter" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _businessCeasedMeta = const VerificationMeta(
    'businessCeased',
  );
  @override
  late final GeneratedColumn<bool> businessCeased = GeneratedColumn<bool>(
    'business_ceased',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("business_ceased" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _stakingsaftrekUsedBeforeMeta =
      const VerificationMeta('stakingsaftrekUsedBefore');
  @override
  late final GeneratedColumn<int> stakingsaftrekUsedBefore =
      GeneratedColumn<int>(
        'stakingsaftrek_used_before',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _disabilityBenefitMeta = const VerificationMeta(
    'disabilityBenefit',
  );
  @override
  late final GeneratedColumn<bool> disabilityBenefit = GeneratedColumn<bool>(
    'disability_benefit',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("disability_benefit" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _disabilityStartersUsedMeta =
      const VerificationMeta('disabilityStartersUsed');
  @override
  late final GeneratedColumn<int> disabilityStartersUsed = GeneratedColumn<int>(
    'disability_starters_used',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unrealisedZelfstandigenaftrekMeta =
      const VerificationMeta('unrealisedZelfstandigenaftrek');
  @override
  late final GeneratedColumn<int> unrealisedZelfstandigenaftrek =
      GeneratedColumn<int>(
        'unrealised_zelfstandigenaftrek',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _lossCarryForwardMeta = const VerificationMeta(
    'lossCarryForward',
  );
  @override
  late final GeneratedColumn<int> lossCarryForward = GeneratedColumn<int>(
    'loss_carry_forward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    year,
    partnerHours,
    hasSoVerklaring,
    soStarter,
    businessCeased,
    stakingsaftrekUsedBefore,
    disabilityBenefit,
    disabilityStartersUsed,
    unrealisedZelfstandigenaftrek,
    lossCarryForward,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tax_year_inputs';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaxYearInput> instance, {
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
    if (data.containsKey('partner_hours')) {
      context.handle(
        _partnerHoursMeta,
        partnerHours.isAcceptableOrUnknown(
          data['partner_hours']!,
          _partnerHoursMeta,
        ),
      );
    }
    if (data.containsKey('has_so_verklaring')) {
      context.handle(
        _hasSoVerklaringMeta,
        hasSoVerklaring.isAcceptableOrUnknown(
          data['has_so_verklaring']!,
          _hasSoVerklaringMeta,
        ),
      );
    }
    if (data.containsKey('so_starter')) {
      context.handle(
        _soStarterMeta,
        soStarter.isAcceptableOrUnknown(data['so_starter']!, _soStarterMeta),
      );
    }
    if (data.containsKey('business_ceased')) {
      context.handle(
        _businessCeasedMeta,
        businessCeased.isAcceptableOrUnknown(
          data['business_ceased']!,
          _businessCeasedMeta,
        ),
      );
    }
    if (data.containsKey('stakingsaftrek_used_before')) {
      context.handle(
        _stakingsaftrekUsedBeforeMeta,
        stakingsaftrekUsedBefore.isAcceptableOrUnknown(
          data['stakingsaftrek_used_before']!,
          _stakingsaftrekUsedBeforeMeta,
        ),
      );
    }
    if (data.containsKey('disability_benefit')) {
      context.handle(
        _disabilityBenefitMeta,
        disabilityBenefit.isAcceptableOrUnknown(
          data['disability_benefit']!,
          _disabilityBenefitMeta,
        ),
      );
    }
    if (data.containsKey('disability_starters_used')) {
      context.handle(
        _disabilityStartersUsedMeta,
        disabilityStartersUsed.isAcceptableOrUnknown(
          data['disability_starters_used']!,
          _disabilityStartersUsedMeta,
        ),
      );
    }
    if (data.containsKey('unrealised_zelfstandigenaftrek')) {
      context.handle(
        _unrealisedZelfstandigenaftrekMeta,
        unrealisedZelfstandigenaftrek.isAcceptableOrUnknown(
          data['unrealised_zelfstandigenaftrek']!,
          _unrealisedZelfstandigenaftrekMeta,
        ),
      );
    }
    if (data.containsKey('loss_carry_forward')) {
      context.handle(
        _lossCarryForwardMeta,
        lossCarryForward.isAcceptableOrUnknown(
          data['loss_carry_forward']!,
          _lossCarryForwardMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {year};
  @override
  TaxYearInput map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaxYearInput(
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      partnerHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}partner_hours'],
      )!,
      hasSoVerklaring: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_so_verklaring'],
      )!,
      soStarter: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}so_starter'],
      )!,
      businessCeased: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}business_ceased'],
      )!,
      stakingsaftrekUsedBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stakingsaftrek_used_before'],
      )!,
      disabilityBenefit: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}disability_benefit'],
      )!,
      disabilityStartersUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disability_starters_used'],
      )!,
      unrealisedZelfstandigenaftrek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unrealised_zelfstandigenaftrek'],
      )!,
      lossCarryForward: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}loss_carry_forward'],
      )!,
    );
  }

  @override
  $TaxYearInputsTable createAlias(String alias) {
    return $TaxYearInputsTable(attachedDatabase, alias);
  }
}

class TaxYearInput extends DataClass implements Insertable<TaxYearInput> {
  final int year;

  /// Hours the fiscal partner worked in the business unpaid or for less than
  /// € 5.000 (meewerkaftrek).
  final int partnerHours;
  final bool hasSoVerklaring;

  /// Not an ondernemer in one of the five previous years and at most two
  /// S&O-verklaringen in that period (art. 3.77 lid 2).
  final bool soStarter;

  /// The whole business stopped this year (stakingsaftrek).
  final bool businessCeased;
  final int stakingsaftrekUsedBefore;

  /// A disability benefit this year (startersaftrek bij arbeidsongeschiktheid).
  final bool disabilityBenefit;

  /// Years in the previous five this startersaftrek was used: 0 to 3.
  final int disabilityStartersUsed;

  /// Niet-gerealiseerde zelfstandigenaftrek from earlier years.
  final int unrealisedZelfstandigenaftrek;

  /// Box 1 losses from earlier years still to offset.
  final int lossCarryForward;
  const TaxYearInput({
    required this.year,
    required this.partnerHours,
    required this.hasSoVerklaring,
    required this.soStarter,
    required this.businessCeased,
    required this.stakingsaftrekUsedBefore,
    required this.disabilityBenefit,
    required this.disabilityStartersUsed,
    required this.unrealisedZelfstandigenaftrek,
    required this.lossCarryForward,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['year'] = Variable<int>(year);
    map['partner_hours'] = Variable<int>(partnerHours);
    map['has_so_verklaring'] = Variable<bool>(hasSoVerklaring);
    map['so_starter'] = Variable<bool>(soStarter);
    map['business_ceased'] = Variable<bool>(businessCeased);
    map['stakingsaftrek_used_before'] = Variable<int>(stakingsaftrekUsedBefore);
    map['disability_benefit'] = Variable<bool>(disabilityBenefit);
    map['disability_starters_used'] = Variable<int>(disabilityStartersUsed);
    map['unrealised_zelfstandigenaftrek'] = Variable<int>(
      unrealisedZelfstandigenaftrek,
    );
    map['loss_carry_forward'] = Variable<int>(lossCarryForward);
    return map;
  }

  TaxYearInputsCompanion toCompanion(bool nullToAbsent) {
    return TaxYearInputsCompanion(
      year: Value(year),
      partnerHours: Value(partnerHours),
      hasSoVerklaring: Value(hasSoVerklaring),
      soStarter: Value(soStarter),
      businessCeased: Value(businessCeased),
      stakingsaftrekUsedBefore: Value(stakingsaftrekUsedBefore),
      disabilityBenefit: Value(disabilityBenefit),
      disabilityStartersUsed: Value(disabilityStartersUsed),
      unrealisedZelfstandigenaftrek: Value(unrealisedZelfstandigenaftrek),
      lossCarryForward: Value(lossCarryForward),
    );
  }

  factory TaxYearInput.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaxYearInput(
      year: serializer.fromJson<int>(json['year']),
      partnerHours: serializer.fromJson<int>(json['partnerHours']),
      hasSoVerklaring: serializer.fromJson<bool>(json['hasSoVerklaring']),
      soStarter: serializer.fromJson<bool>(json['soStarter']),
      businessCeased: serializer.fromJson<bool>(json['businessCeased']),
      stakingsaftrekUsedBefore: serializer.fromJson<int>(
        json['stakingsaftrekUsedBefore'],
      ),
      disabilityBenefit: serializer.fromJson<bool>(json['disabilityBenefit']),
      disabilityStartersUsed: serializer.fromJson<int>(
        json['disabilityStartersUsed'],
      ),
      unrealisedZelfstandigenaftrek: serializer.fromJson<int>(
        json['unrealisedZelfstandigenaftrek'],
      ),
      lossCarryForward: serializer.fromJson<int>(json['lossCarryForward']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'year': serializer.toJson<int>(year),
      'partnerHours': serializer.toJson<int>(partnerHours),
      'hasSoVerklaring': serializer.toJson<bool>(hasSoVerklaring),
      'soStarter': serializer.toJson<bool>(soStarter),
      'businessCeased': serializer.toJson<bool>(businessCeased),
      'stakingsaftrekUsedBefore': serializer.toJson<int>(
        stakingsaftrekUsedBefore,
      ),
      'disabilityBenefit': serializer.toJson<bool>(disabilityBenefit),
      'disabilityStartersUsed': serializer.toJson<int>(disabilityStartersUsed),
      'unrealisedZelfstandigenaftrek': serializer.toJson<int>(
        unrealisedZelfstandigenaftrek,
      ),
      'lossCarryForward': serializer.toJson<int>(lossCarryForward),
    };
  }

  TaxYearInput copyWith({
    int? year,
    int? partnerHours,
    bool? hasSoVerklaring,
    bool? soStarter,
    bool? businessCeased,
    int? stakingsaftrekUsedBefore,
    bool? disabilityBenefit,
    int? disabilityStartersUsed,
    int? unrealisedZelfstandigenaftrek,
    int? lossCarryForward,
  }) => TaxYearInput(
    year: year ?? this.year,
    partnerHours: partnerHours ?? this.partnerHours,
    hasSoVerklaring: hasSoVerklaring ?? this.hasSoVerklaring,
    soStarter: soStarter ?? this.soStarter,
    businessCeased: businessCeased ?? this.businessCeased,
    stakingsaftrekUsedBefore:
        stakingsaftrekUsedBefore ?? this.stakingsaftrekUsedBefore,
    disabilityBenefit: disabilityBenefit ?? this.disabilityBenefit,
    disabilityStartersUsed:
        disabilityStartersUsed ?? this.disabilityStartersUsed,
    unrealisedZelfstandigenaftrek:
        unrealisedZelfstandigenaftrek ?? this.unrealisedZelfstandigenaftrek,
    lossCarryForward: lossCarryForward ?? this.lossCarryForward,
  );
  TaxYearInput copyWithCompanion(TaxYearInputsCompanion data) {
    return TaxYearInput(
      year: data.year.present ? data.year.value : this.year,
      partnerHours: data.partnerHours.present
          ? data.partnerHours.value
          : this.partnerHours,
      hasSoVerklaring: data.hasSoVerklaring.present
          ? data.hasSoVerklaring.value
          : this.hasSoVerklaring,
      soStarter: data.soStarter.present ? data.soStarter.value : this.soStarter,
      businessCeased: data.businessCeased.present
          ? data.businessCeased.value
          : this.businessCeased,
      stakingsaftrekUsedBefore: data.stakingsaftrekUsedBefore.present
          ? data.stakingsaftrekUsedBefore.value
          : this.stakingsaftrekUsedBefore,
      disabilityBenefit: data.disabilityBenefit.present
          ? data.disabilityBenefit.value
          : this.disabilityBenefit,
      disabilityStartersUsed: data.disabilityStartersUsed.present
          ? data.disabilityStartersUsed.value
          : this.disabilityStartersUsed,
      unrealisedZelfstandigenaftrek: data.unrealisedZelfstandigenaftrek.present
          ? data.unrealisedZelfstandigenaftrek.value
          : this.unrealisedZelfstandigenaftrek,
      lossCarryForward: data.lossCarryForward.present
          ? data.lossCarryForward.value
          : this.lossCarryForward,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaxYearInput(')
          ..write('year: $year, ')
          ..write('partnerHours: $partnerHours, ')
          ..write('hasSoVerklaring: $hasSoVerklaring, ')
          ..write('soStarter: $soStarter, ')
          ..write('businessCeased: $businessCeased, ')
          ..write('stakingsaftrekUsedBefore: $stakingsaftrekUsedBefore, ')
          ..write('disabilityBenefit: $disabilityBenefit, ')
          ..write('disabilityStartersUsed: $disabilityStartersUsed, ')
          ..write(
            'unrealisedZelfstandigenaftrek: $unrealisedZelfstandigenaftrek, ',
          )
          ..write('lossCarryForward: $lossCarryForward')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    year,
    partnerHours,
    hasSoVerklaring,
    soStarter,
    businessCeased,
    stakingsaftrekUsedBefore,
    disabilityBenefit,
    disabilityStartersUsed,
    unrealisedZelfstandigenaftrek,
    lossCarryForward,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaxYearInput &&
          other.year == this.year &&
          other.partnerHours == this.partnerHours &&
          other.hasSoVerklaring == this.hasSoVerklaring &&
          other.soStarter == this.soStarter &&
          other.businessCeased == this.businessCeased &&
          other.stakingsaftrekUsedBefore == this.stakingsaftrekUsedBefore &&
          other.disabilityBenefit == this.disabilityBenefit &&
          other.disabilityStartersUsed == this.disabilityStartersUsed &&
          other.unrealisedZelfstandigenaftrek ==
              this.unrealisedZelfstandigenaftrek &&
          other.lossCarryForward == this.lossCarryForward);
}

class TaxYearInputsCompanion extends UpdateCompanion<TaxYearInput> {
  final Value<int> year;
  final Value<int> partnerHours;
  final Value<bool> hasSoVerklaring;
  final Value<bool> soStarter;
  final Value<bool> businessCeased;
  final Value<int> stakingsaftrekUsedBefore;
  final Value<bool> disabilityBenefit;
  final Value<int> disabilityStartersUsed;
  final Value<int> unrealisedZelfstandigenaftrek;
  final Value<int> lossCarryForward;
  const TaxYearInputsCompanion({
    this.year = const Value.absent(),
    this.partnerHours = const Value.absent(),
    this.hasSoVerklaring = const Value.absent(),
    this.soStarter = const Value.absent(),
    this.businessCeased = const Value.absent(),
    this.stakingsaftrekUsedBefore = const Value.absent(),
    this.disabilityBenefit = const Value.absent(),
    this.disabilityStartersUsed = const Value.absent(),
    this.unrealisedZelfstandigenaftrek = const Value.absent(),
    this.lossCarryForward = const Value.absent(),
  });
  TaxYearInputsCompanion.insert({
    this.year = const Value.absent(),
    this.partnerHours = const Value.absent(),
    this.hasSoVerklaring = const Value.absent(),
    this.soStarter = const Value.absent(),
    this.businessCeased = const Value.absent(),
    this.stakingsaftrekUsedBefore = const Value.absent(),
    this.disabilityBenefit = const Value.absent(),
    this.disabilityStartersUsed = const Value.absent(),
    this.unrealisedZelfstandigenaftrek = const Value.absent(),
    this.lossCarryForward = const Value.absent(),
  });
  static Insertable<TaxYearInput> custom({
    Expression<int>? year,
    Expression<int>? partnerHours,
    Expression<bool>? hasSoVerklaring,
    Expression<bool>? soStarter,
    Expression<bool>? businessCeased,
    Expression<int>? stakingsaftrekUsedBefore,
    Expression<bool>? disabilityBenefit,
    Expression<int>? disabilityStartersUsed,
    Expression<int>? unrealisedZelfstandigenaftrek,
    Expression<int>? lossCarryForward,
  }) {
    return RawValuesInsertable({
      if (year != null) 'year': year,
      if (partnerHours != null) 'partner_hours': partnerHours,
      if (hasSoVerklaring != null) 'has_so_verklaring': hasSoVerklaring,
      if (soStarter != null) 'so_starter': soStarter,
      if (businessCeased != null) 'business_ceased': businessCeased,
      if (stakingsaftrekUsedBefore != null)
        'stakingsaftrek_used_before': stakingsaftrekUsedBefore,
      if (disabilityBenefit != null) 'disability_benefit': disabilityBenefit,
      if (disabilityStartersUsed != null)
        'disability_starters_used': disabilityStartersUsed,
      if (unrealisedZelfstandigenaftrek != null)
        'unrealised_zelfstandigenaftrek': unrealisedZelfstandigenaftrek,
      if (lossCarryForward != null) 'loss_carry_forward': lossCarryForward,
    });
  }

  TaxYearInputsCompanion copyWith({
    Value<int>? year,
    Value<int>? partnerHours,
    Value<bool>? hasSoVerklaring,
    Value<bool>? soStarter,
    Value<bool>? businessCeased,
    Value<int>? stakingsaftrekUsedBefore,
    Value<bool>? disabilityBenefit,
    Value<int>? disabilityStartersUsed,
    Value<int>? unrealisedZelfstandigenaftrek,
    Value<int>? lossCarryForward,
  }) {
    return TaxYearInputsCompanion(
      year: year ?? this.year,
      partnerHours: partnerHours ?? this.partnerHours,
      hasSoVerklaring: hasSoVerklaring ?? this.hasSoVerklaring,
      soStarter: soStarter ?? this.soStarter,
      businessCeased: businessCeased ?? this.businessCeased,
      stakingsaftrekUsedBefore:
          stakingsaftrekUsedBefore ?? this.stakingsaftrekUsedBefore,
      disabilityBenefit: disabilityBenefit ?? this.disabilityBenefit,
      disabilityStartersUsed:
          disabilityStartersUsed ?? this.disabilityStartersUsed,
      unrealisedZelfstandigenaftrek:
          unrealisedZelfstandigenaftrek ?? this.unrealisedZelfstandigenaftrek,
      lossCarryForward: lossCarryForward ?? this.lossCarryForward,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (partnerHours.present) {
      map['partner_hours'] = Variable<int>(partnerHours.value);
    }
    if (hasSoVerklaring.present) {
      map['has_so_verklaring'] = Variable<bool>(hasSoVerklaring.value);
    }
    if (soStarter.present) {
      map['so_starter'] = Variable<bool>(soStarter.value);
    }
    if (businessCeased.present) {
      map['business_ceased'] = Variable<bool>(businessCeased.value);
    }
    if (stakingsaftrekUsedBefore.present) {
      map['stakingsaftrek_used_before'] = Variable<int>(
        stakingsaftrekUsedBefore.value,
      );
    }
    if (disabilityBenefit.present) {
      map['disability_benefit'] = Variable<bool>(disabilityBenefit.value);
    }
    if (disabilityStartersUsed.present) {
      map['disability_starters_used'] = Variable<int>(
        disabilityStartersUsed.value,
      );
    }
    if (unrealisedZelfstandigenaftrek.present) {
      map['unrealised_zelfstandigenaftrek'] = Variable<int>(
        unrealisedZelfstandigenaftrek.value,
      );
    }
    if (lossCarryForward.present) {
      map['loss_carry_forward'] = Variable<int>(lossCarryForward.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaxYearInputsCompanion(')
          ..write('year: $year, ')
          ..write('partnerHours: $partnerHours, ')
          ..write('hasSoVerklaring: $hasSoVerklaring, ')
          ..write('soStarter: $soStarter, ')
          ..write('businessCeased: $businessCeased, ')
          ..write('stakingsaftrekUsedBefore: $stakingsaftrekUsedBefore, ')
          ..write('disabilityBenefit: $disabilityBenefit, ')
          ..write('disabilityStartersUsed: $disabilityStartersUsed, ')
          ..write(
            'unrealisedZelfstandigenaftrek: $unrealisedZelfstandigenaftrek, ',
          )
          ..write('lossCarryForward: $lossCarryForward')
          ..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts with TableInfo<$ReceiptsTable, Receipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expenseIdMeta = const VerificationMeta(
    'expenseId',
  );
  @override
  late final GeneratedColumn<int> expenseId = GeneratedColumn<int>(
    'expense_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES expenses (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _assetIdMeta = const VerificationMeta(
    'assetId',
  );
  @override
  late final GeneratedColumn<int> assetId = GeneratedColumn<int>(
    'asset_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fixed_assets (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReceiptType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ReceiptType>($ReceiptsTable.$convertertype);
  static const VerificationMeta _originalNameMeta = const VerificationMeta(
    'originalName',
  );
  @override
  late final GeneratedColumn<String> originalName = GeneratedColumn<String>(
    'original_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _removedAtMeta = const VerificationMeta(
    'removedAt',
  );
  @override
  late final GeneratedColumn<DateTime> removedAt = GeneratedColumn<DateTime>(
    'removed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReceiptOwnerKind?, String>
  removedFromKind = GeneratedColumn<String>(
    'removed_from_kind',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<ReceiptOwnerKind?>($ReceiptsTable.$converterremovedFromKindn);
  static const VerificationMeta _removedFromDateMeta = const VerificationMeta(
    'removedFromDate',
  );
  @override
  late final GeneratedColumn<DateTime> removedFromDate =
      GeneratedColumn<DateTime>(
        'removed_from_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _removedFromNameMeta = const VerificationMeta(
    'removedFromName',
  );
  @override
  late final GeneratedColumn<String> removedFromName = GeneratedColumn<String>(
    'removed_from_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    expenseId,
    assetId,
    invoiceId,
    year,
    type,
    originalName,
    sizeBytes,
    sha256,
    addedAt,
    removedAt,
    removedFromKind,
    removedFromDate,
    removedFromName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Receipt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('expense_id')) {
      context.handle(
        _expenseIdMeta,
        expenseId.isAcceptableOrUnknown(data['expense_id']!, _expenseIdMeta),
      );
    }
    if (data.containsKey('asset_id')) {
      context.handle(
        _assetIdMeta,
        assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta),
      );
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('original_name')) {
      context.handle(
        _originalNameMeta,
        originalName.isAcceptableOrUnknown(
          data['original_name']!,
          _originalNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalNameMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    if (data.containsKey('removed_at')) {
      context.handle(
        _removedAtMeta,
        removedAt.isAcceptableOrUnknown(data['removed_at']!, _removedAtMeta),
      );
    }
    if (data.containsKey('removed_from_date')) {
      context.handle(
        _removedFromDateMeta,
        removedFromDate.isAcceptableOrUnknown(
          data['removed_from_date']!,
          _removedFromDateMeta,
        ),
      );
    }
    if (data.containsKey('removed_from_name')) {
      context.handle(
        _removedFromNameMeta,
        removedFromName.isAcceptableOrUnknown(
          data['removed_from_name']!,
          _removedFromNameMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receipt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      expenseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expense_id'],
      ),
      assetId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}asset_id'],
      ),
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      ),
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      type: $ReceiptsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      originalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_name'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
      removedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}removed_at'],
      ),
      removedFromKind: $ReceiptsTable.$converterremovedFromKindn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}removed_from_kind'],
        ),
      ),
      removedFromDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}removed_from_date'],
      ),
      removedFromName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}removed_from_name'],
      ),
    );
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReceiptType, String, String> $convertertype =
      const EnumNameConverter<ReceiptType>(ReceiptType.values);
  static JsonTypeConverter2<ReceiptOwnerKind, String, String>
  $converterremovedFromKind = const EnumNameConverter<ReceiptOwnerKind>(
    ReceiptOwnerKind.values,
  );
  static JsonTypeConverter2<ReceiptOwnerKind?, String?, String?>
  $converterremovedFromKindn = JsonTypeConverter2.asNullable(
    $converterremovedFromKind,
  );
}

class Receipt extends DataClass implements Insertable<Receipt> {
  /// A random UUID, which is also the file name.
  final String id;
  final int? expenseId;
  final int? assetId;
  final int? invoiceId;

  /// The year folder the file is in: the bookkeeping year of its owner.
  final int year;
  final ReceiptType type;

  /// The name of the file the user added, shown and used in exports.
  final String originalName;
  final int sizeBytes;

  /// SHA-256 of the stored file, to find duplicates and changed files.
  final String sha256;
  final DateTime addedAt;

  /// When the user removed it from its record, or null while in use.
  final DateTime? removedAt;

  /// What it belonged to when removed, kept for when that record is gone.
  final ReceiptOwnerKind? removedFromKind;
  final DateTime? removedFromDate;
  final String? removedFromName;
  const Receipt({
    required this.id,
    this.expenseId,
    this.assetId,
    this.invoiceId,
    required this.year,
    required this.type,
    required this.originalName,
    required this.sizeBytes,
    required this.sha256,
    required this.addedAt,
    this.removedAt,
    this.removedFromKind,
    this.removedFromDate,
    this.removedFromName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || expenseId != null) {
      map['expense_id'] = Variable<int>(expenseId);
    }
    if (!nullToAbsent || assetId != null) {
      map['asset_id'] = Variable<int>(assetId);
    }
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<int>(invoiceId);
    }
    map['year'] = Variable<int>(year);
    {
      map['type'] = Variable<String>($ReceiptsTable.$convertertype.toSql(type));
    }
    map['original_name'] = Variable<String>(originalName);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['sha256'] = Variable<String>(sha256);
    map['added_at'] = Variable<DateTime>(addedAt);
    if (!nullToAbsent || removedAt != null) {
      map['removed_at'] = Variable<DateTime>(removedAt);
    }
    if (!nullToAbsent || removedFromKind != null) {
      map['removed_from_kind'] = Variable<String>(
        $ReceiptsTable.$converterremovedFromKindn.toSql(removedFromKind),
      );
    }
    if (!nullToAbsent || removedFromDate != null) {
      map['removed_from_date'] = Variable<DateTime>(removedFromDate);
    }
    if (!nullToAbsent || removedFromName != null) {
      map['removed_from_name'] = Variable<String>(removedFromName);
    }
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      expenseId: expenseId == null && nullToAbsent
          ? const Value.absent()
          : Value(expenseId),
      assetId: assetId == null && nullToAbsent
          ? const Value.absent()
          : Value(assetId),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
      year: Value(year),
      type: Value(type),
      originalName: Value(originalName),
      sizeBytes: Value(sizeBytes),
      sha256: Value(sha256),
      addedAt: Value(addedAt),
      removedAt: removedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(removedAt),
      removedFromKind: removedFromKind == null && nullToAbsent
          ? const Value.absent()
          : Value(removedFromKind),
      removedFromDate: removedFromDate == null && nullToAbsent
          ? const Value.absent()
          : Value(removedFromDate),
      removedFromName: removedFromName == null && nullToAbsent
          ? const Value.absent()
          : Value(removedFromName),
    );
  }

  factory Receipt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<String>(json['id']),
      expenseId: serializer.fromJson<int?>(json['expenseId']),
      assetId: serializer.fromJson<int?>(json['assetId']),
      invoiceId: serializer.fromJson<int?>(json['invoiceId']),
      year: serializer.fromJson<int>(json['year']),
      type: $ReceiptsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      originalName: serializer.fromJson<String>(json['originalName']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      sha256: serializer.fromJson<String>(json['sha256']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
      removedAt: serializer.fromJson<DateTime?>(json['removedAt']),
      removedFromKind: $ReceiptsTable.$converterremovedFromKindn.fromJson(
        serializer.fromJson<String?>(json['removedFromKind']),
      ),
      removedFromDate: serializer.fromJson<DateTime?>(json['removedFromDate']),
      removedFromName: serializer.fromJson<String?>(json['removedFromName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'expenseId': serializer.toJson<int?>(expenseId),
      'assetId': serializer.toJson<int?>(assetId),
      'invoiceId': serializer.toJson<int?>(invoiceId),
      'year': serializer.toJson<int>(year),
      'type': serializer.toJson<String>(
        $ReceiptsTable.$convertertype.toJson(type),
      ),
      'originalName': serializer.toJson<String>(originalName),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'sha256': serializer.toJson<String>(sha256),
      'addedAt': serializer.toJson<DateTime>(addedAt),
      'removedAt': serializer.toJson<DateTime?>(removedAt),
      'removedFromKind': serializer.toJson<String?>(
        $ReceiptsTable.$converterremovedFromKindn.toJson(removedFromKind),
      ),
      'removedFromDate': serializer.toJson<DateTime?>(removedFromDate),
      'removedFromName': serializer.toJson<String?>(removedFromName),
    };
  }

  Receipt copyWith({
    String? id,
    Value<int?> expenseId = const Value.absent(),
    Value<int?> assetId = const Value.absent(),
    Value<int?> invoiceId = const Value.absent(),
    int? year,
    ReceiptType? type,
    String? originalName,
    int? sizeBytes,
    String? sha256,
    DateTime? addedAt,
    Value<DateTime?> removedAt = const Value.absent(),
    Value<ReceiptOwnerKind?> removedFromKind = const Value.absent(),
    Value<DateTime?> removedFromDate = const Value.absent(),
    Value<String?> removedFromName = const Value.absent(),
  }) => Receipt(
    id: id ?? this.id,
    expenseId: expenseId.present ? expenseId.value : this.expenseId,
    assetId: assetId.present ? assetId.value : this.assetId,
    invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
    year: year ?? this.year,
    type: type ?? this.type,
    originalName: originalName ?? this.originalName,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    sha256: sha256 ?? this.sha256,
    addedAt: addedAt ?? this.addedAt,
    removedAt: removedAt.present ? removedAt.value : this.removedAt,
    removedFromKind: removedFromKind.present
        ? removedFromKind.value
        : this.removedFromKind,
    removedFromDate: removedFromDate.present
        ? removedFromDate.value
        : this.removedFromDate,
    removedFromName: removedFromName.present
        ? removedFromName.value
        : this.removedFromName,
  );
  Receipt copyWithCompanion(ReceiptsCompanion data) {
    return Receipt(
      id: data.id.present ? data.id.value : this.id,
      expenseId: data.expenseId.present ? data.expenseId.value : this.expenseId,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      year: data.year.present ? data.year.value : this.year,
      type: data.type.present ? data.type.value : this.type,
      originalName: data.originalName.present
          ? data.originalName.value
          : this.originalName,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
      removedAt: data.removedAt.present ? data.removedAt.value : this.removedAt,
      removedFromKind: data.removedFromKind.present
          ? data.removedFromKind.value
          : this.removedFromKind,
      removedFromDate: data.removedFromDate.present
          ? data.removedFromDate.value
          : this.removedFromDate,
      removedFromName: data.removedFromName.present
          ? data.removedFromName.value
          : this.removedFromName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('expenseId: $expenseId, ')
          ..write('assetId: $assetId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('year: $year, ')
          ..write('type: $type, ')
          ..write('originalName: $originalName, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('sha256: $sha256, ')
          ..write('addedAt: $addedAt, ')
          ..write('removedAt: $removedAt, ')
          ..write('removedFromKind: $removedFromKind, ')
          ..write('removedFromDate: $removedFromDate, ')
          ..write('removedFromName: $removedFromName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    expenseId,
    assetId,
    invoiceId,
    year,
    type,
    originalName,
    sizeBytes,
    sha256,
    addedAt,
    removedAt,
    removedFromKind,
    removedFromDate,
    removedFromName,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.expenseId == this.expenseId &&
          other.assetId == this.assetId &&
          other.invoiceId == this.invoiceId &&
          other.year == this.year &&
          other.type == this.type &&
          other.originalName == this.originalName &&
          other.sizeBytes == this.sizeBytes &&
          other.sha256 == this.sha256 &&
          other.addedAt == this.addedAt &&
          other.removedAt == this.removedAt &&
          other.removedFromKind == this.removedFromKind &&
          other.removedFromDate == this.removedFromDate &&
          other.removedFromName == this.removedFromName);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<String> id;
  final Value<int?> expenseId;
  final Value<int?> assetId;
  final Value<int?> invoiceId;
  final Value<int> year;
  final Value<ReceiptType> type;
  final Value<String> originalName;
  final Value<int> sizeBytes;
  final Value<String> sha256;
  final Value<DateTime> addedAt;
  final Value<DateTime?> removedAt;
  final Value<ReceiptOwnerKind?> removedFromKind;
  final Value<DateTime?> removedFromDate;
  final Value<String?> removedFromName;
  final Value<int> rowid;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.expenseId = const Value.absent(),
    this.assetId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.year = const Value.absent(),
    this.type = const Value.absent(),
    this.originalName = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.removedAt = const Value.absent(),
    this.removedFromKind = const Value.absent(),
    this.removedFromDate = const Value.absent(),
    this.removedFromName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    required String id,
    this.expenseId = const Value.absent(),
    this.assetId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    required int year,
    required ReceiptType type,
    required String originalName,
    required int sizeBytes,
    required String sha256,
    required DateTime addedAt,
    this.removedAt = const Value.absent(),
    this.removedFromKind = const Value.absent(),
    this.removedFromDate = const Value.absent(),
    this.removedFromName = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       year = Value(year),
       type = Value(type),
       originalName = Value(originalName),
       sizeBytes = Value(sizeBytes),
       sha256 = Value(sha256),
       addedAt = Value(addedAt);
  static Insertable<Receipt> custom({
    Expression<String>? id,
    Expression<int>? expenseId,
    Expression<int>? assetId,
    Expression<int>? invoiceId,
    Expression<int>? year,
    Expression<String>? type,
    Expression<String>? originalName,
    Expression<int>? sizeBytes,
    Expression<String>? sha256,
    Expression<DateTime>? addedAt,
    Expression<DateTime>? removedAt,
    Expression<String>? removedFromKind,
    Expression<DateTime>? removedFromDate,
    Expression<String>? removedFromName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expenseId != null) 'expense_id': expenseId,
      if (assetId != null) 'asset_id': assetId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (year != null) 'year': year,
      if (type != null) 'type': type,
      if (originalName != null) 'original_name': originalName,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (sha256 != null) 'sha256': sha256,
      if (addedAt != null) 'added_at': addedAt,
      if (removedAt != null) 'removed_at': removedAt,
      if (removedFromKind != null) 'removed_from_kind': removedFromKind,
      if (removedFromDate != null) 'removed_from_date': removedFromDate,
      if (removedFromName != null) 'removed_from_name': removedFromName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReceiptsCompanion copyWith({
    Value<String>? id,
    Value<int?>? expenseId,
    Value<int?>? assetId,
    Value<int?>? invoiceId,
    Value<int>? year,
    Value<ReceiptType>? type,
    Value<String>? originalName,
    Value<int>? sizeBytes,
    Value<String>? sha256,
    Value<DateTime>? addedAt,
    Value<DateTime?>? removedAt,
    Value<ReceiptOwnerKind?>? removedFromKind,
    Value<DateTime?>? removedFromDate,
    Value<String?>? removedFromName,
    Value<int>? rowid,
  }) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      expenseId: expenseId ?? this.expenseId,
      assetId: assetId ?? this.assetId,
      invoiceId: invoiceId ?? this.invoiceId,
      year: year ?? this.year,
      type: type ?? this.type,
      originalName: originalName ?? this.originalName,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      sha256: sha256 ?? this.sha256,
      addedAt: addedAt ?? this.addedAt,
      removedAt: removedAt ?? this.removedAt,
      removedFromKind: removedFromKind ?? this.removedFromKind,
      removedFromDate: removedFromDate ?? this.removedFromDate,
      removedFromName: removedFromName ?? this.removedFromName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (expenseId.present) {
      map['expense_id'] = Variable<int>(expenseId.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<int>(assetId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $ReceiptsTable.$convertertype.toSql(type.value),
      );
    }
    if (originalName.present) {
      map['original_name'] = Variable<String>(originalName.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (removedAt.present) {
      map['removed_at'] = Variable<DateTime>(removedAt.value);
    }
    if (removedFromKind.present) {
      map['removed_from_kind'] = Variable<String>(
        $ReceiptsTable.$converterremovedFromKindn.toSql(removedFromKind.value),
      );
    }
    if (removedFromDate.present) {
      map['removed_from_date'] = Variable<DateTime>(removedFromDate.value);
    }
    if (removedFromName.present) {
      map['removed_from_name'] = Variable<String>(removedFromName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('expenseId: $expenseId, ')
          ..write('assetId: $assetId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('year: $year, ')
          ..write('type: $type, ')
          ..write('originalName: $originalName, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('sha256: $sha256, ')
          ..write('addedAt: $addedAt, ')
          ..write('removedAt: $removedAt, ')
          ..write('removedFromKind: $removedFromKind, ')
          ..write('removedFromDate: $removedFromDate, ')
          ..write('removedFromName: $removedFromName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BusinessProfilesTable businessProfiles = $BusinessProfilesTable(
    this,
  );
  late final $ClientsTable clients = $ClientsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $InvoiceLinesTable invoiceLines = $InvoiceLinesTable(this);
  late final $FixedAssetsTable fixedAssets = $FixedAssetsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $HourEntriesTable hourEntries = $HourEntriesTable(this);
  late final $MileageTripsTable mileageTrips = $MileageTripsTable(this);
  late final $PensionEntriesTable pensionEntries = $PensionEntriesTable(this);
  late final $VatReturnsTable vatReturns = $VatReturnsTable(this);
  late final $TaxYearInputsTable taxYearInputs = $TaxYearInputsTable(this);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final Index invoicesInvoiceDate = Index(
    'invoices_invoice_date',
    'CREATE INDEX invoices_invoice_date ON invoices (invoice_date)',
  );
  late final Index expensesDate = Index(
    'expenses_date',
    'CREATE INDEX expenses_date ON expenses (date)',
  );
  late final Index hourEntriesDate = Index(
    'hour_entries_date',
    'CREATE INDEX hour_entries_date ON hour_entries (date)',
  );
  late final Index mileageTripsDate = Index(
    'mileage_trips_date',
    'CREATE INDEX mileage_trips_date ON mileage_trips (date)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    businessProfiles,
    clients,
    invoices,
    invoiceLines,
    fixedAssets,
    expenses,
    hourEntries,
    mileageTrips,
    pensionEntries,
    vatReturns,
    taxYearInputs,
    receipts,
    invoicesInvoiceDate,
    expensesDate,
    hourEntriesDate,
    mileageTripsDate,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'invoices',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('invoice_lines', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'expenses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('receipts', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fixed_assets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('receipts', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'invoices',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('receipts', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$BusinessProfilesTableCreateCompanionBuilder =
    BusinessProfilesCompanion Function({
      Value<int> id,
      required String name,
      required String vatNumber,
      required String kvkNumber,
      required String address,
      required String iban,
      Value<bool> isStarter,
      Value<DateTime?> korStart,
      Value<DateTime?> korEnd,
    });
typedef $$BusinessProfilesTableUpdateCompanionBuilder =
    BusinessProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> vatNumber,
      Value<String> kvkNumber,
      Value<String> address,
      Value<String> iban,
      Value<bool> isStarter,
      Value<DateTime?> korStart,
      Value<DateTime?> korEnd,
    });

class $$BusinessProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $BusinessProfilesTable> {
  $$BusinessProfilesTableFilterComposer({
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

  ColumnFilters<String> get iban => $composableBuilder(
    column: $table.iban,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStarter => $composableBuilder(
    column: $table.isStarter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get korStart => $composableBuilder(
    column: $table.korStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get korEnd => $composableBuilder(
    column: $table.korEnd,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BusinessProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $BusinessProfilesTable> {
  $$BusinessProfilesTableOrderingComposer({
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

  ColumnOrderings<String> get iban => $composableBuilder(
    column: $table.iban,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStarter => $composableBuilder(
    column: $table.isStarter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get korStart => $composableBuilder(
    column: $table.korStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get korEnd => $composableBuilder(
    column: $table.korEnd,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BusinessProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BusinessProfilesTable> {
  $$BusinessProfilesTableAnnotationComposer({
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

  GeneratedColumn<String> get vatNumber =>
      $composableBuilder(column: $table.vatNumber, builder: (column) => column);

  GeneratedColumn<String> get kvkNumber =>
      $composableBuilder(column: $table.kvkNumber, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get iban =>
      $composableBuilder(column: $table.iban, builder: (column) => column);

  GeneratedColumn<bool> get isStarter =>
      $composableBuilder(column: $table.isStarter, builder: (column) => column);

  GeneratedColumn<DateTime> get korStart =>
      $composableBuilder(column: $table.korStart, builder: (column) => column);

  GeneratedColumn<DateTime> get korEnd =>
      $composableBuilder(column: $table.korEnd, builder: (column) => column);
}

class $$BusinessProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BusinessProfilesTable,
          BusinessProfile,
          $$BusinessProfilesTableFilterComposer,
          $$BusinessProfilesTableOrderingComposer,
          $$BusinessProfilesTableAnnotationComposer,
          $$BusinessProfilesTableCreateCompanionBuilder,
          $$BusinessProfilesTableUpdateCompanionBuilder,
          (
            BusinessProfile,
            BaseReferences<
              _$AppDatabase,
              $BusinessProfilesTable,
              BusinessProfile
            >,
          ),
          BusinessProfile,
          PrefetchHooks Function()
        > {
  $$BusinessProfilesTableTableManager(
    _$AppDatabase db,
    $BusinessProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BusinessProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BusinessProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BusinessProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> vatNumber = const Value.absent(),
                Value<String> kvkNumber = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> iban = const Value.absent(),
                Value<bool> isStarter = const Value.absent(),
                Value<DateTime?> korStart = const Value.absent(),
                Value<DateTime?> korEnd = const Value.absent(),
              }) => BusinessProfilesCompanion(
                id: id,
                name: name,
                vatNumber: vatNumber,
                kvkNumber: kvkNumber,
                address: address,
                iban: iban,
                isStarter: isStarter,
                korStart: korStart,
                korEnd: korEnd,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String vatNumber,
                required String kvkNumber,
                required String address,
                required String iban,
                Value<bool> isStarter = const Value.absent(),
                Value<DateTime?> korStart = const Value.absent(),
                Value<DateTime?> korEnd = const Value.absent(),
              }) => BusinessProfilesCompanion.insert(
                id: id,
                name: name,
                vatNumber: vatNumber,
                kvkNumber: kvkNumber,
                address: address,
                iban: iban,
                isStarter: isStarter,
                korStart: korStart,
                korEnd: korEnd,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BusinessProfilesTable, BusinessProfile>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BusinessProfilesTable,
                    BusinessProfile
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BusinessProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BusinessProfilesTable,
      BusinessProfile,
      $$BusinessProfilesTableFilterComposer,
      $$BusinessProfilesTableOrderingComposer,
      $$BusinessProfilesTableAnnotationComposer,
      $$BusinessProfilesTableCreateCompanionBuilder,
      $$BusinessProfilesTableUpdateCompanionBuilder,
      (
        BusinessProfile,
        BaseReferences<_$AppDatabase, $BusinessProfilesTable, BusinessProfile>,
      ),
      BusinessProfile,
      PrefetchHooks Function()
    >;
typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      required String name,
      Value<String> country,
      Value<String?> vatNumber,
      Value<String?> kvkNumber,
      required String address,
      Value<String?> contactPerson,
      Value<String?> email,
      Value<String?> phone,
      required WetDbaRisk wetDbaRisk,
      Value<bool> contractSigned,
      Value<DateTime?> contractExpiry,
      Value<String?> notes,
      Value<bool> isActive,
      Value<bool> isMerchantOfRecord,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> country,
      Value<String?> vatNumber,
      Value<String?> kvkNumber,
      Value<String> address,
      Value<String?> contactPerson,
      Value<String?> email,
      Value<String?> phone,
      Value<WetDbaRisk> wetDbaRisk,
      Value<bool> contractSigned,
      Value<DateTime?> contractExpiry,
      Value<String?> notes,
      Value<bool> isActive,
      Value<bool> isMerchantOfRecord,
    });

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'clients__id__invoices__client_id',
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

  ColumnWithTypeConverterFilters<WetDbaRisk, WetDbaRisk, String>
  get wetDbaRisk => $composableBuilder(
    column: $table.wetDbaRisk,
    builder: (column) => ColumnWithTypeConverterFilters(column),
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

  ColumnFilters<bool> get isMerchantOfRecord => $composableBuilder(
    column: $table.isMerchantOfRecord,
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

  ColumnOrderings<String> get wetDbaRisk => $composableBuilder(
    column: $table.wetDbaRisk,
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

  ColumnOrderings<bool> get isMerchantOfRecord => $composableBuilder(
    column: $table.isMerchantOfRecord,
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

  GeneratedColumnWithTypeConverter<WetDbaRisk, String> get wetDbaRisk =>
      $composableBuilder(
        column: $table.wetDbaRisk,
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

  GeneratedColumn<bool> get isMerchantOfRecord => $composableBuilder(
    column: $table.isMerchantOfRecord,
    builder: (column) => column,
  );

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
                Value<String> address = const Value.absent(),
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<WetDbaRisk> wetDbaRisk = const Value.absent(),
                Value<bool> contractSigned = const Value.absent(),
                Value<DateTime?> contractExpiry = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isMerchantOfRecord = const Value.absent(),
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
                wetDbaRisk: wetDbaRisk,
                contractSigned: contractSigned,
                contractExpiry: contractExpiry,
                notes: notes,
                isActive: isActive,
                isMerchantOfRecord: isMerchantOfRecord,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> country = const Value.absent(),
                Value<String?> vatNumber = const Value.absent(),
                Value<String?> kvkNumber = const Value.absent(),
                required String address,
                Value<String?> contactPerson = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                required WetDbaRisk wetDbaRisk,
                Value<bool> contractSigned = const Value.absent(),
                Value<DateTime?> contractExpiry = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isMerchantOfRecord = const Value.absent(),
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
                wetDbaRisk: wetDbaRisk,
                contractSigned: contractSigned,
                contractExpiry: contractExpiry,
                notes: notes,
                isActive: isActive,
                isMerchantOfRecord: isMerchantOfRecord,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ClientsTable, Client>(table),
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
                    await $_getPrefetchedDataByColumns<
                      Client,
                      $ClientsTable,
                      Invoice,
                      $InvoicesTable
                    >(
                      currentTable: table,
                      referencedTable: $$ClientsTableReferences
                          ._invoicesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ClientsTableReferences(db, table, p0).invoicesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'client_id',
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
      required InvoiceType invoiceType,
      Value<int?> correctedInvoiceId,
      required DateTime invoiceDate,
      Value<DateTime?> supplyDate,
      required int clientId,
      required VatTreatment vatTreatment,
      Value<bool> selfBilled,
      required String sellerName,
      required String sellerVatNumber,
      required String sellerKvkNumber,
      required String sellerAddress,
      required String sellerIban,
      required int paymentTermDays,
      required InvoiceStatus status,
      Value<DateTime?> paidDate,
      Value<String?> notes,
      required int totalExclVat,
      required int totalVat,
      required int totalInclVat,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      Value<String> invoiceNumber,
      Value<InvoiceType> invoiceType,
      Value<int?> correctedInvoiceId,
      Value<DateTime> invoiceDate,
      Value<DateTime?> supplyDate,
      Value<int> clientId,
      Value<VatTreatment> vatTreatment,
      Value<bool> selfBilled,
      Value<String> sellerName,
      Value<String> sellerVatNumber,
      Value<String> sellerKvkNumber,
      Value<String> sellerAddress,
      Value<String> sellerIban,
      Value<int> paymentTermDays,
      Value<InvoiceStatus> status,
      Value<DateTime?> paidDate,
      Value<String?> notes,
      Value<int> totalExclVat,
      Value<int> totalVat,
      Value<int> totalInclVat,
    });

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _correctedInvoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('invoices__corrected_invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager? get correctedInvoiceId {
    final $_column = $_itemColumn<int>('corrected_invoice_id');
    if ($_column == null) return null;
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_correctedInvoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('invoices__client_id__clients__id');

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
    aliasName: 'invoices__id__invoice_lines__invoice_id',
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

  static MultiTypedResultKey<$FixedAssetsTable, List<FixedAsset>>
  _fixedAssetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fixedAssets,
    aliasName: 'invoices__id__fixed_assets__disposal_invoice_id',
  );

  $$FixedAssetsTableProcessedTableManager get fixedAssetsRefs {
    final manager = $$FixedAssetsTableTableManager(
      $_db,
      $_db.fixedAssets,
    ).filter((f) => f.disposalInvoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fixedAssetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReceiptsTable, List<Receipt>> _receiptsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.receipts,
    aliasName: 'invoices__id__receipts__invoice_id',
  );

  $$ReceiptsTableProcessedTableManager get receiptsRefs {
    final manager = $$ReceiptsTableTableManager(
      $_db,
      $_db.receipts,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_receiptsRefsTable($_db));
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

  ColumnWithTypeConverterFilters<InvoiceType, InvoiceType, String>
  get invoiceType => $composableBuilder(
    column: $table.invoiceType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get supplyDate => $composableBuilder(
    column: $table.supplyDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VatTreatment, VatTreatment, String>
  get vatTreatment => $composableBuilder(
    column: $table.vatTreatment,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get selfBilled => $composableBuilder(
    column: $table.selfBilled,
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

  ColumnFilters<String> get sellerIban => $composableBuilder(
    column: $table.sellerIban,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentTermDays => $composableBuilder(
    column: $table.paymentTermDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<InvoiceStatus, InvoiceStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get paidDate => $composableBuilder(
    column: $table.paidDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
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

  $$InvoicesTableFilterComposer get correctedInvoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.correctedInvoiceId,
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

  Expression<bool> fixedAssetsRefs(
    Expression<bool> Function($$FixedAssetsTableFilterComposer f) f,
  ) {
    final $$FixedAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixedAssets,
      getReferencedColumn: (t) => t.disposalInvoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixedAssetsTableFilterComposer(
            $db: $db,
            $table: $db.fixedAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> receiptsRefs(
    Expression<bool> Function($$ReceiptsTableFilterComposer f) f,
  ) {
    final $$ReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.receipts,
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

  ColumnOrderings<String> get invoiceType => $composableBuilder(
    column: $table.invoiceType,
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

  ColumnOrderings<String> get vatTreatment => $composableBuilder(
    column: $table.vatTreatment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get selfBilled => $composableBuilder(
    column: $table.selfBilled,
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

  ColumnOrderings<String> get sellerIban => $composableBuilder(
    column: $table.sellerIban,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentTermDays => $composableBuilder(
    column: $table.paymentTermDays,
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

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
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

  $$InvoicesTableOrderingComposer get correctedInvoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.correctedInvoiceId,
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

  GeneratedColumnWithTypeConverter<InvoiceType, String> get invoiceType =>
      $composableBuilder(
        column: $table.invoiceType,
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

  GeneratedColumnWithTypeConverter<VatTreatment, String> get vatTreatment =>
      $composableBuilder(
        column: $table.vatTreatment,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get selfBilled => $composableBuilder(
    column: $table.selfBilled,
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

  GeneratedColumn<String> get sellerIban => $composableBuilder(
    column: $table.sellerIban,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paymentTermDays => $composableBuilder(
    column: $table.paymentTermDays,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<InvoiceStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get paidDate =>
      $composableBuilder(column: $table.paidDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

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

  $$InvoicesTableAnnotationComposer get correctedInvoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.correctedInvoiceId,
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

  Expression<T> fixedAssetsRefs<T extends Object>(
    Expression<T> Function($$FixedAssetsTableAnnotationComposer a) f,
  ) {
    final $$FixedAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixedAssets,
      getReferencedColumn: (t) => t.disposalInvoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixedAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.fixedAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> receiptsRefs<T extends Object>(
    Expression<T> Function($$ReceiptsTableAnnotationComposer a) f,
  ) {
    final $$ReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.receipts,
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
          PrefetchHooks Function({
            bool correctedInvoiceId,
            bool clientId,
            bool invoiceLinesRefs,
            bool fixedAssetsRefs,
            bool receiptsRefs,
          })
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
                Value<InvoiceType> invoiceType = const Value.absent(),
                Value<int?> correctedInvoiceId = const Value.absent(),
                Value<DateTime> invoiceDate = const Value.absent(),
                Value<DateTime?> supplyDate = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<VatTreatment> vatTreatment = const Value.absent(),
                Value<bool> selfBilled = const Value.absent(),
                Value<String> sellerName = const Value.absent(),
                Value<String> sellerVatNumber = const Value.absent(),
                Value<String> sellerKvkNumber = const Value.absent(),
                Value<String> sellerAddress = const Value.absent(),
                Value<String> sellerIban = const Value.absent(),
                Value<int> paymentTermDays = const Value.absent(),
                Value<InvoiceStatus> status = const Value.absent(),
                Value<DateTime?> paidDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> totalExclVat = const Value.absent(),
                Value<int> totalVat = const Value.absent(),
                Value<int> totalInclVat = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                invoiceNumber: invoiceNumber,
                invoiceType: invoiceType,
                correctedInvoiceId: correctedInvoiceId,
                invoiceDate: invoiceDate,
                supplyDate: supplyDate,
                clientId: clientId,
                vatTreatment: vatTreatment,
                selfBilled: selfBilled,
                sellerName: sellerName,
                sellerVatNumber: sellerVatNumber,
                sellerKvkNumber: sellerKvkNumber,
                sellerAddress: sellerAddress,
                sellerIban: sellerIban,
                paymentTermDays: paymentTermDays,
                status: status,
                paidDate: paidDate,
                notes: notes,
                totalExclVat: totalExclVat,
                totalVat: totalVat,
                totalInclVat: totalInclVat,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String invoiceNumber,
                required InvoiceType invoiceType,
                Value<int?> correctedInvoiceId = const Value.absent(),
                required DateTime invoiceDate,
                Value<DateTime?> supplyDate = const Value.absent(),
                required int clientId,
                required VatTreatment vatTreatment,
                Value<bool> selfBilled = const Value.absent(),
                required String sellerName,
                required String sellerVatNumber,
                required String sellerKvkNumber,
                required String sellerAddress,
                required String sellerIban,
                required int paymentTermDays,
                required InvoiceStatus status,
                Value<DateTime?> paidDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int totalExclVat,
                required int totalVat,
                required int totalInclVat,
              }) => InvoicesCompanion.insert(
                id: id,
                invoiceNumber: invoiceNumber,
                invoiceType: invoiceType,
                correctedInvoiceId: correctedInvoiceId,
                invoiceDate: invoiceDate,
                supplyDate: supplyDate,
                clientId: clientId,
                vatTreatment: vatTreatment,
                selfBilled: selfBilled,
                sellerName: sellerName,
                sellerVatNumber: sellerVatNumber,
                sellerKvkNumber: sellerKvkNumber,
                sellerAddress: sellerAddress,
                sellerIban: sellerIban,
                paymentTermDays: paymentTermDays,
                status: status,
                paidDate: paidDate,
                notes: notes,
                totalExclVat: totalExclVat,
                totalVat: totalVat,
                totalInclVat: totalInclVat,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InvoicesTable, Invoice>(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                correctedInvoiceId = false,
                clientId = false,
                invoiceLinesRefs = false,
                fixedAssetsRefs = false,
                receiptsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceLinesRefs) db.invoiceLines,
                    if (fixedAssetsRefs) db.fixedAssets,
                    if (receiptsRefs) db.receipts,
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
                        if (correctedInvoiceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.correctedInvoiceId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._correctedInvoiceIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._correctedInvoiceIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
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
                        await $_getPrefetchedDataByColumns<
                          Invoice,
                          $InvoicesTable,
                          InvoiceLine,
                          $InvoiceLinesTable
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
                          currentColumn: 'id',
                          referencedColumn: 'invoice_id',
                          typedResults: items,
                        ),
                      if (fixedAssetsRefs)
                        await $_getPrefetchedDataByColumns<
                          Invoice,
                          $InvoicesTable,
                          FixedAsset,
                          $FixedAssetsTable
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._fixedAssetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).fixedAssetsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'disposal_invoice_id',
                          typedResults: items,
                        ),
                      if (receiptsRefs)
                        await $_getPrefetchedDataByColumns<
                          Invoice,
                          $InvoicesTable,
                          Receipt,
                          $ReceiptsTable
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._receiptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).receiptsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'invoice_id',
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
      PrefetchHooks Function({
        bool correctedInvoiceId,
        bool clientId,
        bool invoiceLinesRefs,
        bool fixedAssetsRefs,
        bool receiptsRefs,
      })
    >;
typedef $$InvoiceLinesTableCreateCompanionBuilder =
    InvoiceLinesCompanion Function({
      Value<int> id,
      required int invoiceId,
      required String description,
      required double quantity,
      Value<String?> unit,
      required int unitPriceExclVat,
      required VatRate vatRate,
      required int vatAmount,
      required int lineTotalExclVat,
      required int sortOrder,
    });
typedef $$InvoiceLinesTableUpdateCompanionBuilder =
    InvoiceLinesCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<String> description,
      Value<double> quantity,
      Value<String?> unit,
      Value<int> unitPriceExclVat,
      Value<VatRate> vatRate,
      Value<int> vatAmount,
      Value<int> lineTotalExclVat,
      Value<int> sortOrder,
    });

final class $$InvoiceLinesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoiceLinesTable, InvoiceLine> {
  $$InvoiceLinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('invoice_lines__invoice_id__invoices__id');

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

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceExclVat => $composableBuilder(
    column: $table.unitPriceExclVat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VatRate, VatRate, String> get vatRate =>
      $composableBuilder(
        column: $table.vatRate,
        builder: (column) => ColumnWithTypeConverterFilters(column),
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

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
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

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get unitPriceExclVat => $composableBuilder(
    column: $table.unitPriceExclVat,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<VatRate, String> get vatRate =>
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
                Value<double> quantity = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int> unitPriceExclVat = const Value.absent(),
                Value<VatRate> vatRate = const Value.absent(),
                Value<int> vatAmount = const Value.absent(),
                Value<int> lineTotalExclVat = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => InvoiceLinesCompanion(
                id: id,
                invoiceId: invoiceId,
                description: description,
                quantity: quantity,
                unit: unit,
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
                required double quantity,
                Value<String?> unit = const Value.absent(),
                required int unitPriceExclVat,
                required VatRate vatRate,
                required int vatAmount,
                required int lineTotalExclVat,
                required int sortOrder,
              }) => InvoiceLinesCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                description: description,
                quantity: quantity,
                unit: unit,
                unitPriceExclVat: unitPriceExclVat,
                vatRate: vatRate,
                vatAmount: vatAmount,
                lineTotalExclVat: lineTotalExclVat,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InvoiceLinesTable, InvoiceLine>(table),
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
typedef $$FixedAssetsTableCreateCompanionBuilder =
    FixedAssetsCompanion Function({
      Value<int> id,
      Value<AssetKind> kind,
      required String assetName,
      required int costExclVat,
      Value<VatRate?> vatRate,
      Value<PurchaseVat> purchaseVat,
      Value<int> vatAmount,
      Value<bool> vatReclaimable,
      Value<int> vatToReclaim,
      required int residualValue,
      required DateTime purchaseDate,
      required double businessUsePct,
      required int usefulLifeYears,
      Value<bool> kiaEligible,
      Value<bool> eiaEligible,
      Value<MiaCategory?> miaCategory,
      Value<int?> investmentDeductionReceived,
      Value<int> reinvestmentReserveApplied,
      Value<bool> reserveGain,
      Value<int?> catalogueValue,
      Value<DateTime?> firstRegistration,
      Value<ZeroEmission> zeroEmission,
      Value<int?> marketValue,
      Value<bool> keepsTripLog,
      Value<String?> notes,
      Value<DateTime?> disposalDate,
      Value<int?> disposalProceeds,
      Value<int?> disposalInvoiceId,
      Value<VatRate?> disposalVatRate,
      Value<int?> disposalVatAmount,
    });
typedef $$FixedAssetsTableUpdateCompanionBuilder =
    FixedAssetsCompanion Function({
      Value<int> id,
      Value<AssetKind> kind,
      Value<String> assetName,
      Value<int> costExclVat,
      Value<VatRate?> vatRate,
      Value<PurchaseVat> purchaseVat,
      Value<int> vatAmount,
      Value<bool> vatReclaimable,
      Value<int> vatToReclaim,
      Value<int> residualValue,
      Value<DateTime> purchaseDate,
      Value<double> businessUsePct,
      Value<int> usefulLifeYears,
      Value<bool> kiaEligible,
      Value<bool> eiaEligible,
      Value<MiaCategory?> miaCategory,
      Value<int?> investmentDeductionReceived,
      Value<int> reinvestmentReserveApplied,
      Value<bool> reserveGain,
      Value<int?> catalogueValue,
      Value<DateTime?> firstRegistration,
      Value<ZeroEmission> zeroEmission,
      Value<int?> marketValue,
      Value<bool> keepsTripLog,
      Value<String?> notes,
      Value<DateTime?> disposalDate,
      Value<int?> disposalProceeds,
      Value<int?> disposalInvoiceId,
      Value<VatRate?> disposalVatRate,
      Value<int?> disposalVatAmount,
    });

final class $$FixedAssetsTableReferences
    extends BaseReferences<_$AppDatabase, $FixedAssetsTable, FixedAsset> {
  $$FixedAssetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _disposalInvoiceIdTable(_$AppDatabase db) => db.invoices
      .createAlias('fixed_assets__disposal_invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager? get disposalInvoiceId {
    final $_column = $_itemColumn<int>('disposal_invoice_id');
    if ($_column == null) return null;
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_disposalInvoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.expenses,
    aliasName: 'fixed_assets__id__expenses__car_asset_id',
  );

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.carAssetId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MileageTripsTable, List<MileageTrip>>
  _mileageTripsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mileageTrips,
    aliasName: 'fixed_assets__id__mileage_trips__car_asset_id',
  );

  $$MileageTripsTableProcessedTableManager get mileageTripsRefs {
    final manager = $$MileageTripsTableTableManager(
      $_db,
      $_db.mileageTrips,
    ).filter((f) => f.carAssetId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mileageTripsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReceiptsTable, List<Receipt>> _receiptsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.receipts,
    aliasName: 'fixed_assets__id__receipts__asset_id',
  );

  $$ReceiptsTableProcessedTableManager get receiptsRefs {
    final manager = $$ReceiptsTableTableManager(
      $_db,
      $_db.receipts,
    ).filter((f) => f.assetId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_receiptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnWithTypeConverterFilters<AssetKind, AssetKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get assetName => $composableBuilder(
    column: $table.assetName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costExclVat => $composableBuilder(
    column: $table.costExclVat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VatRate?, VatRate, String> get vatRate =>
      $composableBuilder(
        column: $table.vatRate,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<PurchaseVat, PurchaseVat, String>
  get purchaseVat => $composableBuilder(
    column: $table.purchaseVat,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get vatAmount => $composableBuilder(
    column: $table.vatAmount,
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

  ColumnFilters<int> get residualValue => $composableBuilder(
    column: $table.residualValue,
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

  ColumnFilters<bool> get eiaEligible => $composableBuilder(
    column: $table.eiaEligible,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MiaCategory?, MiaCategory, String>
  get miaCategory => $composableBuilder(
    column: $table.miaCategory,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get investmentDeductionReceived => $composableBuilder(
    column: $table.investmentDeductionReceived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reinvestmentReserveApplied => $composableBuilder(
    column: $table.reinvestmentReserveApplied,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reserveGain => $composableBuilder(
    column: $table.reserveGain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get catalogueValue => $composableBuilder(
    column: $table.catalogueValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstRegistration => $composableBuilder(
    column: $table.firstRegistration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ZeroEmission, ZeroEmission, String>
  get zeroEmission => $composableBuilder(
    column: $table.zeroEmission,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get marketValue => $composableBuilder(
    column: $table.marketValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get keepsTripLog => $composableBuilder(
    column: $table.keepsTripLog,
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

  ColumnWithTypeConverterFilters<VatRate?, VatRate, String>
  get disposalVatRate => $composableBuilder(
    column: $table.disposalVatRate,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get disposalVatAmount => $composableBuilder(
    column: $table.disposalVatAmount,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get disposalInvoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.disposalInvoiceId,
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

  Expression<bool> expensesRefs(
    Expression<bool> Function($$ExpensesTableFilterComposer f) f,
  ) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.carAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mileageTripsRefs(
    Expression<bool> Function($$MileageTripsTableFilterComposer f) f,
  ) {
    final $$MileageTripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mileageTrips,
      getReferencedColumn: (t) => t.carAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MileageTripsTableFilterComposer(
            $db: $db,
            $table: $db.mileageTrips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> receiptsRefs(
    Expression<bool> Function($$ReceiptsTableFilterComposer f) f,
  ) {
    final $$ReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.assetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
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

  ColumnOrderings<String> get vatRate => $composableBuilder(
    column: $table.vatRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseVat => $composableBuilder(
    column: $table.purchaseVat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vatAmount => $composableBuilder(
    column: $table.vatAmount,
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

  ColumnOrderings<int> get residualValue => $composableBuilder(
    column: $table.residualValue,
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

  ColumnOrderings<bool> get eiaEligible => $composableBuilder(
    column: $table.eiaEligible,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get miaCategory => $composableBuilder(
    column: $table.miaCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get investmentDeductionReceived => $composableBuilder(
    column: $table.investmentDeductionReceived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reinvestmentReserveApplied => $composableBuilder(
    column: $table.reinvestmentReserveApplied,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reserveGain => $composableBuilder(
    column: $table.reserveGain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get catalogueValue => $composableBuilder(
    column: $table.catalogueValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstRegistration => $composableBuilder(
    column: $table.firstRegistration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get zeroEmission => $composableBuilder(
    column: $table.zeroEmission,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get marketValue => $composableBuilder(
    column: $table.marketValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get keepsTripLog => $composableBuilder(
    column: $table.keepsTripLog,
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

  ColumnOrderings<String> get disposalVatRate => $composableBuilder(
    column: $table.disposalVatRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get disposalVatAmount => $composableBuilder(
    column: $table.disposalVatAmount,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get disposalInvoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.disposalInvoiceId,
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

  GeneratedColumnWithTypeConverter<AssetKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get assetName =>
      $composableBuilder(column: $table.assetName, builder: (column) => column);

  GeneratedColumn<int> get costExclVat => $composableBuilder(
    column: $table.costExclVat,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<VatRate?, String> get vatRate =>
      $composableBuilder(column: $table.vatRate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PurchaseVat, String> get purchaseVat =>
      $composableBuilder(
        column: $table.purchaseVat,
        builder: (column) => column,
      );

  GeneratedColumn<int> get vatAmount =>
      $composableBuilder(column: $table.vatAmount, builder: (column) => column);

  GeneratedColumn<bool> get vatReclaimable => $composableBuilder(
    column: $table.vatReclaimable,
    builder: (column) => column,
  );

  GeneratedColumn<int> get vatToReclaim => $composableBuilder(
    column: $table.vatToReclaim,
    builder: (column) => column,
  );

  GeneratedColumn<int> get residualValue => $composableBuilder(
    column: $table.residualValue,
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

  GeneratedColumn<bool> get eiaEligible => $composableBuilder(
    column: $table.eiaEligible,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<MiaCategory?, String> get miaCategory =>
      $composableBuilder(
        column: $table.miaCategory,
        builder: (column) => column,
      );

  GeneratedColumn<int> get investmentDeductionReceived => $composableBuilder(
    column: $table.investmentDeductionReceived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reinvestmentReserveApplied => $composableBuilder(
    column: $table.reinvestmentReserveApplied,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reserveGain => $composableBuilder(
    column: $table.reserveGain,
    builder: (column) => column,
  );

  GeneratedColumn<int> get catalogueValue => $composableBuilder(
    column: $table.catalogueValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get firstRegistration => $composableBuilder(
    column: $table.firstRegistration,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ZeroEmission, String> get zeroEmission =>
      $composableBuilder(
        column: $table.zeroEmission,
        builder: (column) => column,
      );

  GeneratedColumn<int> get marketValue => $composableBuilder(
    column: $table.marketValue,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get keepsTripLog => $composableBuilder(
    column: $table.keepsTripLog,
    builder: (column) => column,
  );

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

  GeneratedColumnWithTypeConverter<VatRate?, String> get disposalVatRate =>
      $composableBuilder(
        column: $table.disposalVatRate,
        builder: (column) => column,
      );

  GeneratedColumn<int> get disposalVatAmount => $composableBuilder(
    column: $table.disposalVatAmount,
    builder: (column) => column,
  );

  $$InvoicesTableAnnotationComposer get disposalInvoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.disposalInvoiceId,
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

  Expression<T> expensesRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.carAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mileageTripsRefs<T extends Object>(
    Expression<T> Function($$MileageTripsTableAnnotationComposer a) f,
  ) {
    final $$MileageTripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mileageTrips,
      getReferencedColumn: (t) => t.carAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MileageTripsTableAnnotationComposer(
            $db: $db,
            $table: $db.mileageTrips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> receiptsRefs<T extends Object>(
    Expression<T> Function($$ReceiptsTableAnnotationComposer a) f,
  ) {
    final $$ReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.assetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (FixedAsset, $$FixedAssetsTableReferences),
          FixedAsset,
          PrefetchHooks Function({
            bool disposalInvoiceId,
            bool expensesRefs,
            bool mileageTripsRefs,
            bool receiptsRefs,
          })
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
                Value<AssetKind> kind = const Value.absent(),
                Value<String> assetName = const Value.absent(),
                Value<int> costExclVat = const Value.absent(),
                Value<VatRate?> vatRate = const Value.absent(),
                Value<PurchaseVat> purchaseVat = const Value.absent(),
                Value<int> vatAmount = const Value.absent(),
                Value<bool> vatReclaimable = const Value.absent(),
                Value<int> vatToReclaim = const Value.absent(),
                Value<int> residualValue = const Value.absent(),
                Value<DateTime> purchaseDate = const Value.absent(),
                Value<double> businessUsePct = const Value.absent(),
                Value<int> usefulLifeYears = const Value.absent(),
                Value<bool> kiaEligible = const Value.absent(),
                Value<bool> eiaEligible = const Value.absent(),
                Value<MiaCategory?> miaCategory = const Value.absent(),
                Value<int?> investmentDeductionReceived = const Value.absent(),
                Value<int> reinvestmentReserveApplied = const Value.absent(),
                Value<bool> reserveGain = const Value.absent(),
                Value<int?> catalogueValue = const Value.absent(),
                Value<DateTime?> firstRegistration = const Value.absent(),
                Value<ZeroEmission> zeroEmission = const Value.absent(),
                Value<int?> marketValue = const Value.absent(),
                Value<bool> keepsTripLog = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> disposalDate = const Value.absent(),
                Value<int?> disposalProceeds = const Value.absent(),
                Value<int?> disposalInvoiceId = const Value.absent(),
                Value<VatRate?> disposalVatRate = const Value.absent(),
                Value<int?> disposalVatAmount = const Value.absent(),
              }) => FixedAssetsCompanion(
                id: id,
                kind: kind,
                assetName: assetName,
                costExclVat: costExclVat,
                vatRate: vatRate,
                purchaseVat: purchaseVat,
                vatAmount: vatAmount,
                vatReclaimable: vatReclaimable,
                vatToReclaim: vatToReclaim,
                residualValue: residualValue,
                purchaseDate: purchaseDate,
                businessUsePct: businessUsePct,
                usefulLifeYears: usefulLifeYears,
                kiaEligible: kiaEligible,
                eiaEligible: eiaEligible,
                miaCategory: miaCategory,
                investmentDeductionReceived: investmentDeductionReceived,
                reinvestmentReserveApplied: reinvestmentReserveApplied,
                reserveGain: reserveGain,
                catalogueValue: catalogueValue,
                firstRegistration: firstRegistration,
                zeroEmission: zeroEmission,
                marketValue: marketValue,
                keepsTripLog: keepsTripLog,
                notes: notes,
                disposalDate: disposalDate,
                disposalProceeds: disposalProceeds,
                disposalInvoiceId: disposalInvoiceId,
                disposalVatRate: disposalVatRate,
                disposalVatAmount: disposalVatAmount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<AssetKind> kind = const Value.absent(),
                required String assetName,
                required int costExclVat,
                Value<VatRate?> vatRate = const Value.absent(),
                Value<PurchaseVat> purchaseVat = const Value.absent(),
                Value<int> vatAmount = const Value.absent(),
                Value<bool> vatReclaimable = const Value.absent(),
                Value<int> vatToReclaim = const Value.absent(),
                required int residualValue,
                required DateTime purchaseDate,
                required double businessUsePct,
                required int usefulLifeYears,
                Value<bool> kiaEligible = const Value.absent(),
                Value<bool> eiaEligible = const Value.absent(),
                Value<MiaCategory?> miaCategory = const Value.absent(),
                Value<int?> investmentDeductionReceived = const Value.absent(),
                Value<int> reinvestmentReserveApplied = const Value.absent(),
                Value<bool> reserveGain = const Value.absent(),
                Value<int?> catalogueValue = const Value.absent(),
                Value<DateTime?> firstRegistration = const Value.absent(),
                Value<ZeroEmission> zeroEmission = const Value.absent(),
                Value<int?> marketValue = const Value.absent(),
                Value<bool> keepsTripLog = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> disposalDate = const Value.absent(),
                Value<int?> disposalProceeds = const Value.absent(),
                Value<int?> disposalInvoiceId = const Value.absent(),
                Value<VatRate?> disposalVatRate = const Value.absent(),
                Value<int?> disposalVatAmount = const Value.absent(),
              }) => FixedAssetsCompanion.insert(
                id: id,
                kind: kind,
                assetName: assetName,
                costExclVat: costExclVat,
                vatRate: vatRate,
                purchaseVat: purchaseVat,
                vatAmount: vatAmount,
                vatReclaimable: vatReclaimable,
                vatToReclaim: vatToReclaim,
                residualValue: residualValue,
                purchaseDate: purchaseDate,
                businessUsePct: businessUsePct,
                usefulLifeYears: usefulLifeYears,
                kiaEligible: kiaEligible,
                eiaEligible: eiaEligible,
                miaCategory: miaCategory,
                investmentDeductionReceived: investmentDeductionReceived,
                reinvestmentReserveApplied: reinvestmentReserveApplied,
                reserveGain: reserveGain,
                catalogueValue: catalogueValue,
                firstRegistration: firstRegistration,
                zeroEmission: zeroEmission,
                marketValue: marketValue,
                keepsTripLog: keepsTripLog,
                notes: notes,
                disposalDate: disposalDate,
                disposalProceeds: disposalProceeds,
                disposalInvoiceId: disposalInvoiceId,
                disposalVatRate: disposalVatRate,
                disposalVatAmount: disposalVatAmount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FixedAssetsTable, FixedAsset>(table),
                  $$FixedAssetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                disposalInvoiceId = false,
                expensesRefs = false,
                mileageTripsRefs = false,
                receiptsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (expensesRefs) db.expenses,
                    if (mileageTripsRefs) db.mileageTrips,
                    if (receiptsRefs) db.receipts,
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
                        if (disposalInvoiceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.disposalInvoiceId,
                                    referencedTable:
                                        $$FixedAssetsTableReferences
                                            ._disposalInvoiceIdTable(db),
                                    referencedColumn:
                                        $$FixedAssetsTableReferences
                                            ._disposalInvoiceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (expensesRefs)
                        await $_getPrefetchedDataByColumns<
                          FixedAsset,
                          $FixedAssetsTable,
                          Expense,
                          $ExpensesTable
                        >(
                          currentTable: table,
                          referencedTable: $$FixedAssetsTableReferences
                              ._expensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FixedAssetsTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'car_asset_id',
                          typedResults: items,
                        ),
                      if (mileageTripsRefs)
                        await $_getPrefetchedDataByColumns<
                          FixedAsset,
                          $FixedAssetsTable,
                          MileageTrip,
                          $MileageTripsTable
                        >(
                          currentTable: table,
                          referencedTable: $$FixedAssetsTableReferences
                              ._mileageTripsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FixedAssetsTableReferences(
                                db,
                                table,
                                p0,
                              ).mileageTripsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'car_asset_id',
                          typedResults: items,
                        ),
                      if (receiptsRefs)
                        await $_getPrefetchedDataByColumns<
                          FixedAsset,
                          $FixedAssetsTable,
                          Receipt,
                          $ReceiptsTable
                        >(
                          currentTable: table,
                          referencedTable: $$FixedAssetsTableReferences
                              ._receiptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FixedAssetsTableReferences(
                                db,
                                table,
                                p0,
                              ).receiptsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'asset_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
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
      (FixedAsset, $$FixedAssetsTableReferences),
      FixedAsset,
      PrefetchHooks Function({
        bool disposalInvoiceId,
        bool expensesRefs,
        bool mileageTripsRefs,
        bool receiptsRefs,
      })
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      required DateTime date,
      required String supplier,
      required String description,
      required ExpenseCategory category,
      Value<bool> paperOriginalKept,
      required int amountExclVat,
      required VatRate vatRate,
      Value<PurchaseVat> purchaseVat,
      required int vatAmount,
      required int totalInclVat,
      required double businessUsePct,
      required int deductibleAmount,
      required bool vatReclaimable,
      required int vatToReclaim,
      Value<String?> notes,
      Value<String?> paidFrom,
      Value<String?> paymentReference,
      Value<int?> carAssetId,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> supplier,
      Value<String> description,
      Value<ExpenseCategory> category,
      Value<bool> paperOriginalKept,
      Value<int> amountExclVat,
      Value<VatRate> vatRate,
      Value<PurchaseVat> purchaseVat,
      Value<int> vatAmount,
      Value<int> totalInclVat,
      Value<double> businessUsePct,
      Value<int> deductibleAmount,
      Value<bool> vatReclaimable,
      Value<int> vatToReclaim,
      Value<String?> notes,
      Value<String?> paidFrom,
      Value<String?> paymentReference,
      Value<int?> carAssetId,
    });

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FixedAssetsTable _carAssetIdTable(_$AppDatabase db) =>
      db.fixedAssets.createAlias('expenses__car_asset_id__fixed_assets__id');

  $$FixedAssetsTableProcessedTableManager? get carAssetId {
    final $_column = $_itemColumn<int>('car_asset_id');
    if ($_column == null) return null;
    final manager = $$FixedAssetsTableTableManager(
      $_db,
      $_db.fixedAssets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_carAssetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReceiptsTable, List<Receipt>> _receiptsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.receipts,
    aliasName: 'expenses__id__receipts__expense_id',
  );

  $$ReceiptsTableProcessedTableManager get receiptsRefs {
    final manager = $$ReceiptsTableTableManager(
      $_db,
      $_db.receipts,
    ).filter((f) => f.expenseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_receiptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnWithTypeConverterFilters<ExpenseCategory, ExpenseCategory, String>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get paperOriginalKept => $composableBuilder(
    column: $table.paperOriginalKept,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountExclVat => $composableBuilder(
    column: $table.amountExclVat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VatRate, VatRate, String> get vatRate =>
      $composableBuilder(
        column: $table.vatRate,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<PurchaseVat, PurchaseVat, String>
  get purchaseVat => $composableBuilder(
    column: $table.purchaseVat,
    builder: (column) => ColumnWithTypeConverterFilters(column),
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

  $$FixedAssetsTableFilterComposer get carAssetId {
    final $$FixedAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carAssetId,
      referencedTable: $db.fixedAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixedAssetsTableFilterComposer(
            $db: $db,
            $table: $db.fixedAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> receiptsRefs(
    Expression<bool> Function($$ReceiptsTableFilterComposer f) f,
  ) {
    final $$ReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.expenseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  ColumnOrderings<bool> get paperOriginalKept => $composableBuilder(
    column: $table.paperOriginalKept,
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

  ColumnOrderings<String> get purchaseVat => $composableBuilder(
    column: $table.purchaseVat,
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

  $$FixedAssetsTableOrderingComposer get carAssetId {
    final $$FixedAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carAssetId,
      referencedTable: $db.fixedAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixedAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.fixedAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  GeneratedColumnWithTypeConverter<ExpenseCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get paperOriginalKept => $composableBuilder(
    column: $table.paperOriginalKept,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountExclVat => $composableBuilder(
    column: $table.amountExclVat,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<VatRate, String> get vatRate =>
      $composableBuilder(column: $table.vatRate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PurchaseVat, String> get purchaseVat =>
      $composableBuilder(
        column: $table.purchaseVat,
        builder: (column) => column,
      );

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

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get paidFrom =>
      $composableBuilder(column: $table.paidFrom, builder: (column) => column);

  GeneratedColumn<String> get paymentReference => $composableBuilder(
    column: $table.paymentReference,
    builder: (column) => column,
  );

  $$FixedAssetsTableAnnotationComposer get carAssetId {
    final $$FixedAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carAssetId,
      referencedTable: $db.fixedAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixedAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.fixedAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> receiptsRefs<T extends Object>(
    Expression<T> Function($$ReceiptsTableAnnotationComposer a) f,
  ) {
    final $$ReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.expenseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (Expense, $$ExpensesTableReferences),
          Expense,
          PrefetchHooks Function({bool carAssetId, bool receiptsRefs})
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
                Value<ExpenseCategory> category = const Value.absent(),
                Value<bool> paperOriginalKept = const Value.absent(),
                Value<int> amountExclVat = const Value.absent(),
                Value<VatRate> vatRate = const Value.absent(),
                Value<PurchaseVat> purchaseVat = const Value.absent(),
                Value<int> vatAmount = const Value.absent(),
                Value<int> totalInclVat = const Value.absent(),
                Value<double> businessUsePct = const Value.absent(),
                Value<int> deductibleAmount = const Value.absent(),
                Value<bool> vatReclaimable = const Value.absent(),
                Value<int> vatToReclaim = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> paidFrom = const Value.absent(),
                Value<String?> paymentReference = const Value.absent(),
                Value<int?> carAssetId = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                date: date,
                supplier: supplier,
                description: description,
                category: category,
                paperOriginalKept: paperOriginalKept,
                amountExclVat: amountExclVat,
                vatRate: vatRate,
                purchaseVat: purchaseVat,
                vatAmount: vatAmount,
                totalInclVat: totalInclVat,
                businessUsePct: businessUsePct,
                deductibleAmount: deductibleAmount,
                vatReclaimable: vatReclaimable,
                vatToReclaim: vatToReclaim,
                notes: notes,
                paidFrom: paidFrom,
                paymentReference: paymentReference,
                carAssetId: carAssetId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String supplier,
                required String description,
                required ExpenseCategory category,
                Value<bool> paperOriginalKept = const Value.absent(),
                required int amountExclVat,
                required VatRate vatRate,
                Value<PurchaseVat> purchaseVat = const Value.absent(),
                required int vatAmount,
                required int totalInclVat,
                required double businessUsePct,
                required int deductibleAmount,
                required bool vatReclaimable,
                required int vatToReclaim,
                Value<String?> notes = const Value.absent(),
                Value<String?> paidFrom = const Value.absent(),
                Value<String?> paymentReference = const Value.absent(),
                Value<int?> carAssetId = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                date: date,
                supplier: supplier,
                description: description,
                category: category,
                paperOriginalKept: paperOriginalKept,
                amountExclVat: amountExclVat,
                vatRate: vatRate,
                purchaseVat: purchaseVat,
                vatAmount: vatAmount,
                totalInclVat: totalInclVat,
                businessUsePct: businessUsePct,
                deductibleAmount: deductibleAmount,
                vatReclaimable: vatReclaimable,
                vatToReclaim: vatToReclaim,
                notes: notes,
                paidFrom: paidFrom,
                paymentReference: paymentReference,
                carAssetId: carAssetId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExpensesTable, Expense>(table),
                  $$ExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({carAssetId = false, receiptsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (receiptsRefs) db.receipts],
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
                    if (carAssetId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.carAssetId,
                                referencedTable: $$ExpensesTableReferences
                                    ._carAssetIdTable(db),
                                referencedColumn: $$ExpensesTableReferences
                                    ._carAssetIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (receiptsRefs)
                    await $_getPrefetchedDataByColumns<
                      Expense,
                      $ExpensesTable,
                      Receipt,
                      $ReceiptsTable
                    >(
                      currentTable: table,
                      referencedTable: $$ExpensesTableReferences
                          ._receiptsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ExpensesTableReferences(db, table, p0).receiptsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'expense_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
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
      (Expense, $$ExpensesTableReferences),
      Expense,
      PrefetchHooks Function({bool carAssetId, bool receiptsRefs})
    >;
typedef $$HourEntriesTableCreateCompanionBuilder =
    HourEntriesCompanion Function({
      Value<int> id,
      required DateTime date,
      required String description,
      required WorkType workType,
      required double hours,
      Value<String?> clientProject,
      Value<String?> notes,
    });
typedef $$HourEntriesTableUpdateCompanionBuilder =
    HourEntriesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<String> description,
      Value<WorkType> workType,
      Value<double> hours,
      Value<String?> clientProject,
      Value<String?> notes,
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

  ColumnWithTypeConverterFilters<WorkType, WorkType, String> get workType =>
      $composableBuilder(
        column: $table.workType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get hours => $composableBuilder(
    column: $table.hours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientProject => $composableBuilder(
    column: $table.clientProject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
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

  ColumnOrderings<String> get clientProject => $composableBuilder(
    column: $table.clientProject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
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

  GeneratedColumnWithTypeConverter<WorkType, String> get workType =>
      $composableBuilder(column: $table.workType, builder: (column) => column);

  GeneratedColumn<double> get hours =>
      $composableBuilder(column: $table.hours, builder: (column) => column);

  GeneratedColumn<String> get clientProject => $composableBuilder(
    column: $table.clientProject,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
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
                Value<WorkType> workType = const Value.absent(),
                Value<double> hours = const Value.absent(),
                Value<String?> clientProject = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => HourEntriesCompanion(
                id: id,
                date: date,
                description: description,
                workType: workType,
                hours: hours,
                clientProject: clientProject,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String description,
                required WorkType workType,
                required double hours,
                Value<String?> clientProject = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => HourEntriesCompanion.insert(
                id: id,
                date: date,
                description: description,
                workType: workType,
                hours: hours,
                clientProject: clientProject,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HourEntriesTable, HourEntry>(table),
                  BaseReferences<_$AppDatabase, $HourEntriesTable, HourEntry>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
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
      Value<int?> carAssetId,
      required String vehicleMakeModel,
      required String vehicleLicensePlate,
      required String departureAddress,
      required String arrivalAddress,
      required int odometerStart,
      required int odometerEnd,
      required TripType tripType,
      required String purpose,
      Value<bool> routeDeviation,
      Value<String?> notes,
    });
typedef $$MileageTripsTableUpdateCompanionBuilder =
    MileageTripsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int?> carAssetId,
      Value<String> vehicleMakeModel,
      Value<String> vehicleLicensePlate,
      Value<String> departureAddress,
      Value<String> arrivalAddress,
      Value<int> odometerStart,
      Value<int> odometerEnd,
      Value<TripType> tripType,
      Value<String> purpose,
      Value<bool> routeDeviation,
      Value<String?> notes,
    });

final class $$MileageTripsTableReferences
    extends BaseReferences<_$AppDatabase, $MileageTripsTable, MileageTrip> {
  $$MileageTripsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FixedAssetsTable _carAssetIdTable(_$AppDatabase db) => db.fixedAssets
      .createAlias('mileage_trips__car_asset_id__fixed_assets__id');

  $$FixedAssetsTableProcessedTableManager? get carAssetId {
    final $_column = $_itemColumn<int>('car_asset_id');
    if ($_column == null) return null;
    final manager = $$FixedAssetsTableTableManager(
      $_db,
      $_db.fixedAssets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_carAssetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

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

  ColumnWithTypeConverterFilters<TripType, TripType, String> get tripType =>
      $composableBuilder(
        column: $table.tripType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
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

  $$FixedAssetsTableFilterComposer get carAssetId {
    final $$FixedAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carAssetId,
      referencedTable: $db.fixedAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixedAssetsTableFilterComposer(
            $db: $db,
            $table: $db.fixedAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  $$FixedAssetsTableOrderingComposer get carAssetId {
    final $$FixedAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carAssetId,
      referencedTable: $db.fixedAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixedAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.fixedAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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

  GeneratedColumnWithTypeConverter<TripType, String> get tripType =>
      $composableBuilder(column: $table.tripType, builder: (column) => column);

  GeneratedColumn<String> get purpose =>
      $composableBuilder(column: $table.purpose, builder: (column) => column);

  GeneratedColumn<bool> get routeDeviation => $composableBuilder(
    column: $table.routeDeviation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$FixedAssetsTableAnnotationComposer get carAssetId {
    final $$FixedAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carAssetId,
      referencedTable: $db.fixedAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixedAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.fixedAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
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
          (MileageTrip, $$MileageTripsTableReferences),
          MileageTrip,
          PrefetchHooks Function({bool carAssetId})
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
                Value<int?> carAssetId = const Value.absent(),
                Value<String> vehicleMakeModel = const Value.absent(),
                Value<String> vehicleLicensePlate = const Value.absent(),
                Value<String> departureAddress = const Value.absent(),
                Value<String> arrivalAddress = const Value.absent(),
                Value<int> odometerStart = const Value.absent(),
                Value<int> odometerEnd = const Value.absent(),
                Value<TripType> tripType = const Value.absent(),
                Value<String> purpose = const Value.absent(),
                Value<bool> routeDeviation = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MileageTripsCompanion(
                id: id,
                date: date,
                carAssetId: carAssetId,
                vehicleMakeModel: vehicleMakeModel,
                vehicleLicensePlate: vehicleLicensePlate,
                departureAddress: departureAddress,
                arrivalAddress: arrivalAddress,
                odometerStart: odometerStart,
                odometerEnd: odometerEnd,
                tripType: tripType,
                purpose: purpose,
                routeDeviation: routeDeviation,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                Value<int?> carAssetId = const Value.absent(),
                required String vehicleMakeModel,
                required String vehicleLicensePlate,
                required String departureAddress,
                required String arrivalAddress,
                required int odometerStart,
                required int odometerEnd,
                required TripType tripType,
                required String purpose,
                Value<bool> routeDeviation = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => MileageTripsCompanion.insert(
                id: id,
                date: date,
                carAssetId: carAssetId,
                vehicleMakeModel: vehicleMakeModel,
                vehicleLicensePlate: vehicleLicensePlate,
                departureAddress: departureAddress,
                arrivalAddress: arrivalAddress,
                odometerStart: odometerStart,
                odometerEnd: odometerEnd,
                tripType: tripType,
                purpose: purpose,
                routeDeviation: routeDeviation,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MileageTripsTable, MileageTrip>(table),
                  $$MileageTripsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({carAssetId = false}) {
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
                    if (carAssetId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.carAssetId,
                                referencedTable: $$MileageTripsTableReferences
                                    ._carAssetIdTable(db),
                                referencedColumn: $$MileageTripsTableReferences
                                    ._carAssetIdTable(db)
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
      (MileageTrip, $$MileageTripsTableReferences),
      MileageTrip,
      PrefetchHooks Function({bool carAssetId})
    >;
typedef $$PensionEntriesTableCreateCompanionBuilder =
    PensionEntriesCompanion Function({
      Value<int> year,
      Value<int> priorYearIncome,
      Value<int> factorA,
      Value<int> reserveringsruimte,
      Value<int> plannedContribution,
      Value<bool> aovInsured,
      Value<int> monthlyAovPremium,
    });
typedef $$PensionEntriesTableUpdateCompanionBuilder =
    PensionEntriesCompanion Function({
      Value<int> year,
      Value<int> priorYearIncome,
      Value<int> factorA,
      Value<int> reserveringsruimte,
      Value<int> plannedContribution,
      Value<bool> aovInsured,
      Value<int> monthlyAovPremium,
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
  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priorYearIncome => $composableBuilder(
    column: $table.priorYearIncome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get factorA => $composableBuilder(
    column: $table.factorA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reserveringsruimte => $composableBuilder(
    column: $table.reserveringsruimte,
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
  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priorYearIncome => $composableBuilder(
    column: $table.priorYearIncome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get factorA => $composableBuilder(
    column: $table.factorA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reserveringsruimte => $composableBuilder(
    column: $table.reserveringsruimte,
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
  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get priorYearIncome => $composableBuilder(
    column: $table.priorYearIncome,
    builder: (column) => column,
  );

  GeneratedColumn<int> get factorA =>
      $composableBuilder(column: $table.factorA, builder: (column) => column);

  GeneratedColumn<int> get reserveringsruimte => $composableBuilder(
    column: $table.reserveringsruimte,
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
                Value<int> year = const Value.absent(),
                Value<int> priorYearIncome = const Value.absent(),
                Value<int> factorA = const Value.absent(),
                Value<int> reserveringsruimte = const Value.absent(),
                Value<int> plannedContribution = const Value.absent(),
                Value<bool> aovInsured = const Value.absent(),
                Value<int> monthlyAovPremium = const Value.absent(),
              }) => PensionEntriesCompanion(
                year: year,
                priorYearIncome: priorYearIncome,
                factorA: factorA,
                reserveringsruimte: reserveringsruimte,
                plannedContribution: plannedContribution,
                aovInsured: aovInsured,
                monthlyAovPremium: monthlyAovPremium,
              ),
          createCompanionCallback:
              ({
                Value<int> year = const Value.absent(),
                Value<int> priorYearIncome = const Value.absent(),
                Value<int> factorA = const Value.absent(),
                Value<int> reserveringsruimte = const Value.absent(),
                Value<int> plannedContribution = const Value.absent(),
                Value<bool> aovInsured = const Value.absent(),
                Value<int> monthlyAovPremium = const Value.absent(),
              }) => PensionEntriesCompanion.insert(
                year: year,
                priorYearIncome: priorYearIncome,
                factorA: factorA,
                reserveringsruimte: reserveringsruimte,
                plannedContribution: plannedContribution,
                aovInsured: aovInsured,
                monthlyAovPremium: monthlyAovPremium,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PensionEntriesTable, PensionEntry>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PensionEntriesTable,
                    PensionEntry
                  >(db, table, e),
                ),
              )
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
typedef $$VatReturnsTableCreateCompanionBuilder =
    VatReturnsCompanion Function({
      required int year,
      required int quarter,
      Value<bool> filed,
      Value<bool> paid,
      Value<int> rowid,
    });
typedef $$VatReturnsTableUpdateCompanionBuilder =
    VatReturnsCompanion Function({
      Value<int> year,
      Value<int> quarter,
      Value<bool> filed,
      Value<bool> paid,
      Value<int> rowid,
    });

class $$VatReturnsTableFilterComposer
    extends Composer<_$AppDatabase, $VatReturnsTable> {
  $$VatReturnsTableFilterComposer({
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

  ColumnFilters<int> get quarter => $composableBuilder(
    column: $table.quarter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get filed => $composableBuilder(
    column: $table.filed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get paid => $composableBuilder(
    column: $table.paid,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VatReturnsTableOrderingComposer
    extends Composer<_$AppDatabase, $VatReturnsTable> {
  $$VatReturnsTableOrderingComposer({
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

  ColumnOrderings<int> get quarter => $composableBuilder(
    column: $table.quarter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get filed => $composableBuilder(
    column: $table.filed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get paid => $composableBuilder(
    column: $table.paid,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VatReturnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VatReturnsTable> {
  $$VatReturnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get quarter =>
      $composableBuilder(column: $table.quarter, builder: (column) => column);

  GeneratedColumn<bool> get filed =>
      $composableBuilder(column: $table.filed, builder: (column) => column);

  GeneratedColumn<bool> get paid =>
      $composableBuilder(column: $table.paid, builder: (column) => column);
}

class $$VatReturnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VatReturnsTable,
          VatReturn,
          $$VatReturnsTableFilterComposer,
          $$VatReturnsTableOrderingComposer,
          $$VatReturnsTableAnnotationComposer,
          $$VatReturnsTableCreateCompanionBuilder,
          $$VatReturnsTableUpdateCompanionBuilder,
          (
            VatReturn,
            BaseReferences<_$AppDatabase, $VatReturnsTable, VatReturn>,
          ),
          VatReturn,
          PrefetchHooks Function()
        > {
  $$VatReturnsTableTableManager(_$AppDatabase db, $VatReturnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VatReturnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VatReturnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VatReturnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> year = const Value.absent(),
                Value<int> quarter = const Value.absent(),
                Value<bool> filed = const Value.absent(),
                Value<bool> paid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VatReturnsCompanion(
                year: year,
                quarter: quarter,
                filed: filed,
                paid: paid,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int year,
                required int quarter,
                Value<bool> filed = const Value.absent(),
                Value<bool> paid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VatReturnsCompanion.insert(
                year: year,
                quarter: quarter,
                filed: filed,
                paid: paid,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VatReturnsTable, VatReturn>(table),
                  BaseReferences<_$AppDatabase, $VatReturnsTable, VatReturn>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VatReturnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VatReturnsTable,
      VatReturn,
      $$VatReturnsTableFilterComposer,
      $$VatReturnsTableOrderingComposer,
      $$VatReturnsTableAnnotationComposer,
      $$VatReturnsTableCreateCompanionBuilder,
      $$VatReturnsTableUpdateCompanionBuilder,
      (VatReturn, BaseReferences<_$AppDatabase, $VatReturnsTable, VatReturn>),
      VatReturn,
      PrefetchHooks Function()
    >;
typedef $$TaxYearInputsTableCreateCompanionBuilder =
    TaxYearInputsCompanion Function({
      Value<int> year,
      Value<int> partnerHours,
      Value<bool> hasSoVerklaring,
      Value<bool> soStarter,
      Value<bool> businessCeased,
      Value<int> stakingsaftrekUsedBefore,
      Value<bool> disabilityBenefit,
      Value<int> disabilityStartersUsed,
      Value<int> unrealisedZelfstandigenaftrek,
      Value<int> lossCarryForward,
    });
typedef $$TaxYearInputsTableUpdateCompanionBuilder =
    TaxYearInputsCompanion Function({
      Value<int> year,
      Value<int> partnerHours,
      Value<bool> hasSoVerklaring,
      Value<bool> soStarter,
      Value<bool> businessCeased,
      Value<int> stakingsaftrekUsedBefore,
      Value<bool> disabilityBenefit,
      Value<int> disabilityStartersUsed,
      Value<int> unrealisedZelfstandigenaftrek,
      Value<int> lossCarryForward,
    });

class $$TaxYearInputsTableFilterComposer
    extends Composer<_$AppDatabase, $TaxYearInputsTable> {
  $$TaxYearInputsTableFilterComposer({
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

  ColumnFilters<int> get partnerHours => $composableBuilder(
    column: $table.partnerHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasSoVerklaring => $composableBuilder(
    column: $table.hasSoVerklaring,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get soStarter => $composableBuilder(
    column: $table.soStarter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get businessCeased => $composableBuilder(
    column: $table.businessCeased,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stakingsaftrekUsedBefore => $composableBuilder(
    column: $table.stakingsaftrekUsedBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get disabilityBenefit => $composableBuilder(
    column: $table.disabilityBenefit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get disabilityStartersUsed => $composableBuilder(
    column: $table.disabilityStartersUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unrealisedZelfstandigenaftrek => $composableBuilder(
    column: $table.unrealisedZelfstandigenaftrek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lossCarryForward => $composableBuilder(
    column: $table.lossCarryForward,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TaxYearInputsTableOrderingComposer
    extends Composer<_$AppDatabase, $TaxYearInputsTable> {
  $$TaxYearInputsTableOrderingComposer({
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

  ColumnOrderings<int> get partnerHours => $composableBuilder(
    column: $table.partnerHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasSoVerklaring => $composableBuilder(
    column: $table.hasSoVerklaring,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get soStarter => $composableBuilder(
    column: $table.soStarter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get businessCeased => $composableBuilder(
    column: $table.businessCeased,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stakingsaftrekUsedBefore => $composableBuilder(
    column: $table.stakingsaftrekUsedBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get disabilityBenefit => $composableBuilder(
    column: $table.disabilityBenefit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get disabilityStartersUsed => $composableBuilder(
    column: $table.disabilityStartersUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unrealisedZelfstandigenaftrek => $composableBuilder(
    column: $table.unrealisedZelfstandigenaftrek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lossCarryForward => $composableBuilder(
    column: $table.lossCarryForward,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TaxYearInputsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaxYearInputsTable> {
  $$TaxYearInputsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get partnerHours => $composableBuilder(
    column: $table.partnerHours,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasSoVerklaring => $composableBuilder(
    column: $table.hasSoVerklaring,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get soStarter =>
      $composableBuilder(column: $table.soStarter, builder: (column) => column);

  GeneratedColumn<bool> get businessCeased => $composableBuilder(
    column: $table.businessCeased,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stakingsaftrekUsedBefore => $composableBuilder(
    column: $table.stakingsaftrekUsedBefore,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get disabilityBenefit => $composableBuilder(
    column: $table.disabilityBenefit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get disabilityStartersUsed => $composableBuilder(
    column: $table.disabilityStartersUsed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unrealisedZelfstandigenaftrek => $composableBuilder(
    column: $table.unrealisedZelfstandigenaftrek,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lossCarryForward => $composableBuilder(
    column: $table.lossCarryForward,
    builder: (column) => column,
  );
}

class $$TaxYearInputsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaxYearInputsTable,
          TaxYearInput,
          $$TaxYearInputsTableFilterComposer,
          $$TaxYearInputsTableOrderingComposer,
          $$TaxYearInputsTableAnnotationComposer,
          $$TaxYearInputsTableCreateCompanionBuilder,
          $$TaxYearInputsTableUpdateCompanionBuilder,
          (
            TaxYearInput,
            BaseReferences<_$AppDatabase, $TaxYearInputsTable, TaxYearInput>,
          ),
          TaxYearInput,
          PrefetchHooks Function()
        > {
  $$TaxYearInputsTableTableManager(_$AppDatabase db, $TaxYearInputsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaxYearInputsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaxYearInputsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaxYearInputsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> year = const Value.absent(),
                Value<int> partnerHours = const Value.absent(),
                Value<bool> hasSoVerklaring = const Value.absent(),
                Value<bool> soStarter = const Value.absent(),
                Value<bool> businessCeased = const Value.absent(),
                Value<int> stakingsaftrekUsedBefore = const Value.absent(),
                Value<bool> disabilityBenefit = const Value.absent(),
                Value<int> disabilityStartersUsed = const Value.absent(),
                Value<int> unrealisedZelfstandigenaftrek = const Value.absent(),
                Value<int> lossCarryForward = const Value.absent(),
              }) => TaxYearInputsCompanion(
                year: year,
                partnerHours: partnerHours,
                hasSoVerklaring: hasSoVerklaring,
                soStarter: soStarter,
                businessCeased: businessCeased,
                stakingsaftrekUsedBefore: stakingsaftrekUsedBefore,
                disabilityBenefit: disabilityBenefit,
                disabilityStartersUsed: disabilityStartersUsed,
                unrealisedZelfstandigenaftrek: unrealisedZelfstandigenaftrek,
                lossCarryForward: lossCarryForward,
              ),
          createCompanionCallback:
              ({
                Value<int> year = const Value.absent(),
                Value<int> partnerHours = const Value.absent(),
                Value<bool> hasSoVerklaring = const Value.absent(),
                Value<bool> soStarter = const Value.absent(),
                Value<bool> businessCeased = const Value.absent(),
                Value<int> stakingsaftrekUsedBefore = const Value.absent(),
                Value<bool> disabilityBenefit = const Value.absent(),
                Value<int> disabilityStartersUsed = const Value.absent(),
                Value<int> unrealisedZelfstandigenaftrek = const Value.absent(),
                Value<int> lossCarryForward = const Value.absent(),
              }) => TaxYearInputsCompanion.insert(
                year: year,
                partnerHours: partnerHours,
                hasSoVerklaring: hasSoVerklaring,
                soStarter: soStarter,
                businessCeased: businessCeased,
                stakingsaftrekUsedBefore: stakingsaftrekUsedBefore,
                disabilityBenefit: disabilityBenefit,
                disabilityStartersUsed: disabilityStartersUsed,
                unrealisedZelfstandigenaftrek: unrealisedZelfstandigenaftrek,
                lossCarryForward: lossCarryForward,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TaxYearInputsTable, TaxYearInput>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TaxYearInputsTable,
                    TaxYearInput
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TaxYearInputsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaxYearInputsTable,
      TaxYearInput,
      $$TaxYearInputsTableFilterComposer,
      $$TaxYearInputsTableOrderingComposer,
      $$TaxYearInputsTableAnnotationComposer,
      $$TaxYearInputsTableCreateCompanionBuilder,
      $$TaxYearInputsTableUpdateCompanionBuilder,
      (
        TaxYearInput,
        BaseReferences<_$AppDatabase, $TaxYearInputsTable, TaxYearInput>,
      ),
      TaxYearInput,
      PrefetchHooks Function()
    >;
typedef $$ReceiptsTableCreateCompanionBuilder =
    ReceiptsCompanion Function({
      required String id,
      Value<int?> expenseId,
      Value<int?> assetId,
      Value<int?> invoiceId,
      required int year,
      required ReceiptType type,
      required String originalName,
      required int sizeBytes,
      required String sha256,
      required DateTime addedAt,
      Value<DateTime?> removedAt,
      Value<ReceiptOwnerKind?> removedFromKind,
      Value<DateTime?> removedFromDate,
      Value<String?> removedFromName,
      Value<int> rowid,
    });
typedef $$ReceiptsTableUpdateCompanionBuilder =
    ReceiptsCompanion Function({
      Value<String> id,
      Value<int?> expenseId,
      Value<int?> assetId,
      Value<int?> invoiceId,
      Value<int> year,
      Value<ReceiptType> type,
      Value<String> originalName,
      Value<int> sizeBytes,
      Value<String> sha256,
      Value<DateTime> addedAt,
      Value<DateTime?> removedAt,
      Value<ReceiptOwnerKind?> removedFromKind,
      Value<DateTime?> removedFromDate,
      Value<String?> removedFromName,
      Value<int> rowid,
    });

final class $$ReceiptsTableReferences
    extends BaseReferences<_$AppDatabase, $ReceiptsTable, Receipt> {
  $$ReceiptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExpensesTable _expenseIdTable(_$AppDatabase db) =>
      db.expenses.createAlias('receipts__expense_id__expenses__id');

  $$ExpensesTableProcessedTableManager? get expenseId {
    final $_column = $_itemColumn<int>('expense_id');
    if ($_column == null) return null;
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_expenseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FixedAssetsTable _assetIdTable(_$AppDatabase db) =>
      db.fixedAssets.createAlias('receipts__asset_id__fixed_assets__id');

  $$FixedAssetsTableProcessedTableManager? get assetId {
    final $_column = $_itemColumn<int>('asset_id');
    if ($_column == null) return null;
    final manager = $$FixedAssetsTableTableManager(
      $_db,
      $_db.fixedAssets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('receipts__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager? get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id');
    if ($_column == null) return null;
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

class $$ReceiptsTableFilterComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReceiptType, ReceiptType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get removedAt => $composableBuilder(
    column: $table.removedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReceiptOwnerKind?, ReceiptOwnerKind, String>
  get removedFromKind => $composableBuilder(
    column: $table.removedFromKind,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get removedFromDate => $composableBuilder(
    column: $table.removedFromDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get removedFromName => $composableBuilder(
    column: $table.removedFromName,
    builder: (column) => ColumnFilters(column),
  );

  $$ExpensesTableFilterComposer get expenseId {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FixedAssetsTableFilterComposer get assetId {
    final $$FixedAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assetId,
      referencedTable: $db.fixedAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixedAssetsTableFilterComposer(
            $db: $db,
            $table: $db.fixedAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$ReceiptsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get removedAt => $composableBuilder(
    column: $table.removedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get removedFromKind => $composableBuilder(
    column: $table.removedFromKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get removedFromDate => $composableBuilder(
    column: $table.removedFromDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get removedFromName => $composableBuilder(
    column: $table.removedFromName,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExpensesTableOrderingComposer get expenseId {
    final $$ExpensesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableOrderingComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FixedAssetsTableOrderingComposer get assetId {
    final $$FixedAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assetId,
      referencedTable: $db.fixedAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixedAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.fixedAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$ReceiptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReceiptType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get removedAt =>
      $composableBuilder(column: $table.removedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReceiptOwnerKind?, String>
  get removedFromKind => $composableBuilder(
    column: $table.removedFromKind,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get removedFromDate => $composableBuilder(
    column: $table.removedFromDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get removedFromName => $composableBuilder(
    column: $table.removedFromName,
    builder: (column) => column,
  );

  $$ExpensesTableAnnotationComposer get expenseId {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FixedAssetsTableAnnotationComposer get assetId {
    final $$FixedAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assetId,
      referencedTable: $db.fixedAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixedAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.fixedAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$ReceiptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReceiptsTable,
          Receipt,
          $$ReceiptsTableFilterComposer,
          $$ReceiptsTableOrderingComposer,
          $$ReceiptsTableAnnotationComposer,
          $$ReceiptsTableCreateCompanionBuilder,
          $$ReceiptsTableUpdateCompanionBuilder,
          (Receipt, $$ReceiptsTableReferences),
          Receipt,
          PrefetchHooks Function({bool expenseId, bool assetId, bool invoiceId})
        > {
  $$ReceiptsTableTableManager(_$AppDatabase db, $ReceiptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int?> expenseId = const Value.absent(),
                Value<int?> assetId = const Value.absent(),
                Value<int?> invoiceId = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<ReceiptType> type = const Value.absent(),
                Value<String> originalName = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<DateTime?> removedAt = const Value.absent(),
                Value<ReceiptOwnerKind?> removedFromKind = const Value.absent(),
                Value<DateTime?> removedFromDate = const Value.absent(),
                Value<String?> removedFromName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion(
                id: id,
                expenseId: expenseId,
                assetId: assetId,
                invoiceId: invoiceId,
                year: year,
                type: type,
                originalName: originalName,
                sizeBytes: sizeBytes,
                sha256: sha256,
                addedAt: addedAt,
                removedAt: removedAt,
                removedFromKind: removedFromKind,
                removedFromDate: removedFromDate,
                removedFromName: removedFromName,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int?> expenseId = const Value.absent(),
                Value<int?> assetId = const Value.absent(),
                Value<int?> invoiceId = const Value.absent(),
                required int year,
                required ReceiptType type,
                required String originalName,
                required int sizeBytes,
                required String sha256,
                required DateTime addedAt,
                Value<DateTime?> removedAt = const Value.absent(),
                Value<ReceiptOwnerKind?> removedFromKind = const Value.absent(),
                Value<DateTime?> removedFromDate = const Value.absent(),
                Value<String?> removedFromName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion.insert(
                id: id,
                expenseId: expenseId,
                assetId: assetId,
                invoiceId: invoiceId,
                year: year,
                type: type,
                originalName: originalName,
                sizeBytes: sizeBytes,
                sha256: sha256,
                addedAt: addedAt,
                removedAt: removedAt,
                removedFromKind: removedFromKind,
                removedFromDate: removedFromDate,
                removedFromName: removedFromName,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReceiptsTable, Receipt>(table),
                  $$ReceiptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({expenseId = false, assetId = false, invoiceId = false}) {
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
                        if (expenseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.expenseId,
                                    referencedTable: $$ReceiptsTableReferences
                                        ._expenseIdTable(db),
                                    referencedColumn: $$ReceiptsTableReferences
                                        ._expenseIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (assetId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.assetId,
                                    referencedTable: $$ReceiptsTableReferences
                                        ._assetIdTable(db),
                                    referencedColumn: $$ReceiptsTableReferences
                                        ._assetIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (invoiceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.invoiceId,
                                    referencedTable: $$ReceiptsTableReferences
                                        ._invoiceIdTable(db),
                                    referencedColumn: $$ReceiptsTableReferences
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

typedef $$ReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReceiptsTable,
      Receipt,
      $$ReceiptsTableFilterComposer,
      $$ReceiptsTableOrderingComposer,
      $$ReceiptsTableAnnotationComposer,
      $$ReceiptsTableCreateCompanionBuilder,
      $$ReceiptsTableUpdateCompanionBuilder,
      (Receipt, $$ReceiptsTableReferences),
      Receipt,
      PrefetchHooks Function({bool expenseId, bool assetId, bool invoiceId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BusinessProfilesTableTableManager get businessProfiles =>
      $$BusinessProfilesTableTableManager(_db, _db.businessProfiles);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$InvoiceLinesTableTableManager get invoiceLines =>
      $$InvoiceLinesTableTableManager(_db, _db.invoiceLines);
  $$FixedAssetsTableTableManager get fixedAssets =>
      $$FixedAssetsTableTableManager(_db, _db.fixedAssets);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$HourEntriesTableTableManager get hourEntries =>
      $$HourEntriesTableTableManager(_db, _db.hourEntries);
  $$MileageTripsTableTableManager get mileageTrips =>
      $$MileageTripsTableTableManager(_db, _db.mileageTrips);
  $$PensionEntriesTableTableManager get pensionEntries =>
      $$PensionEntriesTableTableManager(_db, _db.pensionEntries);
  $$VatReturnsTableTableManager get vatReturns =>
      $$VatReturnsTableTableManager(_db, _db.vatReturns);
  $$TaxYearInputsTableTableManager get taxYearInputs =>
      $$TaxYearInputsTableTableManager(_db, _db.taxYearInputs);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db, _db.receipts);
}
