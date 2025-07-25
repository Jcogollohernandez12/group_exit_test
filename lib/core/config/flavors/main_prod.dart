import 'package:group_exito/core/config/flavors/flavors.dart';
import 'package:group_exito/core/utils/types/flavor.dart';
import 'package:group_exito/runner.dart';

void main() async {
  FlavorConfig.appFlavor = Flavor.prod;
  await initializeFlutterApp();
}
