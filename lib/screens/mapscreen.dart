import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:adoptini/screens/detailspage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static String id = "MapScreen";

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Widget _child = const Center(
    child: CircularProgressIndicator(
      color: Colors.indigo,
      strokeWidth: 5,
    ),
  );

  late Position position;

  Widget _mapWidget() {
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: Set<Marker>.of(markers.values),
      onMapCreated: (GoogleMapController controller) {
        myController = controller;
      },
      initialCameraPosition: CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 12.0),
    );
  }

  void _getCurrentLocation() async {
    Position res = await Geolocator.getCurrentPosition();
    setState(() {
      position = res;
      _child = _mapWidget();
    });
  }

  late GoogleMapController myController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId) async {
    Future<Uint8List> getBytesFromAsset(String path) async {
      double pixelRatio = MediaQuery.of(context).devicePixelRatio;
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetWidth: pixelRatio.round() * 50);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
    }

    final Uint8List markerIcon = await getBytesFromAsset('assets/paw.png');
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      icon: BitmapDescriptor.fromBytes(markerIcon),
      markerId: markerId,
      position: LatLng(specify['latitude'], specify['longitude']),
      infoWindow: InfoWindow(
        title: specify['petName'],
      ),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    FirebaseFirestore.instance.collection('pets').get().then((myData) {
      if (myData.docs.isNotEmpty) {
        for (var i = 0; i < myData.docs.length; i++) {
          initMarker(myData.docs[i], myData.docs[i]['petName']);
        }
      }
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    getMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(body: _child),
      ),
    );
  }
}
