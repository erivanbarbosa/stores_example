import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/constants/app_theme.dart';
import 'package:redesprou_boilerplate_name/constants/strings.dart';
import 'package:redesprou_boilerplate_name/data/repository.dart';
import 'package:redesprou_boilerplate_name/di/components/service_locator.dart';
import 'package:redesprou_boilerplate_name/stores/notification/notification_store.dart';
import 'package:redesprou_boilerplate_name/stores/profile/profile_store.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_store.dart';
import 'package:redesprou_boilerplate_name/ui/dashboard/dashboard.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/stores/language/language_store.dart';
import 'package:redesprou_boilerplate_name/stores/post/post_store.dart';
import 'package:redesprou_boilerplate_name/stores/theme/theme_store.dart';
import 'package:redesprou_boilerplate_name/stores/user/user_store.dart';
import 'package:redesprou_boilerplate_name/ui/home/home.dart';
import 'package:redesprou_boilerplate_name/ui/login/login.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final PostStore _postStore = PostStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<PostStore>(create: (_) => _postStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<ProfileStore>(create: (context) => ProfileStore()),
        Provider<ServiceStore>(create: (context) => ServiceStore()),
        Provider<NotificationStore>(create: (context) => NotificationStore())
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages.map((language) => Locale(language.locale!, language.code)).toList(),
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            home: _userStore.isLoggedIn ? DashboardScreen() : LoginScreen(),
          );
        },
      ),
    );
  }
}
