import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser/pages/main_page.dart';

import '/pages/splash.dart';

void main() {
  runApp(SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () => runApp(ProviderScope(child: MyApp()))));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MainPage.id: (context) => MainPage(),
      },
      initialRoute: MainPage.id,
    );
  }
}
