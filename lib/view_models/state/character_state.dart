import 'package:flutter/material.dart';
import 'package:marvel_comics/core/error/api_exception.dart';
import 'package:marvel_comics/models/character_model.dart';

class CharacterState {
  final String? message;
  final ApiException? type;
  final bool succes;
  final bool loading;
  final bool loadingMore;
  final bool hasMore;
  final List<CharacterModel> characters;
  final CharacterModel? detailed;
  
  CharacterState({
    this.message,
    this.loading = false,
    this.succes = false,
  
    this.loadingMore=false,
    this.hasMore=true,
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
      bool? loadingMore,
    bool? hasMore
  }) {
    return CharacterState(
      message: message ?? this.message,
      succes: succes ?? this.succes,
      loading: loading ?? this.loading,
      type: type??this.type,
      detailed: detailed??this.detailed,
      characters: characters ?? this.characters,
      loadingMore: loadingMore??this.loadingMore,
      hasMore: hasMore??this.hasMore
    );
  }
}
