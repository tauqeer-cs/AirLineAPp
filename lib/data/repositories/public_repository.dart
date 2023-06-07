import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/public_provider.dart';
import 'package:app/models/country.dart';
import 'package:app/models/switch_setting.dart';

class PublicRepository {
  static final PublicRepository _instance = PublicRepository._internal();

  static final PublicProvider _provider = PublicProvider(
    Api.client,
    baseUrl: '${AppFlavor.baseUrlApi}/v1/',
  );

  factory PublicRepository() {
    return _instance;
  }

  PublicRepository._internal();

  Future<Countries> getCountries() async {
    //countries.sort((a, b) => a.population.compareTo(b.population));
    var retuenObject =  await _provider.getCountries();
    //retuenObject?.countries?.sort()

    retuenObject.countries!.sort((a, b) => (a.country?? '').compareTo(b.country ?? ''));

    // retuenObject.countries!.sort(a,b)  => a.compareTo(b.someProperty);
  return retuenObject;

  }

  Future<SwitchSetting> getSettings({bool returnTrue = false}) async {
    if (returnTrue) {
      return const SwitchSetting(insurance: true, myReward: true);
    }

    return await _provider.getSettings();
  }
}
