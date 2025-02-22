import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(widget.latitude, widget.longitude),
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.google.com/vt/lyrs=m&hl={hl}&x={x}&y={y}&z={z}',
          additionalOptions: const {'hl': 'en'},
          subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(widget.latitude, widget.longitude),
              child: Icon(
                Icons.location_on,
                size: 25,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
