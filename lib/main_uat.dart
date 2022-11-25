import 'package:app/app/app_flavor.dart';
import 'package:app/main.dart';

void main() {
  AppFlavor.appFlavor = Flavor.uat;
  run();
}
