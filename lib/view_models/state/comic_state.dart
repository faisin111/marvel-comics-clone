import 'package:flutter/material.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/models/character_model.dart';
import 'package:marvel_comics/models/comic_model.dart';

class ComicState {
  final String? message;
  final ApiException? type;
  final bool succes;
  final bool loading;
  final List<ComicModel> characters;
  final ComicModel? detailed;
  ComicState({
    this.message,
    this.loading = false,
    this.succes = true,
    this.type,
    this.detailed,
    this.characters = const [],
  });

  ComicState copyWithin({
    String? message,
    bool? succes,
    bool? loading,
    ApiException? type,
    ComicModel? detailed,
    List<ComicModel>? characters,
  }) {
    return ComicState(
      message: message ?? this.message,
      succes: succes ?? this.succes,
      loading: loading ?? this.loading,
      type: type??this.type,
      detailed: detailed??this.detailed,
      characters: characters ?? this.characters,
    );
  }
}
