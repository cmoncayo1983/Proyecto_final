import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_final/application_layer/person.dart';

class MapScreen extends StatefulWidget {
  final Person person;

  const MapScreen(this.person, {Key? key}) : super(key: key);

  @override
  MapState createState() => MapState();
}

class MapState extends State<MapScreen> {
  late GoogleMapController mapController;

  late LatLng _center;
  late Marker markerPerson;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();

    final LatLng initialPosition =
        _parseLatLog(widget.person.direccion.toString());
    _center = initialPosition;

    markerPerson = Marker(
      markerId: const MarkerId('Casa'),
      position: initialPosition,
      infoWindow: const InfoWindow(title: 'Casa'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      draggable: true,
    );
  }

  LatLng _parseLatLog(String latLog) {
    final latLngList = latLog.split(',');
    final lat = double.parse(latLngList[0]);
    final lng = double.parse(latLngList[1]);
    return LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dirección'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12.0),
            //color: Colors.blue,
            /*  shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ), */
            shadowColor: Colors.black,
            elevation: 10,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.greenAccent,
                    Colors.white70,
                  ],
                  stops: [0.0, 1.0],
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(12.0, 12.0),
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659651_1280.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15.00),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            widget.person.name,
                            style: const TextStyle(
                              fontSize:
                                  20.0, // Puedes ajustar este valor según tu preferencia
                              fontWeight: FontWeight
                                  .bold, // Puedes ajustar esto también
                            ),
                          ),
                          Center(child: Text(widget.person.cargo)),
                          const SizedBox(height: 15.00),
                          Text('Edad: ${widget.person.age}'),
                          const SizedBox(height: 5.00),
                          const Text('{widget.person.nui}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: {markerPerson},
            ),
          ),
        ],
      ),
    );
  }
}
