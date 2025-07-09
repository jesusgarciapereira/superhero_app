import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_details_response.dart';

class SuperheroDetailsScreen extends StatelessWidget {
  final SuperheroDetailResponse superhero;

  const SuperheroDetailsScreen({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Superhero {{ ${superhero.name} }}")),
      body: Column(
        children: [
          Image.network(
            superhero.url,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: Alignment(0, -0.6),
          ),
          Text(superhero.name, style: TextStyle(fontSize: 28)),
          Text(
            superhero.realName,
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
          SizedBox(
            width: double.infinity,
            height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildStat('power', Colors.red),
                buildStat('strength', Colors.grey),
                buildStat('intelligence', Colors.blue),
                buildStat('speed', Colors.green),
                buildStat('durability', Colors.deepOrange),
                buildStat('combat', Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildStat(String statName, Color color) {
    String value = '0';

    switch (statName) {
      case 'power':
        value = superhero.powerStatsResponse.power;
        break;
      case 'strength':
        value = superhero.powerStatsResponse.strength;
        break;
      case 'intelligence':
        value = superhero.powerStatsResponse.intelligence;
        break;
      case 'speed':
        value = superhero.powerStatsResponse.speed;
        break;
      case 'durability':
        value = superhero.powerStatsResponse.durability;
        break;
      case 'combat':
        value = superhero.powerStatsResponse.combat;
        break;
      default:
        value = '0';
    }

    // Poner la primera letra en mayúscula
    final label = '${statName[0].toUpperCase()}${statName.substring(1)}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(height: double.parse(value), width: 20, color: color),
        Text(label),
      ],
    );
  }
}
