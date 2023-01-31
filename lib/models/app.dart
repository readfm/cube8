import 'dart:convert';

import 'package:nostr_client/nostr_client.dart' hide Event, Relay;
import 'package:oo8/models/repo.dart';
import 'package:oo8/models/user.dart';
import '../relay.dart';

import 'package:oo8/utils.dart';
import 'package:crypto/crypto.dart';
import 'package:bip340/bip340.dart' as bip340;
import '../db/main.dart';
import '../db/shared.dart';
import 'package:convert/convert.dart';

class Oo8Fractal {
  late final UserNostr user;

  final events = <Event>[];

  static final host = 'io.cx:8080';

  late Relay relay;

  Oo8Fractal() {
    //String host = 'localhost:8080';
//        Uri.base.authority.isEmpty ? 'localhost:8080' : Uri.base.authority;

    relay = Relay('ws://$host', onReady: () {
      synch();
    });
    user = UserNostr();
    _listen();
  }

  /*
  final listeners = <Function>[];
  listen(Function(Event) fb) {
    listeners.add(fb);
  }
  */

  _listen() async {
    final lastSyncAt = await Events.lastSync();
    relay.stream.listen((Message m) {
      if (m.isEvent) {
        //m[2]['createdAt'] = m[2]['created_at'];
        final event = Events.store(m[2]);
        //events.insert(0, event);
        //listeners.forEach((fb) => fb(event));
      }
    });
    relay.req(
      Filter(
        since: lastSyncAt > 0
            ? DateTime.fromMillisecondsSinceEpoch(lastSyncAt * 1000)
            : null,
      ),
    );
  }

  Map<String, dynamic> make(String val) {
    final now = DateTime.now(), nowSeconds = now.millisecondsSinceEpoch ~/ 1000;
    final kind = 1;
    final tags = <List<String>>[];
    final key = user.keyPair.publicKey.toLowerCase();

    List data = [0, key, nowSeconds, kind, tags, val];
    String serializedEvent = json.encode(data);
    List<int> hash = sha256.convert(utf8.encode(serializedEvent)).bytes;
    final id = hex.encode(hash);

    final sig = Signer().sign(privateKey: user.keyPair.privateKey, message: id);

    final map = {
      'id': id,
      'pubkey': key,
      'created_at': nowSeconds,
      'kind': kind,
      'tags': tags,
      'content': val,
      'sig': sig,
    };
    return map;
  }

  void search(String term) {
    //repo.relay.req(Filter());
  }

  synch() {
    if (relay.isConnected) {
      (db.select(db.events)..where((tbl) => tbl.syncAt.equals(0)))
          .get()
          .then((rows) {
        rows.forEach((row) {
          final m = row.toJson();
          m.remove('syncAt');
          m.remove('i');
          m['created_at'] = m['createdAt'];
          m['tags'] = [];
          m.remove('createdAt');
          relay.send(m);
        });

        if (rows.isNotEmpty) Events.synched();
      });
    }
  }

  void post(String val) async {
    final event = make(val);
    if (relay.isConnected) {
      relay.send(event);
    }
    event['syncAt'] =
        relay.isConnected ? DateTime.now().millisecondsSinceEpoch ~/ 1000 : 0;

    await Events.save(event);
  }
}
