import 'package:mason_logger/mason_logger.dart';
import 'package:openci_runner/src/features/job/domain/job_data.dart';
import 'package:openci_runner/src/features/sign_in/domain/sign_in.dart';
import 'package:openci_runner/src/features/user/domain/user_data.dart';
import 'package:openci_runner/src/services/supabase/supabase_service.dart';

class SignInController {
  SignInController(this._logger);
  final Logger _logger;
  Future<UserData> signIn(JobData job, SupabaseService supabase) async {
    // await supabase.updateIsUnderProcessing(job);
    final user = await supabase.fetchUserData(job);
    if (user == null) {
      _logger.err('User is Null');
      throw Exception('User is Null');
    }
    return user;
  }

  Future<JobData?> fetchJob({
    required SupabaseService supabase,
    required SignIn signIn,
  }) async {
    final result = await supabase.supabaseSignIn(
      email: signIn.email,
      password: signIn.password,
    );
    final userId = await supabase.fetchUserId(result);
    final job = await supabase.fetchSingleJob(userId);
    if (job == null) {
      return null;
    }
    return job;
  }
}
