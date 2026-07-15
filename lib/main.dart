import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:marvel_comics/core/constants/hive_constants.dart';
import 'package:marvel_comics/core/theme/app_theme.dart';
import 'package:marvel_comics/models/character_adapter.dart';
import 'package:marvel_comics/models/character_model.dart';
import 'package:marvel_comics/models/comic_adapter.dart';
import 'package:marvel_comics/models/comic_model.dart';
import 'package:marvel_comics/views/bottom_app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterModelAdapter());
  Hive.registerAdapter(ComicModelAdapter());
  await Hive.openBox<CharacterModel>(HiveConstants.character);
  await Hive.openBox<ComicModel>(HiveConstants.comic);
  await Hive.openBox<CharacterModel>(HiveConstants.charfav);
  await Hive.openBox<ComicModel>(HiveConstants.comicfav);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: BottomAppView(),
    );
  }
}
