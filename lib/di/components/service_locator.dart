import 'package:redesprou_boilerplate_name/data/network/dio_client.dart';
import 'package:redesprou_boilerplate_name/data/network/rest_client.dart';
import 'package:redesprou_boilerplate_name/data/sharedpref/shared_preference_helper.dart';
import 'package:redesprou_boilerplate_name/di/module/local_module.dart';
import 'package:redesprou_boilerplate_name/di/module/network_module.dart';
import 'package:redesprou_boilerplate_name/stores/error/error_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

final contacss = [];

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(() => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());
}
