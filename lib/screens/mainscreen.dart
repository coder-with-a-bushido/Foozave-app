import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foozave/models/foodModel.dart';
import 'package:foozave/widgets/fooddetailscreen.dart';

import 'package:foozave/utils/apireq.dart';

import 'package:foozave/utils/locationservices.dart';
import 'package:foozave/widgets/topbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ThemeData themeData;
  late LocationData coord;
  List<Food> foods = [];
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static final CameraPosition faoPlex = CameraPosition(
    target: LatLng(41.883024547179765, 12.489099763333797),
    zoom: 18.4746,
  );

  @override
  void initState() {
    requestPermission();
    populateMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return new Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: Set<Marker>.of(markers.values),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: faoPlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            child: TopBar(),
            top: 10,
            left: 5,
          )
        ],
        fit: StackFit.expand,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            heroTag: "tag1",
            backgroundColor: Color(0xffF6511F).withAlpha(220),
            onPressed: _goToMyLocation,
            child: Icon(Icons.my_location),
          ),
          SizedBox(
            width: 5,
          ),
          FloatingActionButton(
            heroTag: "tag2",
            backgroundColor: Colors.pinkAccent[700],
            onPressed: () {
              setState(() {
                markers = <MarkerId, Marker>{};
              });
              populateMarkers();
            },
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  addMarker(Food food) async {
    MarkerId markerId = MarkerId(food.id);
    Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(food.location.coordinates[0], food.location.coordinates[1]),
      onTap: () {},
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(10, 10),
          ),
          'assets/images/Doughnut_marker_small.png'),
      infoWindow: InfoWindow(
          onTap: () {
            showDialog(
                context: context, builder: (context) => FoodDetail(food: food));
          },
          title: food.name,
          snippet: food.description),
      draggable: false,
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  populateMarkers() {
    getReq().then((foodlist) async {
      if (foodlist != null) {
        coord = await getCurrentLocation();
        foodlist.forEach((food) {
          if (Geolocator.distanceBetween(coord.latitude!, coord.longitude!,
                  food.location.coordinates[0], food.location.coordinates[1]) <=
              10000) {
            foods.add(food);
          }
        });
        setState(() {
          foods.forEach((food) {
            addMarker(food);
          });
        });
      }
    });
  }

  Future<void> _goToMyLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData loc = await getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(
        loc.latitude!,
        loc.longitude!,
      ),
      zoom: 14.4746,
    )));
  }
}
