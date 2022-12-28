// Dart imports:
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// // Package imports:
// import 'package:http/http.dart' as http;
//
// // Project imports:
// import 'package:efada/utils/CustomAppBarWidget.dart';
// import 'package:efada/utils/Utils.dart';
// import 'package:efada/utils/apis/Apis.dart';
// import 'package:efada/utils/model/Transport.dart';
// import 'package:efada/utils/widget/TransportRow.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:url_launcher/url_launcher.dart';

// class TransportScreen extends StatefulWidget {
//   @override
//   _TransportState createState() => _TransportState();
//
// }
//
// class _TransportState extends State<TransportScreen> {
//   CameraPosition initialPos = CameraPosition(
//       target: LatLng(29.9774450, 31.0996500), zoom: 18.0);
//   GoogleMapController _controller;
//   Future<TransportList> transports;
//   Marker myMarker;
//   String _token;
//
//   @override
//   void dispose() {
//     if (_controller != null) {
//       _controller.dispose();
//     }
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     Utils.getStringValue('token').then((value) {
//       setState(() {
//         _token = value;
//       });
//     })
//       ..then((value) {
//         transports = getAllTransport();
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBarWidget(title: 'Transport'),
//         backgroundColor: Colors.white,
//         body: buildMap(context));
//   }
//
//   Widget buildMap(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: initialPos,
//             myLocationButtonEnabled: true,
//             markers: {if (myMarker != null) myMarker},
//             onMapCreated: (controller) {
//               _controller = controller;
//
//               setState((){
//                 addMarker(29.9774450,31.0996500);
//               });
//               return _controller;
//             },
//           ),
//           Positioned(child:
//               InkWell(
//                 onTap: () async {
//
//                   await canLaunch(
//                       'tel:+201555433933')
//                   // ignore: deprecated_member_use
//                       ? await launch(
//                       'tel:+201555433933')
//                       : throw 'Could not launch +201555433933';
//
//                 },
//                 child: Card(
//                   margin: EdgeInsets.all(16.0),
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     height: 56.0,
//                     child: Row(
//                       children: [
//                         Icon(Icons.call,color: Colors.amber,size: 20,),
//                         SizedBox(width: 8,),
//                         Text("call_driver".tr)
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//           ),
//
//         ],
//       ),
//     );
//   }
//
//   /* @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBarWidget(title: 'Transport'),
//         backgroundColor: Colors.white,
//         body: FutureBuilder<TransportList>(
//           future: transports,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               if (snapshot.data.transports.length > 0) {
//                 return ListView.builder(
//                   itemCount: snapshot.data.transports.length,
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   itemBuilder: (context, index) {
//                     return TransportRow(snapshot.data.transports[index]);
//                   },
//                 );
//               } else {
//                 return Utils.noDataWidget();
//               }
//             } else {
//               return Center(
//                 child: CupertinoActivityIndicator(),
//               );
//             }
//           },
//         ));
//   }*/
//
//   Future<TransportList> getAllTransport() async {
//     final response = await http.get(Uri.parse(InfixApi.studentTransportList),
//         headers: Utils.setHeader(_token.toString()));
//
//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);
//
//       return TransportList.fromJson(jsonData['data']);
//     } else {
//       throw Exception('Failed to load');
//     }
//   }
//
//
//   /// Determine the current position of the device.
//   ///
//   /// When the location services are not enabled or permissions
//   /// are denied the `Future` will return an error.
//   Future<Position> _determinePosition() async {
//     print("LocationStarted");
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }
//
//   Marker addMarker(double lat, double lng) {
//     myMarker = Marker(markerId: MarkerId("myMarker"),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         position: LatLng(lat, lng)
//     );
//     _controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 18));
//   }
//
// }


