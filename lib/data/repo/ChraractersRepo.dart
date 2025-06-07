import 'package:bloc_practise/data/api_call/api_service.dart';
import 'package:bloc_practise/data/models/character_model.dart';

class ChraracterRepo{

  final api_service apiService;

  ChraracterRepo({required this.apiService});

  Future<List<CharacterModel>> getCharacters() async {
    try {
      final characters = await apiService.getCharacters();
      return characters.map( (character)=> CharacterModel.fromJson(character)).toList();
    } catch (e) {
      return [];
    }
  }
}