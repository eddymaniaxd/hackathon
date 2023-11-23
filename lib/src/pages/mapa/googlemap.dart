import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:topicos_proy/src/Controllers/map_controller.dart';

class MapaGoogle extends StatelessWidget {
  const MapaGoogle({super.key});
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider<MapController>(
        create: (_) => MapController(),
        child: Consumer<MapController>(
          builder: (_, controller, __) => Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Google Map')),
          ),
          floatingActionButton: Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  FloatingActionButton(
                    heroTag: "current_position",
                    child: const Icon(Icons.location_on_outlined),
                    onPressed: () async {
                      await controller.getCurrentLocation();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(
                      heroTag: "marker",
                    child: const Icon(Icons.add_alert_sharp),
                    onPressed: () {
                      //print(controller.locationSelected);
                      Navigator.pushNamed(context, "alerta_temprana", arguments: controller.locationSelected);
                    },
                  ),
                ],
              )
            ],
          ),
          body: GoogleMap(
              onMapCreated: controller.onMapCretted,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: controller.initialCamarePosition,
              onTap: controller.onTap,
              markers: controller.markers,
              circles: controller.circles,
            ),
          ),
        ));
  }
}

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider')),
      body: Slider(
        value: _currentSliderValue,
        max: 100,
        divisions: 5,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }
}

void showAlerta(BuildContext context, String title, String description) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

// class MapaGoogle extends StatefulWidget {
//   const MapaGoogle({super.key});

//   @override
//   State<MapaGoogle> createState() => _MapaGoogleState();
// }

// class _MapaGoogleState extends State<MapaGoogle> {
//   MapController googleMapController = MapController();
//   List<Marker> myMarkers = [];
//   double tamCircle = 400;
//   LatLng? lugarCirculo;

//   @override
//   void initState() {
//     super.initState();

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Text('Google Map')),
//       ),
//       body: GoogleMap(
//           onMapCreated: googleMapController.onMapCretted,
//           myLocationButtonEnabled: true,
//           myLocationEnabled: true,
//           mapType: MapType.normal,
//           initialCameraPosition: googleMapController.initialCamarePosition,
//           onTap: googleMapController.onTap,
//           markers: googleMapController.markers,
//           ),
//     );
//   }

//   _handleTap(LatLng tappedPoint) {
   
//     setState(() {
//       myMarkers = [];
//       myMarkers.add(
//         Marker(
//             markerId: MarkerId(tappedPoint.toString()), position: tappedPoint),
//       );
//       lugarCirculo = tappedPoint;
//       cargarCircle(tappedPoint);
//     });
//   }

//   void cargarCircle(posicion) {
//     CircleId c = CircleId('1');
//     Circle circulo = Circle(
//         circleId: c,
//         center: posicion,
//         radius: tamCircle,
//         strokeWidth: 2,
//         strokeColor: Colors.green,
//         fillColor: Colors.green.withAlpha(70));
//     // myCircle[c] = circulo;
//   }
// }
