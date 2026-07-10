import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stem_union/bindings/general_bindings.dart';
import 'package:stem_union/screens/home_page/home.dart';
import 'package:stem_union/screens/home_page/app_routs.dart';
import 'package:stem_union/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      initialRoute: AppRoutes.loading,
      getPages: [
        GetPage(name: AppRoutes.loading, page: () => const _LoadingScreen()),
        GetPage(name: AppRoutes.home, page: () => const HomePage()),
      ],
      builder: (context, child) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          alignment: Alignment.topCenter,
          child: child!,
        );
      },
    );
  }
}

/// Shown briefly while AuthenticationRepository's authStateChanges
/// listener (onReady()) decides where to send the user — LoginScreen,
/// EmailVerification, ChangeAcademicInfo, or HomePage.
class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}