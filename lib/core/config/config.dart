import 'package:group_exito/core/utils/types/base_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config extends BaseConfig {
  @override
  String get baseUrl => dotenv.env['URLBASE'] ?? '';
}
