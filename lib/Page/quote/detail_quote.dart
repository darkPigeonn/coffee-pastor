import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/component/other.dart';
import 'package:flutter_coffee_application/resource/model/quote_model.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_share/flutter_share.dart';

class DetailQuote extends StatefulWidget {
  ModelQuote quote;
  DetailQuote({
    super.key,
    required this.quote,
  });

  @override
  State<DetailQuote> createState() => _DetailQuoteState();
}

bool isLoading = false;
int _currentSlide = 0;

class _DetailQuoteState extends State<DetailQuote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Quote"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FlutterShare.share(
                  title: widget.quote.title, text: "", linkUrl: "kosong");
            },
            icon: Icon(
              Icons.share,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.quote.title,
              style: h1(),
            ),
            Divider(
              thickness: 0.7,
              color: black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.quote.author,
                  style: body2(color: grey1),
                ),
                Text(
                  formatDate2(widget.quote.createdAt),
                  style: body2(
                    color: grey1,
                  ),
                ),
              ],
            ),
            16.height,
            CarouselSlider.builder(
              itemCount: widget.quote.images.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width * (9 / 16),
                aspectRatio: 16 / 9,
                initialPage: _currentSlide,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
                pauseAutoPlayOnTouch: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentSlide = index;
                  });
                },
              ),
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                      LoadImage(imageLink: widget.quote.images[itemIndex]),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.quote.images.length,
                (index) => Container(
                  width: index == _currentSlide ? 10 : 4,
                  height: 4,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: index == _currentSlide ? Colors.black : Colors.grey,
                    borderRadius: index == _currentSlide
                        ? BorderRadius.circular(2)
                        : BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            16.height,
            Text(
              widget.quote.description,
              style: body1(),
            ),
            16.height,
            Center(
              child: Container(
                width: 200,
                child: isLoading
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            textStyle: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await FlutterShare.share(
                            title: widget.quote.title,
                            text: "",
                            linkUrl: "kosong",
                          );
                          await Future.delayed(Duration(seconds: 1));
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Center(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Bagikan',
                                  style: h4(color: white),
                                ),
                                Icon(Icons.share, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
