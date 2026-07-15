import 'package:flutter_riverpod/legacy.dart';
import 'package:marvel_comics/models/comic_model.dart';
import 'package:marvel_comics/repository/favourite_repo.dart';
import 'package:marvel_comics/view_models/state/favourite_state.dart';

class FavouriteController extends StateNotifier<FavouriteState> {
  FavouriteController(this.repo) : super(FavouriteState());
  final FavouriteRepo repo;

  void getAll() {
    try {
      final ch = repo.getAllChar();
      final co = repo.getAllComic();

      final all = [...ch, ...co];
      all.shuffle();
      state = state.copyWithin(
        loading: false,
        succes: true,
        all: all,
        characters: ch,
        comics: co,
      );
    } catch (r) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: r.toString(),
      );
    }
  }

  void getAllCh() {
    try {
      final ch = repo.getAllChar();

      state = state.copyWithin(loading: false, succes: true, all: ch);
    } catch (r) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: r.toString(),
      );
    }
  }

  void getAllCo() {
    try {
      final co = repo.getAllComic();

      state = state.copyWithin(loading: false, succes: true, all: co);
    } catch (r) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: r.toString(),
      );
    }
  }

  Future<void> removeFav(
    int id, {
    bool detailed = false,
    bool isChar = false,
  }) async {
    try {
      if (isChar) {
        await repo.removeChar(id);
        final ch = state.characters.map((e) {
          if (e.id == id) {
            return e.copyWithin(isFav: false);
          }
          return e;
        }).toList();

        state = state.copyWithin(loading: false, succes: true, characters: ch);
      } else {
        await repo.removeComic(id);
        final ch = state.comics.map((e) {
          if (e.id == id) {
            return e.copyWithin(isFav: false);
          }
          return e;
        }).toList();

        state = state.copyWithin(loading: false, succes: true, comics: ch);
      }

      final updated = state.all.map((e) {
        if (e.id == id) {
          return e.copyWithin(isFav: false);
        }
        return e;
      }).toList();
      state = state.copyWithin(loading: false, succes: true, all: updated);
    } catch (r) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: r.toString(),
      );
    }
  }

  void getDetailed(int id) {
    final data = state.all.firstWhere((e) => e.id == id);
    state = state.copyWithin(detailed: data);
  }

  Future<void> addFav(dynamic model, {bool char = false}) async {
    try {
      if (char) {
        await repo.addItemChar(model);
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
      } else {
        await repo.addItemComic(model);
        final updated = state.comics.map((e) {
          if (e.id == model.id) {
            return e.copyWithin(isFav: true);
          }
          return e;
        }).toList();
        state = state.copyWithin(loading: false, succes: true, comics: updated);
      }

      final updated = state.all.map((e) {
        if (e.id == model.id) {
          return e.copyWithin(isFav: true);
        }
        return e;
      }).toList();
      state = state.copyWithin(loading: false, succes: true, all: updated);
    } catch (r) {
      state = state.copyWithin(
        loading: false,
        succes: false,
        message: r.toString(),
      );
    }
  }
}
