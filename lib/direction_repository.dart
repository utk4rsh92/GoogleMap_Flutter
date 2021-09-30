import 'package:demo/directions_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionRepository{
  static const String baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
  final Dio _dio;
  DirectionRepository ({required Dio dio}) : _dio = dio ??Dio();

  Future<Directions?> getDirections({
   required LatLng origin,
   required LatLng destination,

}
) async{
    final response = await _dio.get(baseUrl,
    queryParameters: {
      'origin' : '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': 'AIzaSyDg636IaeS2l6Kmh_yGDLh0FhRgojGZcn0',
    },
    );
    if(response.statusCode == 200){
      return Directions.fromMap(response.data);
    }

   return null;

  }

}
