abstract class BaseApiServices {
  Future<dynamic> getApi(String url, {String? token});
  Future<dynamic> postAPi(String url, var data, {String? token});
  Future<dynamic> putApi(String url, var data, {String? token});
  Future<dynamic> deleteApi(String url, {String? token});
}
