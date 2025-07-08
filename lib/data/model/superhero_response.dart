import 'package:superhero_app/data/model/superhero_details_response.dart';

class SuperheroResponse {
  final String response;
  final List<SuperheroDetailResponse> result;

  SuperheroResponse({required this.response, required this.result});

  factory SuperheroResponse.fromJson(Map<String, dynamic> json) {
    // Para listados necestarás esto:
    var list = json["results"] as List;
    List<SuperheroDetailResponse> heroList = list
        .map((hero) => SuperheroDetailResponse.fromJson(hero))
        .toList();

    return SuperheroResponse(response: json["response"], result: heroList);
  }
}
