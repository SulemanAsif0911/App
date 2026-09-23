import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;

class CryptoService {
  CryptoService(this._secret);
  final String _secret;

  enc.Key get _key {
    final digest = sha256.convert(utf8.encode(_secret));
    return enc.Key(Uint8List.fromList(digest.bytes));
  }

  String encryptUtf8(String plain) {
    final iv = enc.IV.fromSecureRandom(16);
    final e = enc.Encrypter(enc.AES(_key, mode: enc.AESMode.cbc));
    final out = e.encrypt(plain, iv: iv);
    return '${iv.base64}:${out.base64}';
  }

  String decryptUtf8(String packed) {
    final parts = packed.split(':');
    final iv = enc.IV.fromBase64(parts[0]);
    final e = enc.Encrypter(enc.AES(_key, mode: enc.AESMode.cbc));
    return e.decrypt64(parts[1], iv: iv);
  }

  List<int> encryptBytes(List<int> data) {
    final iv = enc.IV.fromSecureRandom(16);
    final e = enc.Encrypter(enc.AES(_key, mode: enc.AESMode.cbc));
    final out = e.encryptBytes(data, iv: iv);
    return [...iv.bytes, ...out.bytes];
  }

  List<int> decryptBytes(List<int> packed) {
    final iv = enc.IV(Uint8List.fromList(packed.take(16).toList()));
    final rest = packed.sublist(16);
    final e = enc.Encrypter(enc.AES(_key, mode: enc.AESMode.cbc));
    return e.decryptBytes(enc.Encrypted(Uint8List.fromList(rest)), iv: iv);
  }

  static String randomSecret() {
    final r = Random.secure();
    return List.generate(32, (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
  }
}
