//Packages
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
//Model
import 'package:moviesapp/model/app_config.dart';

class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;
  late String base_url;
  late String api_key;

  //Hier werden die appconfig-Variablen mit dem Paket get_it initialisiert.
  HTTPService() {
    AppConfig config = getIt.get<AppConfig>();
    base_url = config.BASE_API_URL;
    api_key = config.API_KEY;
  }

  //Funktion, die Anfragen erhält und Antworten sendet.
  Future<Response?> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String _url = '$base_url$path';
      Map<String, dynamic> _query = {
        'api_key': api_key,
        'language': 'en-US',
      };
      if (query != null) {
        _query.addAll(query);
      }
      return await dio.get(_url, queryParameters: _query);
    } on DioError catch (e) {
      print('Unable to perform get request.');
      print('DioError:$e');
    }
    return null;
  }
}
