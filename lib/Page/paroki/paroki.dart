import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/paroki/detail/DeskripsiPage.dart';
import 'package:flutter_coffee_application/Page/paroki/detail/KontakPage.dart';
import 'package:flutter_coffee_application/Page/paroki/detail/LokasiPage.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/other.dart';
import 'package:flutter_coffee_application/resource/provider/data_provider.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';


class DetailParoki extends ConsumerStatefulWidget {
  final String id;

  DetailParoki({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  ConsumerState<DetailParoki> createState() => _DetailParokiState();
}

class _DetailParokiState extends ConsumerState<DetailParoki> {
  int _selectedIndex = 0;
  late List<Widget> screens = [];

  @override
  void initState() {
    screens = [
      DeskripsiPage(id: widget.id),
      LokasiPage(id: widget.id),
      KontakPage(id: widget.id),
    ];
    super.initState();
  }

  var listBottomNavigation = [
    BottomNavigationBarItem(
      icon: Icon(Icons.insights_rounded),
      label: 'Deskripsi',
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: 'Lokasi',
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.call),
      label: 'Kontak',
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        items: listBottomNavigation,
        currentIndex: _selectedIndex,
        selectedItemColor: primary,
        onTap: _onItemTapped,
      ),
      body: ref.watch(detailParokiData(widget.id)).when(
            data: (data) => SafeArea(
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      var res = await checkInternetConnectivity(context);
                      if (res) {
                        //TODO: implement refresh data here
                      }
                    },
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailParokiView(
                            frontImage: data.images != null
                                ? data.images!.isNotEmpty
                                    ? data.images![0]
                                    : "noImage"
                                : "noImage",
                            logo: data.logo != null ? data.logo! : "noImage",
                            name: data.churchName!,
                            address: data.address != null ? data.address! : "Alamat tidak ditemukan",
                          ),
                          screens[_selectedIndex],
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(0),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () => finish(context),
                      borderRadius: BorderRadius.circular(24),
                      splashColor: Colors.grey,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            error: (error, stackTrace) {
              print(error);
              print(stackTrace);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tidak dapat menemukan data",
                      style: body3(color: grey),
                    ),
                    16.height,
                    IconButton(
                      onPressed: () async {
                        final res = await checkInternetConnectivity(context);
                        if (res) {
                          await ref.refresh(detailParokiData(widget.id).future);
                        }
                      },
                      icon: Icon(Icons.refresh),
                    )
                  ],
                ),
              );
            },
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
