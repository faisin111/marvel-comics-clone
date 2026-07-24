import 'package:flutter_riverpod/legacy.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/models/comic_model.dart';
import 'package:marvel_comics/repository/comic_repo.dart';
import 'package:marvel_comics/view_models/state/comic_state.dart';

class ComicController extends StateNotifier<ComicState> {
  ComicController(this.repo) : super(ComicState());
  final ComicRepo repo;
  int limit = 20;
  int offset = 0;
  Future<void> getAllComic() async {
    offset = 0;
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

  Future<void> loadMorechar() async {
    if (state.loadingMore) return;
    if (!state.hasMore) return;
    state = state.copyWithin(loadingMore: true);
    try {
      offset += limit;
      final data = await repo.getComics(limit: limit, offset: offset);
      final q = data
          .map((e) => e = e.copyWithin(isFav: repo.isContainsComic(e.id)))
          .toList();
      final updated = [...state.comics, ...q];
      final unique = {
        for (final item in updated) item.id: item,
      }.values.toList();

      state = state.copyWithin(
        loading: false,
        loadingMore: false,
        comics: unique,

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
      final s = state.comics.firstWhere((e) => e.id == id);
      if (s.isFav) {
        state = state.copyWithin(
          detailed: data.copyWithin(isFav: true),
          succes: true,
          loading: false,
        );
        return;
      }
      state = state.copyWithin(loading: false, succes: true, detailed: data);
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

      final updated = state.comics.map((comic) {
        return comic.id == id ? comic.copyWithin(isFav: false) : comic;
      }).toList();

      state = state.copyWithin(
        comics: updated,
        detailed: detailed && state.detailed != null
            ? state.detailed!.copyWithin(isFav: false)
            : state.detailed,
        succes: true,
        loading: false,
      );
    } catch (e) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: e.toString(),
      );
    }
  }

  Future<void> addFav(ComicModel model, {bool detailed = false}) async {
    try {
      final da = await repo.getDetails(model.id);
      final g = da.copyWithin(isFav: true);
      await repo.addItemComic(g);
      if (detailed) {
        final up = state.detailed?.copyWithin(isFav: true);
        state = state.copyWithin(loading: false, succes: true, detailed: up);
      }
      final updated = state.comics.map((e) {
        if (e.id == model.id) {
          return e = e.copyWithin(isFav: true);
        }
        return e;
      }).toList();
      state = state.copyWithin(loading: false, succes: true, comics: updated);
    } catch (r) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: r.toString(),
      );
    }
  }
}
