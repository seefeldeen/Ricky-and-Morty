part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}


class loadedCharacters extends CharactersState {

  final List<CharacterModel> characters;

  loadedCharacters({required this.characters});
}
