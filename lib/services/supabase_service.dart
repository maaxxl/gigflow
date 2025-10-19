import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  late final SupabaseClient client;

  factory SupabaseService() => _instance;

  SupabaseService._internal();

  Future<void> init({required String url, required String anonKey}) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
    client = Supabase.instance.client;
  }

  // simple helper examples
  Future<List<Map<String, dynamic>>> fetchEvents() async {
    final res = await client.from('events').select().order('start_at');
    return List<Map<String, dynamic>>.from(res as List);
  }

  Future<void> insertTask(Map<String, dynamic> task) async {
    await client.from('tasks').insert(task);
  }

  // --- Auth helpers ---
  Future<AuthResponse> signIn(String email, String password) async {
    final res = await client.auth.signInWithPassword(email: email, password: password);
    return res;
  }

  Future<AuthResponse> signUp(String email, String password) async {
    final res = await client.auth.signUp(email: email, password: password);
    return res;
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

  User? currentUser() {
    return client.auth.currentUser;
  }
}
