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

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();

  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  void initState() {
    super.initState();
    
    _setMarker (
      LatLng(37.42796133580664, -122.085749655962),
    );
  }

  void _setMarker (LatLng point) {
    setState(() {
      _markers.add (
        Marker(markerId: MarkerId('marker'), position: point),
      );
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygons.add (
      Polygon (
          polygonId: PolygonId(polygonIdVal),
          points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      )
    );
  }

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
              markers: _markers,
              polygons: _polygons,

              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point) {
                setState(() {
                  polygonLatLngs.add(point);
                  _setPolygon();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera (
        CameraUpdate.newCameraPosition (
          CameraPosition(target: LatLng(lat, lng), zoom: 12),
        )
    );

    _setMarker (
      LatLng(lat, lng)
    );
  }
}
