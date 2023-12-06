import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in.freezed.dart';
part 'sign_in.g.dart';

@freezed
class SignIn with _$SignIn {
  const factory SignIn({
    required String email,
    required String password,
  }) = _SignIn;
  factory SignIn.fromJson(Map<String, Object?> json) => _$SignInFromJson(json);
}
