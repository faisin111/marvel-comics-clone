import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/repository/character_repository.dart';
import 'package:marvel_comics/view_models/state/character_state.dart';

class CharacterController extends StateNotifier<CharacterState> {
  CharacterController(this.repo) : super(CharacterState());
  final CharacterRepository repo;

  Future<void> getAllchar({int? limit = 20, int? offset = 0}) async {
    state = state.copyWithin(loading: true, succes: false);
    try {
      final data = await repo.getCharacters(limit: limit, offset: offset);
      state = state.copyWithin(loading: false, characters: data, succes: true);
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
      state = state.copyWithin(loading: false,detailed: data, succes: true);
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
      state = state.copyWithin(loading: false, characters: data, succes: true);
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
