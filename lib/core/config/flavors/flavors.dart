import 'package:group_exito/core/utils/types/flavor.dart';

class FlavorConfig {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Group Exito Dev';
      case Flavor.prod:
        return 'Group Exito';
    }
  }
}
