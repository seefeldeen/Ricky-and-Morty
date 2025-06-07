import 'package:bloc_practise/Presentation/widgets/homecard.dart';
import 'package:bloc_practise/business_logic/characters_cubit.dart';
import 'package:bloc_practise/constant/Strings.dart';
import 'package:bloc_practise/data/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
   bool is_searching = false;
   String search_text = "";
   List<CharacterModel> search_results = [];
   List<CharacterModel> ALLcharacters = [];
    late TextEditingController Search_controller ;

  @override
  void initState() {
    Search_controller = TextEditingController();
    super.initState();
    BlocProvider.of<CharactersCubit>(context).fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.greyyy,
      appBar: AppBar(
         backgroundColor: AppConstants.yellooow,
        title: is_searching ? Buildsearchfield() : Text("Rick and Morty Characters"),
        actions: ShowaAppBarIcons(),

      ),

      body:
      OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget? child,
              ) {
            final bool connected = !connectivity.contains(
                ConnectivityResult.none);
            return connected
                ? BuildblocProvider()
                :
            buildnointernetscreen();

          },
          child: Center(
            child: CircularProgressIndicator(),

          ),


      ),
    );
}

  Widget Buildsearchfield(){
    return TextFormField(
      controller:  Search_controller,
      decoration: InputDecoration(
        border: InputBorder.none,
         hintText: "Search Characters",
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
      ),
    ),
      onChanged: ( value) {
          setState(() {
          is_searching = true;
          search_text = value;
          Searchingmethod(search_text);
        });
      },
    );


  }
   void Startsearching() {
     ModalRoute.of(context)!.addLocalHistoryEntry(
       LocalHistoryEntry(
         onRemove: () {
           setState(() {
             is_searching = false;
             search_text = "";
             Search_controller.clear();
             search_results = [];
           });
         },
       ),
     );
     setState(() {
       is_searching = true;
     });
   }


   List<Widget> ?ShowaAppBarIcons() {
     if(is_searching == true) {
       return [
         IconButton(onPressed: (
             ){
           Navigator.pop(context);
         }, icon: Icon(Icons.clear)),
       ];

     }
     else {
       return [
         IconButton(onPressed: (){
           setState(() {
             Startsearching();
           });
         }, icon: Icon(Icons.search)),
       ];
     }
   }

  void Searchingmethod(search_text){

    search_results = ALLcharacters.where((character) {
      return
     character.name.toLowerCase().startsWith(search_text.toLowerCase());
    }).toList();
    setState(() {
    });
  }


  Widget BuildblocProvider() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is loadedCharacters) {
          ALLcharacters = (state).characters;
          if (is_searching && search_text.isNotEmpty) {
            return DisplayGrid(search_results);
          }
          return DisplayGrid(state.characters);
        } else if (state is CharactersInitial) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Text(
              "Error loading characters",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          );
        }
      },
    );
  }




Widget DisplayGrid(List<CharacterModel> characters) {
  return
    Container(decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24.0),
    ),
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 16.0,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return
         homecard(character: character);
      },
        ),
    );
}

  buildnointernetscreen() {
    return Center(
      child: Image.asset("assets/images/undraw_connected-world_anke.png")
    );
  }


}