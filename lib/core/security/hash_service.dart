import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashService {
  static String sha256Bytes(List<int> bytes) => sha256.convert(bytes).toString();
  static String sha256String(String s) => sha256Bytes(utf8.encode(s));
}
