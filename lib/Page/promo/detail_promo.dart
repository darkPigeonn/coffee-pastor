import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_coffee_application/checkinternet.dart';
import 'package:flutter_coffee_application/component/Format/DateFormat.dart';
import 'package:flutter_coffee_application/component/ImageLoader.dart';
import 'package:flutter_coffee_application/component/TextField.dart';
import 'package:flutter_coffee_application/component/komentar.dart';
import 'package:flutter_coffee_application/component/show_dialog.dart';
import 'package:flutter_coffee_application/resource/const_resource.dart';
import 'package:flutter_coffee_application/resource/provider/comment_provider.dart';
import 'package:flutter_coffee_application/resource/provider/promo_provider.dart';
import 'package:flutter_coffee_application/resource/services/api/comment_services.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_coffee_application/style/typhography.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_share/flutter_share.dart';

class DetailPromo extends ConsumerStatefulWidget {
  final GestureTapCallback onPressedLikeIcon;
  String promoId;
  int index;
  DetailPromo({
    super.key,
    required this.onPressedLikeIcon,
    required this.promoId,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailPromoState();
}

class _DetailPromoState extends ConsumerState<DetailPromo> {
  bool isLoading = false;
  final comment = TextEditingController();
  final commentNode = FocusNode();
  bool validate = false;
  bool enable = false;

  @override
  void initState() {
    comment.addListener(validateInputs);
    commentNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    comment.dispose();
    commentNode.removeListener(_onFocusChange);
    commentNode.dispose();
    super.dispose();
  }

  void validateInputs() {
    if (comment.text.isEmpty) {
      setState(() {
        enable = false;
      });
    } else {
      setState(() {
        enable = true;
      });
    }
  }

  void _onFocusChange() {
    debugPrint("comment Focus: ${commentNode.hasFocus.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentProvider(widget.promoId));
    return ref.watch(detailPromoProvider(widget.promoId)).when(
          data: (data) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Detail Promo"),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () async {
                      await FlutterShare.share(
                          title: data.title, text: "", linkUrl: "kosong");
                    },
                    icon: Icon(
                      Icons.share,
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: h1(),
                      ),
                      Divider(
                        thickness: 0.7,
                        color: black,
                      ),
                      Text(
                        formatDate2(data.createdAt),
                        style: body2(
                          color: grey1,
                        ),
                      ),
                      16.height,
                      LoadImage(imageLink: data.image),
                      12.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: widget.onPressedLikeIcon,
                            child: Icon(
                              ref.watch(likePromo)[widget.index]
                                  ? Icons.thumb_up_off_alt_rounded
                                  : Icons.thumb_up_off_alt_outlined,
                              color: ref.watch(likePromo)[widget.index]
                                  ? primary
                                  : grey1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.comment,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                      16.height,
                      Text(
                        data.description,
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
                                      title: data.title,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Bagikan',
                                            style: h4(color: white),
                                          ),
                                          Icon(Icons.share,
                                              color: Colors.white),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      16.height,
                      Text(
                        "Komentar",
                        style: h2(),
                      ),
                      16.height,
                      comments.when(
                        data: (data) {
                          return Container(
                            height: 200,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return KomentarIcon(
                                    name: data[index].name,
                                    content: data[index].comment,
                                    imageUser: data[index].image);
                              },
                            ),
                          );
                        },
                        error: (error, e) {
                          if (error.toString() == "204") {
                            return SizedBox(
                              child: Center(
                                child: Container(
                                    padding: EdgeInsets.all(32),
                                    child: Text(
                                      "Belum ada yang menulis komentar",
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
                                          await checkInternetConnectivity(
                                              context);
                                      if (result) {
                                        await ref.refresh(promoProvider.future);
                                      }
                                    },
                                    icon: Icon(Icons.refresh_rounded,
                                        color: primary),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        loading: () => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      16.height,
                      DescTextField(
                        controller: comment,
                        textInputType: TextInputType.multiline,
                        error: validate ? "belum diisi" : null,
                        hint: "Comment",
                        focus: commentNode,
                        onPressed: () async {
                          if (comment.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Belum menulis komentar'),
                              ),
                            );
                            return;
                          }

                          // Check internet connectivity
                          bool result =
                              await checkInternetConnectivity(context);
                          if (result) {
                            try {
                              showDialogLoading(context);
                              Map<String, dynamic> response =
                                  await CommentServices()
                                      .createComment(
                                          comment.text, widget.promoId)
                                      .timeout(Duration(seconds: apiWaitTime));
                              await ref.refresh(
                                  commentProvider(widget.promoId).future);
                              comment.clear();
                              FocusScope.of(context).unfocus();
                              Navigator.pop(context);
                              if (response['code'] == 200) {
                                successDialog(
                                  context,
                                  () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  "Sukses",
                                  "Berhasil Menambah Comment",
                                );
                              } else if (response['code'] == 412) {
                                errorDialog(
                                  context,
                                  () {
                                    Navigator.of(context).pop();
                                  },
                                  "Gagal Menambah Comment",
                                  response['message'],
                                );
                              }
                            } on TimeoutException {
                              Navigator.pop(context);
                            } catch (e) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: $e'),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No internet connectivity.'),
                              ),
                            );
                          }
                        },
                      ),
                      16.height,
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, e) {
            if (error.toString() == "204") {
              return SizedBox(
                child: Center(
                  child: Container(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        "Belum ada produk yang tersedia",
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
                        bool result = await checkInternetConnectivity(context);
                        if (result) {
                          await ref.refresh(promoProvider.future);
                        }
                      },
                      icon: Icon(
                        Icons.refresh_rounded,
                        color: primary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
