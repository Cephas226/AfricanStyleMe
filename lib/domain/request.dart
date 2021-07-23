import 'package:http/http.dart' as http;

const urlBase = 'https://myafricanstyle.herokuapp.com/';

class Request{
  final String url;
  final dynamic body;

  Request({this.url,this.body});

  Future<http.Response> post() {
    return http.post(Uri.parse(urlBase+url), body: body).timeout(Duration(minutes: 2));
  }

  Future<http.Response> get(){
    print(urlBase+url);
    return http.get(Uri.parse(urlBase+url)).timeout(Duration(minutes: 2));
  }
}
class RequestController {
  String uri =
      "https://myafricanstyle.herokuapp.com/video";

  Future<String> getCookie() async {
    try {
      var response = await http.get(Uri.parse("https://m.tiktok.com/share/item/"));
      return response.headers["set-cookie"];
    } catch (e) {
      return "error";
    }
  }

  var headers = {
    "type": "5",
    "count": "30",
    "minCursor": "0",
    "maxCursor": "0",
    "lang": "en",
    "_signature": "pKb.ogAgEB9ImoSQahoqJKSm.rAAPox HTTP/1.1",
    "Accept": "application/json: text/plain: */*",
    "Sec-Fetch-Dest": "empty",
    "User-Agent":
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64 AppleWebKit/537.36 (KHTML: like Gecko Chrome/80.0.3987.149 Safari/537.36",
    "Origin": "https://www.tiktok.com",
    "Sec-Fetch-Site": "same-site",
    "Sec-Fetch-Mode": "cors",
    "Referer": "https://www.tiktok.com/trending/?lang",
    "Accept-Language": "en-GB:en-US;q",
  };

  void setCookie(String cookie) {
    headers["set-cookie"] = cookie;
  }
}