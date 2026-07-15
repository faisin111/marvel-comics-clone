import 'package:flutter_riverpod/legacy.dart';
import 'package:marvel_comics/repository/favourite_repo.dart';
import 'package:marvel_comics/services/favourite_service.dart';
import 'package:marvel_comics/view_models/controllers/favourite_controller.dart';
import 'package:marvel_comics/view_models/state/favourite_state.dart';

final favouriteProvider =
    StateNotifierProvider<FavouriteController, FavouriteState>((ref) {
      return FavouriteController(FavouriteRepo(FavouriteService()));
    });
