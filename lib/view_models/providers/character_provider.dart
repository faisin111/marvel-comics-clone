import 'package:flutter_riverpod/legacy.dart';
import 'package:marvel_comics/core/cache/character_hive_service.dart';
import 'package:marvel_comics/repository/character_repository.dart';
import 'package:marvel_comics/services/character_service.dart';
import 'package:marvel_comics/services/favourite_service.dart';
import 'package:marvel_comics/view_models/controllers/character_controller.dart';
import 'package:marvel_comics/view_models/state/character_state.dart';

final characterProvider =
    StateNotifierProvider<CharacterController, CharacterState>((ref) {
      return CharacterController(CharacterRepository(CharacterService(),CharacterHiveService(),FavouriteService()));
    });
