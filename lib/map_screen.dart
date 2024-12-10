import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Marker? _marker;
  Polyline _polyline = Polyline(
    polylineId: PolylineId('route'),
    points: [],
    color: Colors.blue,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _animateToLocation();
  }

  void _animateToLocation() {
    LatLng initialLocation =
        LatLng(23.80070479475878, 90.41949853157644); // Dhaka, Bangladesh
    LatLng newLocation = LatLng(
        23.81389803740036, 90.42379829242492); // Another location in Dhaka

    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: initialLocation,
          zoom: 15,
        ),
      ),
    );
    _updateLocationMarker(initialLocation);

    // Wait 10 seconds before moving to new location
    Future.delayed(Duration(seconds: 10), () {
      _updateLocationMarker(newLocation);
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: newLocation,
            zoom: 15,
          ),
        ),
      );
    });
  }

  void _updateLocationMarker(LatLng latLng) {
    setState(() {
      _marker = Marker(
        markerId: MarkerId('currentLocation'),
        position: latLng,
        infoWindow: InfoWindow(
          title: 'My current location',
          snippet: '${latLng.latitude}, ${latLng.longitude}',
        ),
      );
      _polyline = Polyline(
        polylineId: PolylineId('route'),
        points: [..._polyline.points, latLng],
        color: Colors.blue,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-Time Location'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 1,
        ),
        markers: _marker != null ? {_marker!} : {},
        polylines: {_polyline},
      ),
    );
  }
}
