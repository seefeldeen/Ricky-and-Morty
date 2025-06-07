import 'package:bloc_practise/constant/Strings.dart';
import 'package:flutter/material.dart';
import 'package:bloc_practise/data/models/character_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailsScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // خلفية ناعمة
      body:
      Container(color: AppConstants.greyyy,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              expandedHeight: 800,
              pinned: true,
              backgroundColor: Colors.amber,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(character.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                    )),
                background: Hero(
                  tag: character.name, // تأكد تستخدم نفس الـ tag في الصفحة السابقة لو استخدمت Hero Animation
                  child: Image.network(
                    character.image,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                buildDetailRow("Status", character.status),
                customdivider(340),
                buildDetailRow("Species", character.species),
                customdivider(320),
                buildDetailRow("Gender", character.gender),
                customdivider(300),
                buildDetailRow("Origin", character.originName),
                customdivider(200),
                buildDetailRow("Location", character.locationName),
                customdivider(150),
                const SizedBox(height: 40),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const
      EdgeInsets.symmetric(horizontal: 16.0,),
      child: Row(
        children: [
          Text("$title: ",
              style: TextStyle(fontWeight: FontWeight.bold,
                   color: AppConstants.whiteee,
                   fontSize: 24)),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 20,
                    color: AppConstants.whiteee,
                ), overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}


Widget customdivider(double dd) {
  return Divider(color: AppConstants.yellooow,
    height: 25, thickness: 4,
    endIndent: dd,indent: 24,);
}
