import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:drift/drift.dart';
import 'package:nostr_client/nostr_client.dart';
import 'package:crypto/crypto.dart';
import 'package:bip340/bip340.dart' as bip340;
import 'package:oo8/utils.dart';

import 'main.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'shared.g.dart';

// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".
class Events extends Table {
  IntColumn get i => integer().autoIncrement()();
  TextColumn get id => text().unique()();
  TextColumn get pubkey => text()();
  IntColumn get createdAt => integer()();
  IntColumn get syncAt => integer()();
  IntColumn get kind => integer()();
  //TextColumn get tags => text()();
  TextColumn get content => text()();
  TextColumn get sig => text()();

  static Future<int> save(Map<String, dynamic> m) async =>
      await db.into(db.events).insert(
            make(m),
          );

  static EventsCompanion make(Map<String, dynamic> m) => EventsCompanion.insert(
        id: m['id'],
        createdAt: m['created_at'],
        kind: m['kind'],
        //tags: m['tags'],
        syncAt: m['syncAt'],
        content: m['content'],
        pubkey: m['pubkey'],
        sig: m['sig'],
      );

  static var lastSyncAt = 0;
  static Future<int> lastSync() async {
    //highest last sync
    final r = await (db.select(db.events)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.syncAt,
                  mode: OrderingMode.desc,
                )
          ])
          ..limit(1))
        .getSingleOrNull();
    lastSyncAt = r?.syncAt ?? 0;
    return lastSyncAt;
  }

  //update to synched
  static Future<int> synched() async {
    final now = DateTime.now(), nowSeconds = now.millisecondsSinceEpoch ~/ 1000;
    final r = await (db.update(db.events)..where((tbl) => tbl.syncAt.equals(0)))
        .write(EventsCompanion(syncAt: Value(nowSeconds)));
    return r;
  }

  static Future<int> store(Map<String, dynamic> m) async {
    final r = await (db.select(db.events)
          ..where((tbl) => tbl.id.equals(m['id'])))
        .get();

    if (r.isNotEmpty) return 0;

    final now = DateTime.now();
    m['syncAt'] = now.millisecondsSinceEpoch ~/ 1000;

    final re = await db.into(db.events).insert(
          make(m),
        );
    return re;
  }
}

@DriftDatabase(tables: [Events])
class SharedDatabase extends _$SharedDatabase {
  //MyDatabase() : super(_openConnection());
  SharedDatabase(QueryExecutor e) : super(e);

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        await customStatement('PRAGMA foreign_keys = OFF');

        if (from < 2) {
          //await m.addColumn(events, events.syncAt);
        }
      },
      beforeOpen: (details) async {
        if (details.wasCreated) {
        } else {
          //recreate
          if (false) {
            final m = Migrator(this);
            for (final table in allTables) {
              await m.deleteTable(table.actualTableName);
              await m.createTable(table);
            }
          }
        }
        await customStatement('PRAGMA foreign_keys = ON');
        // ....
      },
    );
  }
}

/*
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder

    print(FIO.documentsPath);
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();

    final file = File(
      path.join(dbFolder.path, 'db.sqlite'),
    );

    //file.deleteSync();

    return NativeDatabase(file, logStatements: true);
  });
}
*/
