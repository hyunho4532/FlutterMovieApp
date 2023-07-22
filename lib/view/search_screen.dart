import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movie_app_project/api/google/location/location_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => MapSampleState();
}

class MapSampleState extends State<SearchScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final TextEditingController _searchController = TextEditingController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(37.42796133580664, -122.085749655962),
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final Marker _kLateMarker = Marker(
    markerId: const MarkerId('_kLateMarker'),
    infoWindow: const InfoWindow(title: 'Lake'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: const LatLng(37.43296265331129, -122.08832357078792),
  );

  static const Polyline _kPolyLine = Polyline(
    polylineId: PolylineId('_kPolyLine'),
    points: [
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.43296265331129, -122.08832357078792),
    ],
    width: 5,
  );

  static const Polygon _kPolyGon = Polygon(
    polygonId: PolygonId('_kPolygon'),
    points: [
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.43296265331129, -122.08832357078792),
      LatLng(37.418, -122.092),
      LatLng(37.435, -122.092),
    ],
    strokeWidth: 5,
    fillColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: '도시를 입력해주세요.',
                ),
                onChanged: (value) {},
              )),
              IconButton(
                  onPressed: () async {
                    var place = await LocationService().getPlace(_searchController.text);

                    _goToPlace(place);
                  },
                  icon: const Icon(Icons.search)),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {_kGooglePlexMarker, _kLateMarker},
              polylines: {
                _kPolyLine,
              },
              polygons: {
                _kPolyGon,
              },
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 12),
    ));
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
