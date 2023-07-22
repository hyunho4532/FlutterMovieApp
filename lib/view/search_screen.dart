import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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

  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();


  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

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

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polygon_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add (
      Polyline (
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points.map(
                (point) => LatLng(point.latitude, point.longitude),
        ).toList(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row (
            children: [
              Expanded (
                child: Column (
                  children: [
                    TextFormField(
                      controller: _originController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: '도시를 입력해주세요.',
                      ),
                      onChanged: (value) {},
                    ),

                    TextFormField(
                      controller: _destinationController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: '도시를 입력해주세요.',
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () async {
                  var directions = await LocationService().getDirections (
                      _originController.text, _destinationController.text,
                  );

                  _goToPlace (
                    directions['start_location']['lat'],
                    directions['start_location']['lng'],
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );

                  _setPolyline (
                    directions['polyline_decoded']
                  );
                },
                icon: const Icon(Icons.search)
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
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

  Future<void> _goToPlace(Map<String, dynamic> boundsNe, Map<String, dynamic> boundsSw, double lat, double lng) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera (
        CameraUpdate.newCameraPosition (
          CameraPosition(target: LatLng(lat, lng), zoom: 12),
        )
    );

    controller.animateCamera (
      CameraUpdate.newLatLngBounds (
        LatLngBounds (
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
        ),
        25
      ),
    );

    _setMarker (
      LatLng(lat, lng)
    );
  }
}
