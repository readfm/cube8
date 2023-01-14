import 'dart:convert';

import 'package:nostr_client/nostr_client.dart';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:bip340/bip340.dart' as bip340;

import '../utils.dart';

extension EventF on Event {
  String getEventId(String pubkey, createdAt, kind, tags, content) {
    List data = [0, pubkey.toLowerCase(), createdAt, kind, tags, content];
    String serializedEvent = json.encode(data);
    List<int> hash = sha256.convert(utf8.encode(serializedEvent)).bytes;
    return hex.encode(hash);
  }

  /// Each user has a keypair. Signatures, public key, and encodings are done according to the Schnorr signatures standard for the curve secp256k1
  /// 64-bytes signature of the sha256 hash of the serialized event data, which is the same as the "id" field
  String getSignature(String privateKey) {
    /// aux must be 32-bytes random bytes, generated at signature time.
    /// https://github.com/nbd-wtf/dart-bip340/blob/master/lib/src/bip340.dart#L10
    String aux = generate64RandomHexChars();
    return bip340.sign(privateKey, id, aux);
  }
}
