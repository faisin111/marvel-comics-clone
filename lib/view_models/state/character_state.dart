import 'package:flutter/material.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/models/character_model.dart';

class CharacterState {
  final String? message;
  final ApiException? type;
  final bool succes;
  final bool loading;
  final List<CharacterModel> characters;
  final CharacterModel? detailed;
  final bool isFav;
  CharacterState({
    this.message,
    this.loading = false,
    this.succes = true,
    this.isFav=false,
    this.type,
    this.detailed,
    this.characters = const [],
  });

  CharacterState copyWithin({
    String? message,
    bool? succes,
    bool? loading,
    ApiException? type,
    CharacterModel? detailed,
    List<CharacterModel>? characters,
    bool? isFav
  }) {
    return CharacterState(
      message: message ?? this.message,
      succes: succes ?? this.succes,
      loading: loading ?? this.loading,
      type: type??this.type,
      detailed: detailed??this.detailed,
      characters: characters ?? this.characters,
      isFav: isFav??this.isFav
    );
  }
}
