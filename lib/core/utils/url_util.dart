import 'package:url_launcher/url_launcher.dart';

class UrlUtil {
  static Future<bool> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
