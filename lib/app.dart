import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stem_union/authentication/repositories/authentication_repositrories.dart';
import 'package:stem_union/bindings/general_bindings.dart';
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
      builder: (context, child) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          alignment: Alignment.topCenter,
          
            child: child!,
          
        );
      },
      home: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AuthenticationRepository().screenRedirect();
          });
          return Container();
        },
      ),
    );
  }
}
