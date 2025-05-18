import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  factory EncryptionService() => _instance;
  EncryptionService._internal();

  final _storage = const FlutterSecureStorage();
  late final Key _key;
  late final IV _iv;

  Future<void> _initKeys() async {
    try {
      // Tenta recuperar as chaves armazenadas
      final storedKey = await _storage.read(key: 'encryption_key');
      final storedIv = await _storage.read(key: 'encryption_iv');

      if (storedKey != null && storedIv != null) {
        _key = Key(base64.decode(storedKey));
        _iv = IV(base64.decode(storedIv));
      } else {
        // Gera novas chaves se não existirem
        final key = Key.fromSecureRandom(32);
        final iv = IV.fromSecureRandom(16);

        // Armazena as chaves
        await _storage.write(key: 'encryption_key', value: base64.encode(key.bytes));
        await _storage.write(key: 'encryption_iv', value: base64.encode(iv.bytes));

        _key = key;
        _iv = iv;
      }
    } catch (e) {
      throw Exception('Erro ao inicializar chaves de criptografia: $e');
    }
  }

  Future<Uint8List> encryptFile(Uint8List data) async {
    await _initKeys();
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encryptBytes(data, iv: _iv);
    return encrypted.bytes;
  }

  Future<Uint8List> decryptFile(Uint8List data) async {
    await _initKeys();
    final encrypter = Encrypter(AES(_key));
    final decrypted = encrypter.decryptBytes(Encrypted(data), iv: _iv);
    return Uint8List.fromList(decrypted);
  }

  Future<void> clearKeys() async {
    await _storage.delete(key: 'encryption_key');
    await _storage.delete(key: 'encryption_iv');
  }
} 