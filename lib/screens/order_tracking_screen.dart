import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../services/location_service.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {

  LatLng currentLocation = const LatLng(33.6844, 73.0479); // default
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        loading = false;
      });
    } catch (e) {
      // Fallback location if permission denied
      setState(() {
        loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not get location. Using default.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFD8BBA9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD8BBA9),
        foregroundColor: const Color(0xFF6D4C41),
        title: const Text('Order Tracking'),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(

              options: MapOptions(
                initialCenter: currentLocation,
                initialZoom: 15,
              ),

              children: [

                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.cuphub',
                ),

                MarkerLayer(
                  markers: [
                    Marker(
                      point: currentLocation,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}