import 'dart:convert';

import 'package:http/http.dart';
import 'package:servme_login_app/model/user.dart';
import 'package:servme_login_app/repository/database.dart';

class AuthService {

  AuthDatabase _authDatabase = AuthDatabase();
  User getUser(Map response) {
    return response != null && response['status'] != null && response['status'] == 'success' ? User(
      access_token: response['result']['access_token'],
      account_type_id: response['result']['account_type_id'],
      total_active_sessions: response['result']["total_active_sessions"],
      account_id: response['result']["account_id"],
      ambassador_id: response['result']["ambassador_id"],
    ) : null;
  }

  Future<User> signIn(String email, String password) async {
    try {
      Map<String, String> requestBody = { 'email': email,
        'password': password 
      };
      
      var uri = Uri.parse('');
      var request = MultipartRequest('Post', uri)..fields.addAll(requestBody);

      var response = await request.send();
      Map servmeResponse = jsonDecode(await response.stream.bytesToString());
      print(servmeResponse);
      User user = getUser(servmeResponse);
      if(user == null) {
        return null;
      } else {
        // TODO: add to local DB (cache)
        await _authDatabase.insert(user);
        return user;
      }
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> signOut(String accessToken) async {
    try {
      // TODO: Get Authentication from DB
      if(accessToken == null) {
        return '';
      }

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken'
      };

      Response response = await delete('', headers: headers);
      Map data = jsonDecode(response.body);
      print(data);
      if(data != null && data['status'] != null && data['status'] == 'success') {
        await _authDatabase.delete();
        return accessToken;
      } else {
        return null;
      }
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}