import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/models/character_model.dart';
import 'package:marvel_comics/repository/character_repository.dart';
import 'package:marvel_comics/view_models/state/character_state.dart';

class CharacterController extends StateNotifier<CharacterState> {
  CharacterController(this.repo) : super(CharacterState());
  final CharacterRepository repo;

  Future<void> getAllchar({int? limit = 20, int? offset = 0}) async {
    state = state.copyWithin(loading: true, succes: false);
    try {
      final data = await repo.getCharacters(limit: limit, offset: offset);
      final q = data
          .map((e) => e = e.copyWithin(isFav: repo.isContainsChar(e.id)))
          .toList();
      state = state.copyWithin(loading: false, characters: q, succes: true);
    } on ApiException catch (e) {
      state = state.copyWithin(
        type: e,
        loading: false,
        succes: false,
        message: e.message,
      );
    } catch (r) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: r.toString(),
      );
    }
  }

  Future<void> detailedCharacter(int id) async {
    state = state.copyWithin(loading: true, succes: false);
    try {
      final data = await repo.getDetails(id);

      state = state.copyWithin(loading: false, detailed: data, succes: true);
    } on ApiException catch (e) {
      state = state.copyWithin(
        type: e,
        loading: false,
        succes: false,
        message: e.message,
      );
    } catch (r) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: r.toString(),
      );
    }
  }

  Future<void> removeFav(int id, {bool detailed = false}) async {
    try {
      
      await repo.removeChar(id);
      if (detailed) {
        final up = state.detailed?.copyWithin(isFav: false);
        state = state.copyWithin(loading: false, succes: true, detailed: up);
      }
      final updated = state.characters.map((e) {
        if (e.id == id) {
          return e.copyWithin(isFav: false);
        }
        return e;
      }).toList();
      state = state.copyWithin(
        loading: false,
        succes: true,
        characters: updated,
      );
      state = state.copyWithin(loading: false, succes: true);
    } catch (r) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: r.toString(),
      );
    }
  }

  Future<void> addFav(CharacterModel model, {bool detailed = false}) async {
    try {
         final data = await repo.getDetails(model.id);
      await repo.addItemChar(data);
      if (detailed) {
        final up = state.detailed?.copyWithin(isFav: true);
        state = state.copyWithin(loading: false, succes: true, detailed: up);
      }
      final updated = state.characters.map((e) {
        if (e.id == model.id) {
          return e.copyWithin(isFav: true);
        }
        return e;
      }).toList();
      state = state.copyWithin(
        loading: false,
        succes: true,
        characters: updated,
      );
    } catch (r) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: r.toString(),
      );
    }
  }
  
  Future<void> getChar(int id)async{
    
  }

  Future<void> searchCharacter(String query) async {
    state = state.copyWithin(loading: true, succes: false);
    try {
      final data = await repo.search(query);
      final q = data
          .map((e) => e = e.copyWithin(isFav: repo.isContainsChar(e.id)))
          .toList();
      state = state.copyWithin(loading: false, characters: q, succes: true);
    } on ApiException catch (e) {
      state = state.copyWithin(
        type: e,
        loading: false,
        succes: false,
        message: e.message,
      );
    } catch (r) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: r.toString(),
      );
    }
  }
}
