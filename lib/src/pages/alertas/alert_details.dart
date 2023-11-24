
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:topicos_proy/src/util/Files.dart';
import 'package:topicos_proy/src/widget/style_text_rich.dart';

class AlertDetail extends StatefulWidget {
  const AlertDetail({super.key});

  @override
  State<AlertDetail> createState() => _AlertaDetailState();
}

class _AlertaDetailState extends State<AlertDetail> {

  @override
  Widget build(BuildContext context) {
    dynamic detailDenuncia = ModalRoute.of(context)!.settings.arguments;
    print(detailDenuncia);
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Detalle denuncia'),
          ),
          elevation: 10,
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            const Center(
              child: Text(
                "DETALLE DENUNCIA",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Card(
                elevation: 8.0,
                color: Colors.green[200],
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyleTextRich(title: "Nombre: ", subtitle: detailDenuncia["description"],),
                      const Divider(
                        height: 10.0,
                        color: Colors.green
                      ),
                      StyleTextRich(title: "Fecha: ", subtitle: detailDenuncia["date"]),
                      const Divider(
                        height: 10.0,
                        color: Colors.green
                      ),
                      StyleTextRich(title: "Hora: ", subtitle: detailDenuncia["hour"]),
                      
                    ],
                   ),
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 0.0),
               child: ElevatedButton(
                onPressed: () {
                  LatLng position = LatLng(detailDenuncia['latitude'], detailDenuncia['longitude']);
                  print(position);
                  Navigator.pushNamed(context, 'map');
                  //Navigator.pushNamed(context, "map", arguments: position);
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                ),
                child: const Text(
                  "Ver ubicación",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
             ),
             const SizedBox(
              height: 10.0,
             ),
             const Center(
               child: Text(
                  "Imágenes",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
             ),
             _gallery(detailDenuncia['image_url'])
          ],
        )
    );
  }

  

  _gallery(images) {
    // ignore: unnecessary_null_comparison
    if (images == null || images.isEmpty) {
      return const Text("");
    }

    return SizedBox(
      height: 350.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: Files.loadImage(images[index]),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if(snapshot.hasData){
                  return Container(
                    height: 350,
                    width: 350,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.0)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapshot.data!)
                        )
                    ),
                  );
                }
                return const SizedBox(
                  height: 300,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Center(
                      child: CircularProgressIndicator()),
                  )
                );
              },
            );
          }),
    );
  }
}
