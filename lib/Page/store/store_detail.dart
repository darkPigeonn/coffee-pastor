import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Toast/show_toast.dart';
import 'package:flutter_coffee_application/resource/model/store_model.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailStore extends ConsumerStatefulWidget {
  final ModelStore store;
  const DetailStore({super.key, required this.store});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailStoreState();
}

class _DetailStoreState extends ConsumerState<DetailStore> {
  late GoogleMapController mapController;
  bool isMapLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Store"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.store.lokasi == null
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
                                        widget.store.lokasi.latitude,
                                        widget.store.lokasi.longitude,
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
                                      markerId: MarkerId(widget.store.nama),
                                      position: LatLng(
                                        widget.store.lokasi.latitude,
                                        widget.store.lokasi.longitude,
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.store.nama.toUpperCase(),
                    style: custom(
                      fontSize: 22,
                      bold: FontWeight.w500,
                    ),
                  ),
                  12.height,
                  InkWell(
                    onTap: () async {
                      String googleUrl =
                          'https://www.google.com/maps/search/?api=1&query=${widget.store.lokasi.latitude},${widget.store.lokasi.longitude}';
                      if (await canLaunchUrlString(googleUrl)) {
                        await launchUrlString(googleUrl);
                      } else {
                        showToast("Tidak bisa membuka map");
                      }
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dapatkan Alamat",
                            style: custom(
                                fontSize: 16,
                                bold: FontWeight.normal,
                                color: primary),
                          ),
                          Text(
                            widget.store.nama.toUpperCase(),
                            style: custom(
                              fontSize: 16,
                              bold: FontWeight.normal,
                            ),
                          ),
                          Text(
                            widget.store.lokasi.alamat,
                            style: custom(
                              fontSize: 16,
                              bold: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  12.height,
                  InkWell(
                    onTap: () {
                      launchUrlString(
                          "tel://${widget.store.phone.toString().padLeft(12, '0')}");
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hubungi Sekarang",
                            style: custom(
                                fontSize: 16,
                                bold: FontWeight.normal,
                                color: primary),
                          ),
                          Text(
                            widget.store.phone.toString().padLeft(12, '0'),
                            style: custom(
                              fontSize: 16,
                              bold: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  12.height,
                  Text(
                    "Jam Buka",
                    style: custom(
                        fontSize: 16, bold: FontWeight.normal, color: primary),
                  ),
                  Text(
                    "MON - SUN : 07:00 - 22:00",
                    style: custom(
                      fontSize: 16,
                      bold: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
