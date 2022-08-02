import 'package:redesprou_boilerplate_name/data/network/apis/web_view_api.dart';
import 'package:mobx/mobx.dart';

part 'webview_store.g.dart';

class WebviewStore = _WebviewStore with _$WebviewStore;

abstract class _WebviewStore with Store {
  @observable
  String? insuranceUrl;

  @observable
  String? creditUrl;

  @observable
  bool loading = false;

  WebViewApi webViewApi = WebViewApi();

  @action
  getInsuranceUrl() async {
    loading = true;
    String url = await webViewApi.findInsuranceUrl().whenComplete(() => loading = false);
    insuranceUrl = url;
  }

  @action
  getCreditUrl() async {
    loading = true;
    String url = await webViewApi.findCreditUrl().whenComplete(() => loading = false);
    creditUrl = url;
  }
}
