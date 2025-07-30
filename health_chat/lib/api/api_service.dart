import 'dart:convert';
import 'package:health_chat/utils/constant.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String _baseUrl = Constant.baseURL;

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data , {String? token}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _getHeaders(token),
      body: json.encode(data),
    );
    return _processResponse(response);
  }


  Future<Map<String, dynamic>> get(String endpoint, {String? token}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _getHeaders(token),
    );
    return _processResponse(response);
  }

  Map<String, String> _getHeaders(String? token){
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if(token!= null){
      headers['x-auth-token'] = token;
    }
    return headers;
  }

  Map<String, dynamic> _processResponse(http.Response response){
    try{
      final body = json.decode(response.body);
      if(response.statusCode>= 200 && response.statusCode <300){
        return {'success' : true, 'data' : body};
      } else {
        return {'success': false, 'message': body['msg'] ?? 'An unknown error occurred'};
      }
    } catch(e){
      return {'success': false, 'message': 'Failed to process server response.'};

    }
  }
}