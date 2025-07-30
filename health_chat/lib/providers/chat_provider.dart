


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_service.dart';
import '../models/chat_message.dart';
import '../models/exercise.dart';
import '../models/mood.dart';
import '../models/quote.dart';
import 'auth_provider.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;
  ChatState({this.messages = const [], this.isLoading = false, this.error});
}

class ChatNotifier extends StateNotifier<ChatState> {
  final ApiService _apiService;
  final String? _token;
  ChatNotifier(this._apiService, this._token) : super(ChatState(messages: [
    ChatMessage(text: 'Hello! I\'m Aura. How can I support you today?', sender: Sender.bot)
  ]));

  Future<void> sendMessage(String message) async {
    if (_token == null) return;
    state = ChatState(messages: [...state.messages, ChatMessage(text: message, sender: Sender.user)], isLoading: true);
    try {
      final response = await _apiService.post('chat', {'message': message}, token: _token);
      if(response['success']) {
        final reply = response['data']['reply'];
        state = ChatState(messages: [...state.messages, ChatMessage(text: reply, sender: Sender.bot)], isLoading: false);
      } else {
        state = ChatState(messages: state.messages, isLoading: false, error: response['message']);
      }
    } catch (e) {
      state = ChatState(messages: state.messages, isLoading: false, error: e.toString());
    }
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final token = ref.watch(authProvider).token;
  return ChatNotifier(ApiService(), token);
});

// Quotes Provider
final quotesProvider = FutureProvider<List<Quote>>((ref) async {
  final apiService = ApiService();
  final response = await apiService.get('quotes');
  if (response['success']) {
    final data = response['data'] as List;
    return data.map((item) => Quote.fromJson(item)).toList();
  } else {
    throw Exception(response['message']);
  }
});

// Exercises Provider
final exercisesProvider = FutureProvider<List<Exercise>>((ref) async {
  final apiService = ApiService();
  final response = await apiService.get('exercises');
  if (response['success']) {
    final data = response['data'] as List;
    return data.map((item) => Exercise.fromJson(item)).toList();
  } else {
    throw Exception(response['message']);
  }
});

// Mood History Provider
class MoodHistoryNotifier extends StateNotifier<AsyncValue<List<Mood>>> {
  final ApiService _apiService;
  final String? _token;

  MoodHistoryNotifier(this._apiService, this._token) : super(const AsyncValue.loading()) {
    fetchMoods();
  }

  Future<void> fetchMoods() async {
    if (_token == null) {
      state = const AsyncValue.data([]);
      return;
    }
    try {
      final response = await _apiService.get('moods', token: _token);
      if (response['success']) {
        final data = response['data'] as List;
        state = AsyncValue.data(data.map((item) => Mood.fromJson(item)).toList());
      } else {
        state = AsyncValue.error(response['message'] ?? 'Failed to load moods', StackTrace.current);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addMood(String mood) async {
    if (_token == null) return;
    try {
      final response = await _apiService.post('moods', {'mood': mood, 'date': DateTime.now().toIso8601String()}, token: _token);
      if (response['success']) {
        await fetchMoods(); // Refresh the list
      } else {
        // Handle error if needed, maybe set an error state
      }
    } catch (e) {
      // Handle error
    }
  }
}

final moodHistoryProvider = StateNotifierProvider<MoodHistoryNotifier, AsyncValue<List<Mood>>>((ref) {
  final token = ref.watch(authProvider).token;
  return MoodHistoryNotifier(ApiService(), token);
});
