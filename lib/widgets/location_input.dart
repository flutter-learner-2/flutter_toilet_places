import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function selectPlace;

  LocationInput(this.selectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  double _lat;
  double _lng;
  // LatLng _currentLatLng;

  void _showPlaceMapPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
      _lat = lat;
      _lng = lng;
      // _currentLatLng = LatLng(location.latitude, location.longitude);
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final location = await Location().getLocation();
      _showPlaceMapPreview(location.latitude, location.longitude);
      widget.selectPlace(location.latitude, location.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) {
      return;
    }
    _showPlaceMapPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen!',
                  textAlign: TextAlign.center,
                )
              // : Image.network(
              //     _previewImageUrl,
              //     fit: BoxFit.cover,
              //     width: double.infinity,
              //   ),
              : Text(
                  'latitude: $_lat, longitude: $_lng',
                  textAlign: TextAlign.center,
                ),
          // child: _currentLatLng == null
          //     ? Text(
          //         'No location chosen!',
          //         textAlign: TextAlign.center,
          //       )
          //     : MapPreview(_currentLatLng),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectMap,
            ),
          ],
        ),
      ],
    );
  }
}
