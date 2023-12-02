import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status') //api key
  int? status;

  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  CustomerResponse();

  @JsonKey(name: 'id') //api key
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'numOfNotifications')
  int? numOfNotifications;

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  ContactsResponse();

  @JsonKey(name: 'email') //api key
  String? email;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'link')
  String? link;

  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class LoginResponse extends BaseResponse {
  LoginResponse();

  @JsonKey(name: 'customer')
  CustomerResponse? customer;

  @JsonKey(name: 'contact')
  ContactsResponse? contact;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
