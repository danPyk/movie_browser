import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_browser/services/http_service.dart';
import 'package:movie_browser/services/movie_service.dart';
import '../models/app_config.dart';
import '../services/http_service.dart';
import '../services/movie_service.dart';

class SplashPage extends StatefulWidget {
  //called when init is completed
  final VoidCallback onInitializationComplete;

  SplashPage({Key? key, required this.onInitializationComplete})
      : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((value) =>
        _setup(context).then((_) => widget.onInitializationComplete())
    );
  }

  //make json globally usable
  //async, because accessing apple file storage need to be async
  Future<void> _setup(BuildContext context) async {
    //loading data from file

    //load data from config file
    // rootBundle contains the resources that were packaged with the application when it was built.
    final configFile = await rootBundle.loadString('assets/config/main.json');
    //get data out of json and decode it
    final configData = jsonDecode(configFile);

    createSingletons(configData);

  }

  void createSingletons(dynamic configData) async {
    final getIt = GetIt.instance;

    //create singleton
    getIt.registerSingleton<AppConfig>(AppConfig(
        BASE_API_URL: configData['BASE_API_URL'],
        BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
        API_KEY: configData['API_KEY']));

    getIt.registerSingleton<HTTPService>(HTTPService());
    getIt.registerSingleton<MovieService>(MovieService());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie browser',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/logo.png'),
                )),
          ),
        ));
  }
}
