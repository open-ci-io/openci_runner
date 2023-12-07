import 'dart:io';

import 'package:openci_runner/src/features/job/domain/job_data.dart';
import 'package:openci_runner/src/features/user/domain/user_data.dart';
import 'package:supabase/supabase.dart';

class SupabaseService {
  SupabaseService({
    required this.supabaseUrl,
    required this.supabaseApiKey,
  }) : _supabase = SupabaseClient(supabaseUrl, supabaseApiKey);

  final String supabaseUrl;
  final String supabaseApiKey;
  final SupabaseClient _supabase;

  GoTrueClient get _auth => _supabase.auth;

  static final _platformSuffix = Platform.isLinux ? 'android' : 'ios';

  Future<AuthResponse> supabaseSignIn({
    required String email,
    required String password,
  }) async =>
      _auth.signInWithPassword(email: email, password: password);

  Future<String> userId(AuthResponse result) async {
    final userId = result.user?.id;

    if (userId == null) {
      throw Exception('Supabase UserID is Null');
    }
    return userId;
  }

  Future<JobData?> fetchSingleJob(String userId) async {
    final data = await _supabase
        .from('jobs')
        .select<dynamic>()
        .eq('user_id', userId)
        .eq('is_under_processing_$_platformSuffix', true)
        .eq('has_been_successfully_finished_$_platformSuffix', true)
        .eq('has_been_finished_with_failure_$_platformSuffix', false)
        .limit(1)
        .maybeSingle() as Map<String, dynamic>?;
    if (data == null) {
      return null;
    }

    return JobData.fromJson(data);
  }

  Future<void> updateIsUnderProcessing(JobData job) async {
    await _supabase
        .from('jobs')
        .update({
          'is_under_processing_$_platformSuffix': true,
        })
        .eq('id', job.id)
        .select<dynamic>();
  }

  Future<UserData?> fetchUserData(JobData job) async {
    final data = await _supabase
        .from('users')
        .select<dynamic>()
        .eq('github_repository_url', job.github_repository_url)
        .single() as Map<String, dynamic>;

    return UserData.fromJson(data);
  }

  Future<void> incrementBuildNumber(UserData user) async {
    if (Platform.isLinux) {
      await _supabase.from('users').update({
        'android_build_number': user.android_build_number + 1,
      }).eq('user_id', userId);
    } else {
      await _supabase.from('users').update({
        'ios_build_number': user.ios_build_number + 1,
      }).eq('user_id', userId);
    }
  }

  Future<void> setBuildSuccess(JobData job) async {
    await _supabase.from('jobs').update({
      'has_been_successfully_finished_$_platformSuffix': true,
    }).eq('id', job.id);
  }

  Future<void> setBuildFailure(JobData job) async {
    await _supabase.from('jobs').update({
      'has_been_finished_with_failure_$_platformSuffix': true,
    }).eq('id', job.id);
  }
}
