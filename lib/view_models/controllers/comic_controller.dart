import 'package:flutter_riverpod/legacy.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/models/comic_model.dart';
import 'package:marvel_comics/repository/comic_repo.dart';
import 'package:marvel_comics/view_models/state/comic_state.dart';

class ComicController extends StateNotifier<ComicState> {
  ComicController(this.repo) : super(ComicState());
  final ComicRepo repo;
  Future<void> getAllchar({int? limit = 20, int? offset = 0}) async {
    state = state.copyWithin(loading: true, succes: false);
    try {
      final data = await repo.getComics(limit: limit, offset: offset);
      final q = data
          .map((e) => e = e.copyWithin(isFav: repo.isContainsComic(e.id)))
          .toList();
      state = state.copyWithin(loading: false, comics: q, succes: true);
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

  Future<void> searchCharacter(String query) async {
    state = state.copyWithin(loading: true, succes: false);
    try {
      final data = await repo.search(query);
      final q = data
          .map((e) => e = e.copyWithin(isFav: repo.isContainsComic(e.id)))
          .toList();
      state = state.copyWithin(loading: false, comics: q, succes: true);
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
      await repo.removeComic(id);
      if (detailed) {
        final up = state.detailed?.copyWithin(isFav: false);
        state = state.copyWithin(loading: false, succes: true, detailed: up);
      }
      final updated = state.comics.map((e) {
        if (e.id == id) {
          return e.copyWithin(isFav: false);
        }
        return e;
      }).toList();
      state = state.copyWithin(
        loading: false,
        succes: true,
        comics: updated,
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

  Future<void> addFav(ComicModel model, {bool detailed = false}) async {
    try {
      await repo.addItemComic(model);
      if (detailed) {
        final up = state.detailed?.copyWithin(isFav: true);
        state = state.copyWithin(loading: false, succes: true, detailed: up);
      }
      final updated = state.comics.map((e) {
        if (e.id == model.id) {
          return e.copyWithin(isFav: true);
        }
        return e;
      }).toList();
      state = state.copyWithin(
        loading: false,
        succes: true,
        comics: updated,
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
