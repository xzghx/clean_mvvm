class LoginRequest {
  final String email;
  final String password;
  final String imei;
  final String deviceType;

  const LoginRequest(this.email, this.password, this.imei, this.deviceType);
}

class ResetPasswordRequest {
  final String email;

  ResetPasswordRequest(this.email);
}

class RegisterRequest {
  final String userName;
  final String password;
  final String email;
  final String mobile;
  final String countryCode;
  final String profilePicture;

  RegisterRequest({
    required this.userName,
    required this.password,
    required this.email,
    required this.mobile,
    required this.countryCode,
    required this.profilePicture,
  });
}
