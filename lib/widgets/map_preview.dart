// import 'package:flutter/material.dart';
// import 'package:latlong/latlong.dart';
// import 'package:flutter_map/flutter_map.dart';

// class MapPreview extends StatelessWidget {
//   final LatLng currentLatlng;

//   MapPreview(this.currentLatlng);

//   @override
//   Widget build(BuildContext context) {
//     return FlutterMap(
//       options: MapOptions(
//         center: currentLatlng,
//         zoom: 16.0,
//       ),
//       layers: [
//         TileLayerOptions(
//           urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//           subdomains: ['a', 'b', 'c'],
//         ),
//         MarkerLayerOptions(
//           markers: [
//             Marker(
//               width: 30.0,
//               height: 30.0,
//               point: currentLatlng,
//               builder: (ctx) => Container(
//                 child: FlutterLogo(),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
