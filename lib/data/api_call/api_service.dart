import 'package:bloc_practise/constant/Strings.dart';
import 'package:bloc_practise/data/models/character_model.dart';
import 'package:dio/dio.dart';

class api_service{

  late Dio dio;

  api_service() {
    dio = Dio(BaseOptions(
      baseUrl:AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      receiveDataWhenStatusError: true,
    ));
  }
  Future<List<dynamic>> getCharacters() async {
    try {
      final response = await dio.get(AppConstants.characterEndPoint);
      print('Response data: ${response.data}');
      // استخرج 'results' اللي هي القائمة الحقيقية للشخصيات:
      return response.data['results'] as List<dynamic>;
    } catch (e) {
      print('Failed to load characters: $e');
      return [];
    }
  }



}
