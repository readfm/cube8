// ignore_for_file: subtype_of_sealed_class

import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:bip340/bip340.dart' as bip340;
import 'package:oo8/utils.dart';
import 'package:nostr_client/nostr_client.dart';

class EventFractal extends Event {
  EventFractal({
    required super.id,
    required super.pubkey,
    required super.createdAt,
    required super.kind,
    required super.tags,
    required super.content,
    required super.sig,
  }) {}

  static create(String val, {required KeyPair keyPair}) {
    final now = DateTime.now();
    final kind = 1;
    final tags = <List<String>>[];
    List data = [
      0,
      keyPair.publicKey.toLowerCase(),
      now.millisecondsSinceEpoch ~/ 1000,
      kind,
      tags,
      val
    ];
    String serializedEvent = json.encode(data);
    List<int> hash = sha256.convert(utf8.encode(serializedEvent)).bytes;
    final id = hex.encode(hash);

    return Event(
      id: id,
      createdAt: now,
      kind: kind,
      tags: tags,
      content: val,
      pubkey: keyPair.publicKey,
      sig: const Signer().sign(privateKey: keyPair.privateKey, message: id),
    );

    //focus
  }
}
