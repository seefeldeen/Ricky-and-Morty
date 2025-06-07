import 'package:bloc_practise/data/models/character_model.dart';
import 'package:flutter/material.dart';

import '../../constant/Strings.dart';

class homecard extends StatelessWidget {
  const homecard({super.key, required this.character});
    final CharacterModel character;
  @override
  Widget build(BuildContext context) {
    return  InkWell(onTap: (){
      Navigator.pushNamed(context, AppConstants.characterDetails,arguments: character);

    },
      child: GridTile(
          child:
          Container(
            padding: EdgeInsets.all(4.0),
            decoration:
            BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
            ),
            child:  character.image.isNotEmpty
                ? FadeInImage.assetNetwork(placeholder :"assets/images/Animation - 1749033706199.gif",
              image: character.image,fit: BoxFit.fill,width: double.infinity,
            )
                : Image.asset("assets/images/Animation - 1749033706199.gif",fit: BoxFit.fill,width: double.infinity,),
          ),
          footer: Container(
              width:  double.infinity,
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.all(8.0),
              color: AppConstants.greyyy.withOpacity(0.7),
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold  ,
                    color: AppConstants.whiteee),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,)

          )
      ),
    );
  }
}
