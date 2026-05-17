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
<<<<<<< HEAD

=======
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
  LatLng currentLocation = const LatLng(33.6844, 73.0479); // default
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
<<<<<<< HEAD
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
=======
    final position = await LocationService.getCurrentLocation();

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      loading = false;
    });
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD

    return Scaffold(
      backgroundColor: const Color(0xFFD8BBA9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD8BBA9),
        foregroundColor: const Color(0xFF6D4C41),
        title: const Text('Order Tracking'),
      ),
=======
    return Scaffold(
      appBar: AppBar(title: const Text("Order Tracking")),
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
<<<<<<< HEAD

=======
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
              options: MapOptions(
                initialCenter: currentLocation,
                initialZoom: 15,
              ),

              children: [
<<<<<<< HEAD

                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.cuphub',
=======
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
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
<<<<<<< HEAD
}
=======
}
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
