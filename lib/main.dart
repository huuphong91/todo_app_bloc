import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app_bloc/repository/src/file_storage.dart';
import 'package:todo_app_bloc/repository/todo_repository.dart';
import 'package:todo_app_bloc/screens/home/bloc/home_bloc.dart';
import 'package:todo_app_bloc/simple_bloc_observer.dart';

import 'config/app_theme.dart';
import 'screens/home/view/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = SimpleBlocObserver();
  runApp(BlocProvider(
      create: (_) => HomeBloc(
              todoRepository: const TodoRepository(
                  fileStorage: const FileStorage(
            '__flutter_bloc_app__',
            getApplicationDocumentsDirectory,
          )))
            ..add(HomeLoaded()),
      child: MyApp()));
  _configLoading();
}

_configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TODO APP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      getPages: [
        GetPage(
          name: MyHomePage.router,
          page: () => MyHomePage(),
        ),
        GetPage(name: MyHomePage.router, page: () => MyHomePage()),
      ],
      builder: EasyLoading.init(),
    );
  }
}
