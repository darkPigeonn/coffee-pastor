import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/store/store_detail.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Store/store_body.dart';
import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/model/store_model.dart';
import 'package:flutter_coffee_application/resource/provider/store_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shimmer/shimmer.dart';

class StorePage extends ConsumerStatefulWidget {
  const StorePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StorePageState();
}

class _StorePageState extends ConsumerState<StorePage> {
  Position? currentPosition;
  late GoogleMapController mapController;
  bool isMapLoading = true;

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Lokasi Non-Aktif',
        text:
            'Tidak dapat mendapatkan lokasi anda, silahkan aktifkan layanan lokasi anda',
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Layanan Lokasi Ditolak',
          text:
              'Tidak dapat mendapatkan lokasi anda, silahkan aktifkan layanan lokasi anda',
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Layanan Lokasi Ditolak Permanen',
        text:
            'Tidak dapat mendapatkan lokasi anda, silahkan aktifkan layanan lokasi anda',
      );
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Tidak Ada Akses',
        text: 'Pastikan akses lokasi diaktifkan untuk perangkat ini',
      );
      return;
    }
    try {
      final position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .timeout(Duration(seconds: apiWaitTime));
      setState(() {
        currentPosition = position;
      });
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error data: $e',
      );
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295; // Pi / 180
    const c = cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  List<ModelStore> sortStoresByDistance(List<ModelStore> stores) {
    if (currentPosition == null) return stores;

    stores.sort((a, b) {
      final distanceA = calculateDistance(
        currentPosition!.latitude,
        currentPosition!.longitude,
        a.lokasi.latitude,
        a.lokasi.longitude,
      );
      final distanceB = calculateDistance(
        currentPosition!.latitude,
        currentPosition!.longitude,
        b.lokasi.latitude,
        b.lokasi.longitude,
      );
      return distanceA.compareTo(distanceB);
    });

    return stores;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store"),
        centerTitle: true,
      ),
      body: ref.watch(storeProvider).when(
            data: (data) {
              if (currentPosition == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final sortedData = sortStoresByDistance(data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sortedData.isEmpty || sortedData[0].lokasi == null
                      ? Text(
                          "Lokasi belum tersedia",
                          style: body3(
                            color: Colors.grey,
                          ),
                        )
                      : Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  zoomControlsEnabled: false,
                                  buildingsEnabled: false,
                                  indoorViewEnabled: false,
                                  tiltGesturesEnabled: false,
                                  zoomGesturesEnabled: false,
                                  rotateGesturesEnabled: false,
                                  scrollGesturesEnabled: false,
                                  mapToolbarEnabled: true,
                                  myLocationEnabled: true,
                                  myLocationButtonEnabled: true,
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                        sortedData[0].lokasi.latitude,
                                        sortedData[0].lokasi.longitude,
                                      ),
                                      zoom: 16),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    mapController = controller;
                                    setState(() {
                                      isMapLoading = false;
                                    });
                                  },
                                  markers: {
                                    Marker(
                                      markerId: MarkerId(sortedData[0].nama),
                                      position: LatLng(
                                        sortedData[0].lokasi.latitude,
                                        sortedData[0].lokasi.longitude,
                                      ),
                                    )
                                  },
                                ),
                              ),
                            ),
                            if (isMapLoading)
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                  16.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Cafe Terdekat",
                      style: custom(
                        fontSize: 24,
                        bold: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: sortedData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => DetailStore(
                            store: sortedData[index],
                          ).launch(context),
                          child: StoreBody(
                            store: sortedData[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            error: (error, e) {
              if (error.toString() == "204") {
                return SizedBox(
                  child: Center(
                    child: Container(
                        padding: EdgeInsets.all(32),
                        child: Text(
                          "Belum ada lokasi cafe yang tersedia",
                          style: body2(
                            color: Colors.grey,
                          ),
                        )),
                  ),
                );
              }
              return Center(
                child: Column(
                  children: [
                    Container(
                      child: IconButton(
                        onPressed: () async {
                          bool result =
                              await checkInternetConnectivity(context);
                          if (result) {
                            await ref.refresh(storeProvider.future);
                          }
                        },
                        icon: Icon(Icons.refresh_rounded, color: primary),
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
          ),
    );
  }
}
