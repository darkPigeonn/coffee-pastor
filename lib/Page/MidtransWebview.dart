import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/Page/order/payment_fail.dart';
import 'package:flutter_coffee_application/Page/order/payment_success.dart';
import 'package:flutter_coffee_application/style/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MidtransWebview extends ConsumerStatefulWidget {
  final String url;
  const MidtransWebview({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MidtransWebviewState();
}

class _MidtransWebviewState extends ConsumerState<MidtransWebview> {
  var loadingPercentage = 0;
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // Platform-specific WebView parameters
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _webViewController = controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (String url) {
            if (url.contains('result=success')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const PaymentSuccess();
                  },
                ),
              );
            }
            if (url.contains('result=failed')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const PaymentFail();
                  },
                ),
              );
            }
            setState(() {
              loadingPercentage = 0;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            final host = Uri.parse(request.url).host;
            if (host.contains('gojek://') ||
                host.contains('shopeeid://') ||
                host.contains('//wsa.wallet.airpay.co.id/') ||
                host.contains('/gopay/partner/') ||
                host.contains('/shopeepay/') ||
                host.contains('/pdf')) {
              _launchInExternalBrowser(Uri.parse(request.url));
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _launchInExternalBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: WebViewWidget(
                controller: _webViewController,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: primary), 
                child: Text('Exit',
                    style: TextStyle(color: Colors.white)), 
              ),
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
                color: primary, 
              ),
          ],
        ),
      ),
    );
  }
}
