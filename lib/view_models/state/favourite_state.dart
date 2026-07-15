import 'package:flutter/material.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/models/character_model.dart';
import 'package:marvel_comics/models/comic_model.dart';

class FavouriteState {
  final String? message;
  final ApiException? type;
  final bool succes;
  final bool loading;
  final List<CharacterModel> characters;
  final List<ComicModel> comics;
  final List<dynamic> all;
  final dynamic detailed;

  FavouriteState({
    this.message,
    this.loading = false,
    this.succes = true,
    this.detailed,
    this.type,
    this.comics = const [],
    this.characters = const [],
    this.all = const [],
  });

  FavouriteState copyWithin({
    String? message,
    bool? succes,
    bool? loading,
    ApiException? type,
    dynamic detailed,
    List<CharacterModel>? characters,
    List<ComicModel>? comics,
    List<dynamic>? all,
  }) {
    return FavouriteState(
      message: message ?? this.message,
      succes: succes ?? this.succes,
      loading: loading ?? this.loading,
      type: type ?? this.type,
      comics: comics ?? this.comics,
      characters: characters ?? this.characters,
      all: all ?? this.all,
      detailed: detailed ?? this.detailed,
    );
  }
}
