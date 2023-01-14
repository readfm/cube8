import 'package:nostr_client/nostr_client.dart';
import 'package:oo8/models/repo.dart';
import 'package:oo8/models/user.dart';

import 'event.dart';

class Oo8Fractal {
  late final NostrFractal repo;
  late final UserNostr user;

  final events = <Event>[];

  Oo8Fractal() {
    String host =
        Uri.base.authority.isEmpty ? 'localhost:8080' : Uri.base.authority;
    repo = NostrFractal(host);
    user = UserNostr();
    _listen();
  }

  final listeners = <Function>[];
  listen(Function(Event) fb) {
    listeners.add(fb);
  }

  _listen() {
    repo.relay.stream.listen((Message m) {
      if (m.isEvent) {
        final event = Event.fromJson(m[2]);
        events.insert(0, event);
        listeners.forEach((fb) => fb(event));
      }
    });
    repo.relay.req(Filter());
  }

  void search(String term) {
    repo.relay.req(Filter());
  }

  EventFractal post(String val) {
    final event = EventFractal.create(val, keyPair: user.keyPair);
    repo.relay.send(event);
    return event;
  }
}
