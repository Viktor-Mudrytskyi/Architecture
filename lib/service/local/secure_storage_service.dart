import 'dart:convert';

import '../../core/exception/exception_handler.dart';
import 'jwt_pair_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {

  SecureStorageService({required ExceptionHandler exceptionHandler})
    : _exceptionHandler = exceptionHandler {
    _secureStorage = const FlutterSecureStorage(
      aOptions: _androidOptions,
      // if needed, specify IOS options
    );
  }
  final ExceptionHandler _exceptionHandler;

  late final FlutterSecureStorage _secureStorage;

  static const AndroidOptions _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
  );

  static const _jwtPair = 'jwtPair';

  Future<JwtPairModel?> getJwtPair() async {
    try {
      final data = await _secureStorage.read(key: _jwtPair) ?? '';
      return JwtPairModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
    } catch (e, stackTrace) {
      _exceptionHandler.handleException(e, stackTrace);
      return null;
    }
  }

  Future<void> setJwtPair(JwtPairModel jwtPair) async {
    try {
      await _secureStorage.write(
        key: _jwtPair,
        value: jsonEncode(jwtPair.toJson()),
      );
    } catch (e, stackTrace) {
      _exceptionHandler.handleException(e, stackTrace);
    }
  }

  Future<void> deleteJwtPair() async {
    try {
      await _secureStorage.delete(key: _jwtPair);
    } catch (e, stackTrace) {
      _exceptionHandler.handleException(e, stackTrace);
    }
  }
}
