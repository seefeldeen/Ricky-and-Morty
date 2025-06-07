import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/character_model.dart';
import '../data/repo/ChraractersRepo.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {

 final ChraracterRepo characterRepo ;
late List<CharacterModel> characters = [];

  CharactersCubit(this.characterRepo) : super(CharactersInitial());


void fetchCharacters() async {
   try {
     final value = await characterRepo.getCharacters();
     characters = value;
     emit(loadedCharacters(characters: characters));
   } catch (error) {
     print("Error fetching characters: $error");
   }
 }
 }

