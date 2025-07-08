import 'dart:convert';

import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:http/http.dart'
    as http; // Lo miré en la web https://pub.dev/packages/http

class Repository {
  Future<SuperheroResponse?> fecthSuperheroInfo(String name) async {
    final response = await http.get(
      Uri.parse(
        "https://www.superheroapi.com/api.php/26d77e9970551b589702c03b1bb7778f/search/$name",
      ),
    );

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      SuperheroResponse superheroResponse = SuperheroResponse.fromJson(
        decodedJson,
      );
      return superheroResponse;
    } else {
      return null;
      //throw Exception("Ha ocurrido un error");
    }
  }
}
