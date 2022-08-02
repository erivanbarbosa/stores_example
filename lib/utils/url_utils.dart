import 'package:redesprou_boilerplate_name/utils/message_utils.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(String url) async {
  await canLaunch(url) ? await launch(url) : showErrorMessage("Não foi possivel abrir a url");
}
