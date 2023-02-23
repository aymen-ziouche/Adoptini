import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:adoptini/modules/pet.dart';
import 'package:adoptini/providers/petProvider.dart';
import 'package:adoptini/screens/detailspage.dart';
import 'package:adoptini/widgets/listItemWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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
      mapType: MapType.terrain,
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
      onTap: () {
        final snackbar = SnackBar(
          content: InkWell(
            onTap: () {
              Pet pet = Pet(
                  longitude: specify['longitude'],
                  latitude: specify['latitude'],
                  favorites: specify['favorites'],
                  ownerId: specify['ownerId'],
                  petId: specify['petId'],
                  type: specify['petType'],
                  size: specify['petSize'],
                  image: specify['petImage'],
                  name: specify['petName'],
                  breed: specify['petBreed'],
                  gender: specify['petGender'],
                  age: specify['petAge'],
                  description: specify['petDescription']);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => PetsProvider(),
                    child: DetailsPage(
                      pet: pet,
                    ),
                  ),
                ),
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Expanded(
                child: ListItem(
                    imageUrl: specify['petImage'],
                    name: specify['petName'],
                    breed: specify['petBreed'],
                    gender: specify['petGender'],
                    age: specify['petAge'],
                    description: specify['petDescription']),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
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
