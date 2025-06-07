import 'package:bloc_practise/business_logic/characters_cubit.dart';
import 'package:bloc_practise/data/models/character_model.dart';
import 'package:flutter/material.dart';
import '../../Presentation/screens/DetailsScreen.dart';
import '../../Presentation/screens/home.dart';
import '../../data/api_call/api_service.dart';
import '../../data/repo/ChraractersRepo.dart';
import '../Strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class app_router {

  late CharactersCubit charactersCubit;
  late ChraracterRepo charactersRepo;

  app_router() {
    charactersRepo = ChraracterRepo(apiService: api_service());
    charactersCubit = CharactersCubit( charactersRepo);
  }


  Route<dynamic> generateroutes(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.HomeScreen:
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(create: (context) => charactersCubit,
            child: const home(),
          ),
          settings: settings,
        );

      case  AppConstants.characterDetails :
        // Assuming you have a CharacterDetailsScreen that takes an ID or character object
        final character = settings.arguments as CharacterModel; // or whatever type you use
        return MaterialPageRoute(
          builder: (context) => CharacterDetailsScreen(character: character),
          settings: settings,
        );





      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Not Found")),
          ),
          settings: settings,
        );
    }
  }
}
