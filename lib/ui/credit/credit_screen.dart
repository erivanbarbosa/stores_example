import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/stores/webview/webview_store.dart';
import 'package:redesprou_boilerplate_name/widgets/default_appbar.dart';
import 'package:redesprou_boilerplate_name/widgets/generic_circular_progress_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  _CreditScreenState createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebviewStore _webviewStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _webviewStore = Get.find();
    _webviewStore.getCreditUrl();
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: Colors.white,
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: DefaultAppBar(
        title: "credits",
      ),
    );
  }

  Widget _buildBody() {
    return Observer(builder: (context) => _webviewStore.loading ? GenericCircularProgressIndicator() : _buildWebview());
  }

  WebView _buildWebview() {
    return WebView(
      initialUrl: _webviewStore.creditUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) => _controller.complete(webViewController),
      gestureNavigationEnabled: true,
    );
  }
}