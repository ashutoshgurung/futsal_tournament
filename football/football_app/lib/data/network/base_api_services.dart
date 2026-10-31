abstract class BaseApiServices {
  Future<dynamic> getApi(String url);
  Future<dynamic> postAPi(String url, var data);
  
}
