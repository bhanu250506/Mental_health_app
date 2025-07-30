

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_chat/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  final String? token;
  final bool isLoading;
  final String? error;

  AuthState({
    this.token,
    this.isLoading = false,
    this.error
});
}


class AuthNotifier extends StateNotifier<AuthState> {
  final ApiService _apiService = ApiService();

  AuthNotifier() : super(AuthState()){
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if(token!=null){
      state = AuthState(token: token);
    }
  }

  Future<bool> login(String email, String password) async {
    state = AuthState(isLoading: true);
    try{
      final response = await _apiService.post('auth/login', {'email': email, 'password': password});
      if(response['success']){
        final token = response['data']['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        state = AuthState(token: token);
        return true;
      }else {
        state = AuthState(error: response['message']);
        return false;
      }

    }catch (e){
      state = AuthState(error: e.toString());
      return false;
    }
  }
  
  Future<bool> signup(String email, String password) async{
    state = AuthState(isLoading: true);
    try{
      final response = await _apiService.post('auth/signup', {'email': email, 'password': password});
      if(response['success']){
        return await login(email, password);
      }else{
        state = AuthState(error: response['message']);
        return false;
      }
    }catch(e){
      state = AuthState(error: e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
