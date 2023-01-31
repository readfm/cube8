import 'package:nostr_client/nostr_client.dart';
import 'package:dio/dio.dart';

import 'app.dart';

class UserNostr {
  late KeyPair keyPair;

  static final dio = Dio();

  UserNostr() {
    keyPair = RandomKeyPairGenerator().generate();
    // upload key pair to server

    storeKey();

    // download key pair from server
  }

  storeKey() async {
    final r = await dio.put('http://${Oo8Fractal.host}/nostr.key',
        data: keyPair.toJson());
    print(r);
  }
}
