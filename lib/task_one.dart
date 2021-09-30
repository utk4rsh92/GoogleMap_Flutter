import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:global_snack_bar/global_snack_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'direction_repository.dart';
import 'directions_model.dart';

class TaskOne extends StatefulWidget {
  const TaskOne({Key? key}) : super(key: key);

  @override
  _TaskOneState createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  static const _initialCameraPosition =
  CameraPosition(target: LatLng(32.1641059, 75.9034681), zoom: 11.5);
  late BitmapDescriptor customIcon;
  late GoogleMapController _googleMapController;
  Marker? _origin = null;
  Marker? _destination = null;
  Directions? _info = null;
  late GoogleMapController mapController;
  late BitmapDescriptor customIcon1;
  Set<Marker> markers = {};
  late PolylinePoints polylinePoints;
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
   double? stlat = null;
   double? stlong  = null;
  List<Marker> myMarker = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
        'assets/boy.png')
        .then((d) {
      customIcon = d;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
        'assets/destination.png')
        .then((c) {
      customIcon1 = c;
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Locator"),
        actions: [
          TextButton(
            onPressed: () => _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: _origin!.position,
                    zoom: 14.5,
                    tilt: 50.0),
              ),
            ),
            child: Text('ORIGIN',style: TextStyle(color: Colors.white),),
          ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: _origin!.position, zoom: 14.5, tilt: 50.0),
                ),
              ),
              child: Text('DEST',style: TextStyle(color: Colors.white),),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(

            myLocationEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: _onMapCreated,
            markers: {
              if (_origin != null) _origin!,
              if (_destination != null) _destination!
            },
            polylines: {
              if (_info != null)
                Polyline(
                    polylineId: PolylineId('overview_polyline'),
                    visible: true,
                    color: Colors.red,
                    width: 5,
                    points: _info!.polylinePoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList()),
            },
            onTap: _addMarker,
            // onLongPress: _handleTap,
          ),
          if (_info != null)
            Positioned(
              top: 20,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info!.totalDistance}, ${_info!.totalDuration}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  // _handleTap(LatLng tappedPoint) {
  //   print(tappedPoint);
  //   setState(() {
  //     myMarker = [];
  //     myMarker.add(
  //       Marker(
  //         icon:
  //             BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //         markerId: MarkerId(tappedPoint.toString()),
  //         position: tappedPoint,
  //         draggable: true,

  //       ),
  //     );
  //   });
  // }

  void _addMarker(LatLng pos) async {

   


    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          position: pos,
          infoWindow: const InfoWindow(title: 'You are starting from this location '),
          icon: customIcon,
        );
        _destination = null;

        _info = null;
      });
      print('details are-${pos.latitude},${pos.longitude}');
    } else {

      print('details are -${pos.latitude},${pos.longitude}');
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: customIcon1,
          //BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,

        );
         stlat = pos.latitude;
         stlong = pos.longitude;
      });
     /* double distance  = await Geolocator.distanceBetween();
      double distanceInKiloMeters = distance / 1000;
      double roundDistanceInKM =
      double.parse((distanceInKiloMeters).toStringAsFixed(2));

      print('Total distance is - ${roundDistanceInKM} Km');*/

      final directions = await DirectionRepository(dio: Dio())
          .getDirections(origin: _origin!.position, destination: pos);
      setState(() {

        print('Location is:-${_info}');
        _info = directions;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  void calculateDist() {}
}
