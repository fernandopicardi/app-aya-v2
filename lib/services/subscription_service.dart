import 'package:supabase_flutter/supabase_flutter.dart';

class SubscriptionService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getPlans() async {
    final response = await _supabase
        .from('plans')
        .select('id, name, description, price, duration')
        .order('price', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>?> getCurrentSubscription() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    final response = await _supabase
        .from('subscriptions')
        .select('id, plan_id, start_date, end_date, status')
        .eq('user_id', user.id)
        .eq('status', 'active')
        .single();
    return response;
  }

  Future<void> subscribeToPlan(String planId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    await _supabase.from('subscriptions').insert({
      'user_id': user.id,
      'plan_id': planId,
      'start_date': DateTime.now().toIso8601String(),
      'end_date':
          DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      'status': 'active',
    });
  }

  Future<void> cancelSubscription(String subscriptionId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado');
    await _supabase
        .from('subscriptions')
        .update({'status': 'cancelled'})
        .eq('id', subscriptionId)
        .eq('user_id', user.id);
  }
}
