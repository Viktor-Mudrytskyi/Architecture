import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService() {
    _secureStorage = const FlutterSecureStorage(
      aOptions: _androidOptions,
      // if needed, specify IOS options
    );
  }
  late final FlutterSecureStorage _secureStorage;

  static const AndroidOptions _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  static const _accessToken = 'accessToken';
  static const _refreshToken = 'refreshToken';

  Future<String> getAccessToken() async {
    try {
      final data = await _secureStorage.read(key: _accessToken) ?? '';
      return data;
    } catch (e) {
      return '';
    }
  }

  Future<void> setAccessToken(String accessToken) async {
    try {
      await _secureStorage.write(key: _accessToken, value: accessToken);
    } catch (e) {
      return;
    }
  }

  Future<void> deleteAccessToken() async {
    try {
      await _secureStorage.delete(key: _accessToken);
    } catch (e) {
      return;
    }
  }

  Future<String> getRefreshToken() async {
    try {
      final data = await _secureStorage.read(key: _refreshToken) ?? '';
      return data;
    } catch (e) {
      return '';
    }
  }

  Future<void> setRefreshToken(String refreshToken) async {
    try {
      await _secureStorage.write(key: _refreshToken, value: refreshToken);
    } catch (e) {
      return;
    }
  }

  Future<void> deleteRefreshToken() {
    return _secureStorage.delete(key: _refreshToken);
  }
}
