import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:palindrome_flutter/models/user_model.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Maps extends StatefulWidget {
  List<UserModel> users = [];
  Maps({Key? key, required this.users}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final navigatorKey = GlobalKey<NavigatorState>();

  late CameraPosition _initialCameraPosition;
  MapboxMapController? _mapboxMapController;
  @override
  void initState() {
    super.initState();
    _initialCameraPosition = const CameraPosition(
      target: LatLng(
        -2.2760348,
        99.4616785,
      ),
      zoom: 2,
    );
  }

  // @override
  // void dispose() {
  //   _mapboxMapController?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    _onMapCreated(MapboxMapController controller) async {
      _mapboxMapController = controller;
    }

    Future<void> addImageFromUrl() async {
      for (var element in widget.users) {
        var response = await http.get(Uri.parse(element.avatar));
        _mapboxMapController!
            .addImage(element.id.toString(), response.bodyBytes);
      }
    }

    _onStyleLoaded() {
      addImageFromUrl();
    }

    _onCameraIdle() async {
      final List<SymbolOptions> symbolOptionsList = widget.users
          .map(
            (element) => SymbolOptions(
              geometry: LatLng(
                element.coordinate.lat,
                element.coordinate.lng,
              ),
              iconImage: element.id.toString(),
              textField: '${element.firstName} ${element.lastName}',
              textOffset: const Offset(0, 1.2),
              iconSize: 0.5,
              iconHaloWidth: 2,
            ),
          )
          .toList();
      await _mapboxMapController?.addSymbols(
        symbolOptionsList,
        widget.users.map((i) => {'count': i}).toList(),
      );
      _mapboxMapController?.onSymbolTapped.add((argument) {
        // UserModel userModel = argument.data!['count'];
        // final ctx = navigatorKey.currentState?.overlay?.context;
        // showDialog<String>(
        //   useSafeArea: true,
        //   context: ctx ?? context,
        //   useRootNavigator: false,
        //   barrierDismissible: false,
        //   builder: (BuildContext context) => alertDialog(userModel, context),
        // );
      });
    }

    return Stack(
      children: [
        MapboxMap(
          onMapCreated: _onMapCreated,
          accessToken:
              'sk.eyJ1IjoiYW5zb3JpIiwiYSI6ImNsNTd4OWl1bTBmN24zbHVreDBqd3lsb2EifQ.ipme0Z7USdq_QPiH__KuHA',
          initialCameraPosition: _initialCameraPosition,
          onCameraIdle: _onCameraIdle,
          onStyleLoadedCallback: _onStyleLoaded,
        ),
      ],
    );
  }
}
