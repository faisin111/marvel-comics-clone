import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/models/character_model.dart';
import 'package:marvel_comics/repository/character_repository.dart';
import 'package:marvel_comics/view_models/state/character_state.dart';

class CharacterController extends StateNotifier<CharacterState> {
  CharacterController(this.repo) : super(CharacterState());
  final CharacterRepository repo;
  int limit = 20;
  int offset = 0;
  Future<void> getAllchar() async {
    offset = 0;
    state = state.copyWithin(loading: true, succes: false);
    try {
      final data = await repo.getCharacters(limit: limit, offset: offset);
      final q = data
          .map((e) => e = e.copyWithin(isFav: repo.isContainsChar(e.id)))
          .toList();
      state = state.copyWithin(
        loading: false,
        characters: q,
        succes: true,
        hasMore: limit == q.length,
      );
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

  Future<void> loadMorechar() async {
    if (state.loadingMore) return;
    if (!state.hasMore) return;
    state = state.copyWithin(loadingMore: true);
    try {
      offset += limit;
      final data = await repo.getCharacters(limit: limit, offset: offset);
      final q = data
          .map((e) => e = e.copyWithin(isFav: repo.isContainsChar(e.id)))
          .toList();
      final updated = [...state.characters, ...q];
      final unique = {
        for (final item in updated) item.id: item,
      }.values.toList();

      state = state.copyWithin(
        loading: false,
        loadingMore: false,
        characters: unique,

        hasMore: limit == q.length,
      );
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
      final s = state.characters.firstWhere((e) => e.id == id);
      if (s.isFav) {
        state = state.copyWithin(
          detailed: data.copyWithin(isFav: true),
          loading: false,
          succes: true,
        );
        return;
      }
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

      final updated = state.characters.map((e) {
        return e.id == id ? e.copyWithin(isFav: false) : e;
      }).toList();

      state = state.copyWithin(
        loading: false,
        succes: true,
        characters: updated,
        detailed: detailed && state.detailed != null
            ? state.detailed!.copyWithin(isFav: false)
            : state.detailed,
      );
    } catch (e) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: e.toString(),
      );
    }
  }

  Future<void> addFav(CharacterModel model, {bool detailed = false}) async {
    try {
      final data = await repo.getDetails(model.id);
      final g = data.copyWithin(isFav: true);
      await repo.addItemChar(g);
      if (detailed) {
        final up = state.detailed?.copyWithin(isFav: true);
        state = state.copyWithin(loading: false, succes: true, detailed: up);
      }
      final updated = state.characters.map((e) {
        if (e.id == model.id) {
          return e = e.copyWithin(isFav: true);
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

  Future<void> getChar(int id) async {}

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
