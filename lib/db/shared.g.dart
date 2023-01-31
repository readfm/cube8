// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared.dart';

// ignore_for_file: type=lint
class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _iMeta = const VerificationMeta('i');
  @override
  late final GeneratedColumn<int> i = GeneratedColumn<int>(
      'i', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pubkeyMeta = const VerificationMeta('pubkey');
  @override
  late final GeneratedColumn<String> pubkey = GeneratedColumn<String>(
      'pubkey', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _syncAtMeta = const VerificationMeta('syncAt');
  @override
  late final GeneratedColumn<int> syncAt = GeneratedColumn<int>(
      'sync_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<int> kind = GeneratedColumn<int>(
      'kind', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sigMeta = const VerificationMeta('sig');
  @override
  late final GeneratedColumn<String> sig = GeneratedColumn<String>(
      'sig', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [i, id, pubkey, createdAt, syncAt, kind, content, sig];
  @override
  String get aliasedName => _alias ?? 'events';
  @override
  String get actualTableName => 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('i')) {
      context.handle(_iMeta, i.isAcceptableOrUnknown(data['i']!, _iMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pubkey')) {
      context.handle(_pubkeyMeta,
          pubkey.isAcceptableOrUnknown(data['pubkey']!, _pubkeyMeta));
    } else if (isInserting) {
      context.missing(_pubkeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sync_at')) {
      context.handle(_syncAtMeta,
          syncAt.isAcceptableOrUnknown(data['sync_at']!, _syncAtMeta));
    } else if (isInserting) {
      context.missing(_syncAtMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('sig')) {
      context.handle(
          _sigMeta, sig.isAcceptableOrUnknown(data['sig']!, _sigMeta));
    } else if (isInserting) {
      context.missing(_sigMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {i};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      i: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}i'])!,
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      pubkey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pubkey'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      syncAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sync_at'])!,
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kind'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      sig: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sig'])!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int i;
  final String id;
  final String pubkey;
  final int createdAt;
  final int syncAt;
  final int kind;
  final String content;
  final String sig;
  const Event(
      {required this.i,
      required this.id,
      required this.pubkey,
      required this.createdAt,
      required this.syncAt,
      required this.kind,
      required this.content,
      required this.sig});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['i'] = Variable<int>(i);
    map['id'] = Variable<String>(id);
    map['pubkey'] = Variable<String>(pubkey);
    map['created_at'] = Variable<int>(createdAt);
    map['sync_at'] = Variable<int>(syncAt);
    map['kind'] = Variable<int>(kind);
    map['content'] = Variable<String>(content);
    map['sig'] = Variable<String>(sig);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      i: Value(i),
      id: Value(id),
      pubkey: Value(pubkey),
      createdAt: Value(createdAt),
      syncAt: Value(syncAt),
      kind: Value(kind),
      content: Value(content),
      sig: Value(sig),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      i: serializer.fromJson<int>(json['i']),
      id: serializer.fromJson<String>(json['id']),
      pubkey: serializer.fromJson<String>(json['pubkey']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      syncAt: serializer.fromJson<int>(json['syncAt']),
      kind: serializer.fromJson<int>(json['kind']),
      content: serializer.fromJson<String>(json['content']),
      sig: serializer.fromJson<String>(json['sig']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'i': serializer.toJson<int>(i),
      'id': serializer.toJson<String>(id),
      'pubkey': serializer.toJson<String>(pubkey),
      'createdAt': serializer.toJson<int>(createdAt),
      'syncAt': serializer.toJson<int>(syncAt),
      'kind': serializer.toJson<int>(kind),
      'content': serializer.toJson<String>(content),
      'sig': serializer.toJson<String>(sig),
    };
  }

  Event copyWith(
          {int? i,
          String? id,
          String? pubkey,
          int? createdAt,
          int? syncAt,
          int? kind,
          String? content,
          String? sig}) =>
      Event(
        i: i ?? this.i,
        id: id ?? this.id,
        pubkey: pubkey ?? this.pubkey,
        createdAt: createdAt ?? this.createdAt,
        syncAt: syncAt ?? this.syncAt,
        kind: kind ?? this.kind,
        content: content ?? this.content,
        sig: sig ?? this.sig,
      );
  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('i: $i, ')
          ..write('id: $id, ')
          ..write('pubkey: $pubkey, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncAt: $syncAt, ')
          ..write('kind: $kind, ')
          ..write('content: $content, ')
          ..write('sig: $sig')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(i, id, pubkey, createdAt, syncAt, kind, content, sig);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.i == this.i &&
          other.id == this.id &&
          other.pubkey == this.pubkey &&
          other.createdAt == this.createdAt &&
          other.syncAt == this.syncAt &&
          other.kind == this.kind &&
          other.content == this.content &&
          other.sig == this.sig);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> i;
  final Value<String> id;
  final Value<String> pubkey;
  final Value<int> createdAt;
  final Value<int> syncAt;
  final Value<int> kind;
  final Value<String> content;
  final Value<String> sig;
  const EventsCompanion({
    this.i = const Value.absent(),
    this.id = const Value.absent(),
    this.pubkey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncAt = const Value.absent(),
    this.kind = const Value.absent(),
    this.content = const Value.absent(),
    this.sig = const Value.absent(),
  });
  EventsCompanion.insert({
    this.i = const Value.absent(),
    required String id,
    required String pubkey,
    required int createdAt,
    required int syncAt,
    required int kind,
    required String content,
    required String sig,
  })  : id = Value(id),
        pubkey = Value(pubkey),
        createdAt = Value(createdAt),
        syncAt = Value(syncAt),
        kind = Value(kind),
        content = Value(content),
        sig = Value(sig);
  static Insertable<Event> custom({
    Expression<int>? i,
    Expression<String>? id,
    Expression<String>? pubkey,
    Expression<int>? createdAt,
    Expression<int>? syncAt,
    Expression<int>? kind,
    Expression<String>? content,
    Expression<String>? sig,
  }) {
    return RawValuesInsertable({
      if (i != null) 'i': i,
      if (id != null) 'id': id,
      if (pubkey != null) 'pubkey': pubkey,
      if (createdAt != null) 'created_at': createdAt,
      if (syncAt != null) 'sync_at': syncAt,
      if (kind != null) 'kind': kind,
      if (content != null) 'content': content,
      if (sig != null) 'sig': sig,
    });
  }

  EventsCompanion copyWith(
      {Value<int>? i,
      Value<String>? id,
      Value<String>? pubkey,
      Value<int>? createdAt,
      Value<int>? syncAt,
      Value<int>? kind,
      Value<String>? content,
      Value<String>? sig}) {
    return EventsCompanion(
      i: i ?? this.i,
      id: id ?? this.id,
      pubkey: pubkey ?? this.pubkey,
      createdAt: createdAt ?? this.createdAt,
      syncAt: syncAt ?? this.syncAt,
      kind: kind ?? this.kind,
      content: content ?? this.content,
      sig: sig ?? this.sig,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (i.present) {
      map['i'] = Variable<int>(i.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pubkey.present) {
      map['pubkey'] = Variable<String>(pubkey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (syncAt.present) {
      map['sync_at'] = Variable<int>(syncAt.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(kind.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (sig.present) {
      map['sig'] = Variable<String>(sig.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('i: $i, ')
          ..write('id: $id, ')
          ..write('pubkey: $pubkey, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncAt: $syncAt, ')
          ..write('kind: $kind, ')
          ..write('content: $content, ')
          ..write('sig: $sig')
          ..write(')'))
        .toString();
  }
}

abstract class _$SharedDatabase extends GeneratedDatabase {
  _$SharedDatabase(QueryExecutor e) : super(e);
  late final $EventsTable events = $EventsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [events];
}
