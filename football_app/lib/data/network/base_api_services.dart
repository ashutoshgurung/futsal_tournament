abstract class BaseApiServices {
  Future<dynamic> getApi(String url,{String? token});
  Future<dynamic> postAPi(String url, var data, {String? token});
}
