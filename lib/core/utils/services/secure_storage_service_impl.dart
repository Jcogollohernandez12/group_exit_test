import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:group_exito/core/utils/interface/secure_storage_service.dart';

class SecureStorageServiceImpl implements ISecureStorageService {
  SecureStorageServiceImpl() : _secure = const FlutterSecureStorage();
  final FlutterSecureStorage _secure;

  @override
  Future<void> setDarkMode(bool value) =>
      _secure.write(key: 'darkMode', value: value.toString());

  @override
  Future<bool> isDarkMode() async =>
      (await _secure.read(key: 'darkMode')) == 'true';
}
