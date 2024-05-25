import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/theme/mythemes.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String articleUrl;
  final String articleName;
  const ArticleView(
      {super.key, required this.articleUrl, required this.articleName});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  WebViewController controller = WebViewController();
  int loadingProgress = 0;

  @override
  void initState() {
    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingProgress = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingProgress = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingProgress = 100;
          });
        },
        onWebResourceError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Some unexpected error occurred'),
            ),
          );
        },
      ),
    );
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse(widget.articleUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.disabled)
    //   ..loadRequest(Uri.parse(widget.articleUrl.toString()));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.articleName,
          style: MyTheme.myTheme.textTheme.displayMedium,
        ),
        centerTitle: false,
        elevation: .1,
        actions: [
          IconButton(
              onPressed: () async {
                await Share.share(
                  'Read the article : ${widget.articleName}\n Link : ${widget.articleUrl}',
                );
              },
              icon: const Icon(CupertinoIcons.share)),
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Feature not added'),
                    duration: Durations.extralong4,
                  ),
                );
              },
              icon: const Icon(CupertinoIcons.heart))
        ],
        bottom:
            const PreferredSize(preferredSize: Size(0, 6), child: SizedBox()),
      ),
      body: Column(
        children: [
          if (loadingProgress < 100)
            LinearProgressIndicator(
              value: loadingProgress / 100,
              color: Colors.grey.shade100,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black38),
            ),
          if (loadingProgress < 100)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.black87, size: 40),
                    const SizedBox(height: 20),
                    Text(
                      "Loading the article 🕊️",
                      style: MyTheme.myTheme.textTheme.displayMedium,
                    )
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: WebViewWidget(
                controller: controller,
              ),
            ),
        ],
      ),
    );
  }
}
