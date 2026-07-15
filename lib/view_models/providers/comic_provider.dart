import 'package:flutter_riverpod/legacy.dart';
import 'package:marvel_comics/core/cache/comic_hive_service.dart';
import 'package:marvel_comics/repository/comic_repo.dart';
import 'package:marvel_comics/services/comic_service.dart';
import 'package:marvel_comics/services/favourite_service.dart';
import 'package:marvel_comics/view_models/controllers/comic_controller.dart';
import 'package:marvel_comics/view_models/state/comic_state.dart';

final comicProvider = StateNotifierProvider<ComicController, ComicState>((ref) {
  return ComicController(
    ComicRepo(ComicService(), ComicHiveService(), FavouriteService()),
  );
});
