abstract class ISecureStorageService {
  Future<void> setDarkMode(bool value);
  Future<bool> isDarkMode();
}
