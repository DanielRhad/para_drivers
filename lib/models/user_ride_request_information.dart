import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserRideRequestInformation
{
  LatLng? originLatLng;
  LatLng? destinationLatLng;
  String? originAddress;
  String? destinationAddress;
  String? rideRequestId;
  String? userName;

  UserRideRequestInformation({
    this.originLatLng,
    this.destinationLatLng,
    this.originAddress,
    this.destinationAddress,
    this.rideRequestId,
    this.userName,
  });
}