import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WayStationPage extends StatefulWidget {
  const WayStationPage({super.key});

  @override
  State<WayStationPage> createState() => _WayStationPageState();
}

class _WayStationPageState extends State<WayStationPage> {
  late MapboxMap mapboxMap;
  CameraOptions? _cameraOptions;
  late PointAnnotationManager _pointAnnotationManager;
  List<Point> bikeLocations = [
    Point(coordinates: Position(108.243, 16.0285)), // Hà Nội
    Point(coordinates: Position(108.246, 16.0288)),
    Point(coordinates: Position(108.244, 16.0278)),
  ];
  Future<void> addBikeMarkers(List<Point> locations) async {
    final ByteData bytes = await rootBundle.load('assets/bike.png');
    final Uint8List imageData = bytes.buffer.asUint8List();

    _pointAnnotationManager = await mapboxMap.annotations
        .createPointAnnotationManager();

    for (var location in locations) {
      final PointAnnotationOptions options = PointAnnotationOptions(
        geometry: location,
        image: imageData,
        iconSize: 1.0,
      );
      await _pointAnnotationManager.create(options);
    }
  }

  _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    this.mapboxMap.location.updateSettings(
      LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );
    addBikeMarkers(bikeLocations);
    // Tạo PointAnnotationManager
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
    initSocket();
  }

  void _initLocation() async {
    final status = await geo.Geolocator.requestPermission();
    if (status == geo.LocationPermission.always ||
        status == geo.LocationPermission.whileInUse) {
      var position = await geo.Geolocator.getCurrentPosition();

      setState(() {
        _cameraOptions = CameraOptions(
          center: Point(
            coordinates: Position(position.longitude, position.latitude),
          ),
          zoom: 14.0,
        );
      });
    } else {
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Cần quyền truy cập vị trí"),
            content: const Text(
              "Ứng dụng cần quyền truy cập vị trí để hiển thị bản đồ. "
              "Vui lòng cấp quyền trong phần Cài đặt.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Đóng"),
              ),
              TextButton(
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
                child: const Text("Mở Cài đặt"),
              ),
            ],
          ),
        );
      }
    }
  }

  final socket = IO.io('http://localhost:8080', <String, dynamic>{
    'path': '/socket/tracking',
    'transports': ['websocket'],
    'autoConnect': false,
  });

  void initSocket() {
    socket.connect();

    socket.onConnect((_) => print('Connected'));
    socket.onDisconnect((_) => print('Disconnected'));
    socket.onError((data) => print("socket err =====" + data.toString()));
    socket.on('bikes:update', (data) {
      print('=========Live bike data: $data');
      // Vẽ lại marker trên bản đồ Mapbox ở đây
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cameraOptions == null
          ? const Center(child: CircularProgressIndicator())
          : MapWidget(
              key: ValueKey("mapWidget"),
              cameraOptions: _cameraOptions,
              onMapCreated: _onMapCreated,
            ),
    );
  }
}
