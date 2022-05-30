import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/domain/models/cat_model.dart';
import 'package:test_app/presentation/blocs/cat_fact_bloc.dart';
import 'package:test_app/presentation/home_page.dart';

import 'data/local_dataproviders/hive_helper.dart';

void main() async {
  final localData = LocalDataProvider();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // hive initializasiyasi
  await Hive.initFlutter();
  Hive.registerAdapter(CatFactModelAdapter());
  await localData.openBox();

  runApp(
    BlocProvider(
      create: (BuildContext context) => CatFactBloc()..add(CatFactLoadEvent()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,

      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'US'),
      ],
      home: const HomePage(),
    );
  }
}
