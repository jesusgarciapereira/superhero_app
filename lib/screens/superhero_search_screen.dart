import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_details_response.dart';
import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:superhero_app/data/repository.dart';

class SuperHeroSearchScreen extends StatefulWidget {
  const SuperHeroSearchScreen({super.key});

  @override
  State<SuperHeroSearchScreen> createState() => _SuperHeroSearchScreenState();
}

class _SuperHeroSearchScreenState extends State<SuperHeroSearchScreen> {
  // late para inicializarlo más tarde
  //late Future<SuperheroResponse?> superheroInfo;
  Future<SuperheroResponse?>? superheroInfo;
  Repository repository = Repository();

  bool isTextEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Superhero Search")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Busca un superhéroe",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (textoEscrito) {
                setState(() {
                  isTextEmpty = textoEscrito.isEmpty;
                  superheroInfo = repository.fecthSuperheroInfo(textoEscrito);
                });
                // Para visualizar en la consola lo que escribimos
                // print("He escrito $textoEscrito");
              },
            ),
          ),
          bodyList(isTextEmpty),
        ],
      ),
    );
  }

  FutureBuilder<SuperheroResponse?> bodyList(bool isTextEmpty) {
    return FutureBuilder(
      future: superheroInfo,
      builder: (context, snapshot) {
        if (isTextEmpty) {
          return Center(child: Text("Ningún nombre introducido"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          var superheroList = snapshot.data?.result;
          // El itemCount es para optimizar el builder
          return Expanded(
            child: ListView.builder(
              itemCount: superheroList?.length ?? 0,
              itemBuilder: (context, index) {
                if (superheroList != null) {
                  return itemSuperhero(superheroList[index]);
                  //return Text(superheroList[index].name);
                } else {
                  return Text("Error");
                }
              },
            ),
          );
        } else {
          return Text("No hay resultados");
        }
      },
    );
  }

  Padding itemSuperhero(SuperheroDetailResponse item) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.red,
        ),
        child: Column(
          children: [
            // Para que se redondee la imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.url,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment(0, -0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
