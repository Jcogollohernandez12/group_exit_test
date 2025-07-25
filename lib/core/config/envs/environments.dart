import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:group_exito/core/config/config.dart';
import 'package:group_exito/core/resources/gen/assets.gen.dart';
import 'package:group_exito/core/utils/types/base_config.dart';
import 'package:group_exito/core/utils/types/flavor.dart';

class Environment {
  factory Environment() => _instance;

  Environment._internal();
  static final Environment _instance = Environment._internal();

  late BaseConfig config;

  Future<void> initConfig({required Flavor env}) async {
    config = await _getConfig(kReleaseMode ? Flavor.dev : env);
  }

  Future<BaseConfig> _getConfig(Flavor environment) async {
    switch (environment) {
      case Flavor.dev:
        await dotenv.load(fileName: Assets.envs.aEnvDevelopment);
      case Flavor.prod:
        await dotenv.load(fileName: Assets.envs.aEnvProduction);
    }
    return Config();
  }
}
