import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Googlemaps());
}

class Googlemaps extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Googlemaps> {
  final Set<Marker> _markers = <Marker>{};

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kFirstLocation = CameraPosition(
    target: LatLng(46.54245, 24.55747),
    zoom: 14.4746,
  );

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Location location = Location();

  String? id;

  @override
  void initState() {
    super.initState();
    addFirstGeoPoint();
    updateGeoPointInFirebase();
    //readGeoPositions();
    updateGeoMarkers();
  }

  void addFirstGeoPoint() async {
    LocationData locationData = await location.getLocation();
    print('Init: $locationData');

    final collection = firestore.collection('locations');

    DocumentReference documentRef = collection.doc();

    await documentRef.set(
      {'Latitude': locationData.latitude, 'Longitude': locationData.longitude},
    ).then((value) => {id = documentRef.id});

    var ID = id;
    print('ID: $ID');
  }

  void updateGeoPointInFirebase() {
    location.onLocationChanged.listen(
      (LocationData loc) {
        print('Changed: $loc');

        final collectionRef = firestore.collection('locations');
        if (id != null) {
          // FirebaseFirestore.instance
          //     .collection('locations')
          //     .doc(id)
          //     .get()
          //     .then((DocumentSnapshot dc) => {
          //           dc.get(FieldPath(const ['Latitude']))
          //         });

          collectionRef.doc(id).set(
            {'Latitude': loc.latitude, 'Longitude': loc.longitude},
          );
        }
      },
    );
  }

  Future<void> rejectJob() {
    return FirebaseFirestore.instance.collection('locations').doc(id).delete();
  }

  void readGeoPositions() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('locations');
    getData(_collectionRef);
  }

  Future<void> getData(CollectionReference _collectionRef) async {
    QuerySnapshot querySnapshot = await _collectionRef.get();

    final allData = querySnapshot.docs.asMap();

    for (var doc in allData.entries) {
      double lat = doc.value.get('Latitude');
      double lng = doc.value.get('Longitude');
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId(doc.value.id),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.defaultMarker,
        ));
      });
    }
  }

  void updateGeoMarkers() {
    firestore.collection('locations').snapshots().listen((query) {
      query.docChanges.forEach((element) {
        double lat = element.doc.get('Latitude');
        double lng = element.doc.get('Longitude');
        if (id == element.doc.id) {
          print('ElementID: $lat');
          print('ElementID: $lng');
        }

        setState(() {
          _markers.removeWhere((e) => e.markerId.value == element.doc.id);
          _markers.add(Marker(
            markerId: MarkerId(element.doc.id),
            position: LatLng(lat, lng),
            icon: BitmapDescriptor.defaultMarker,
          ));
          print(_markers.length);
        });
      });
    });
  }

  @override
  void dispose() {
    print('Disposed');
    _markers.clear();
    rejectJob();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          markers: _markers,
          myLocationEnabled: true,
          initialCameraPosition: _kFirstLocation,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
