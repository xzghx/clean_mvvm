class LoginRequest {
  final String email;
  final String password;
  final String imei;
  final String deviceType;

  const LoginRequest(this.email, this.password, this.imei, this.deviceType);
}
