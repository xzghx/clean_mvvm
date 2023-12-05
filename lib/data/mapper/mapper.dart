//Converts Response to NonNull Model

import '../../app/extensions.dart';
import '../../data/response/responses.dart';
import '../../domain/model/model.dart';

const String EMPTY = "";
const int ZERO = 0;

//converts dataLayer object to DomainLayer object
extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? EMPTY,
      this?.name?.orEmpty() ?? EMPTY,
      this?.numOfNotifications?.orZero() ?? ZERO,
    );
  }
}

extension ContactReponseMapper on ContactsResponse? {
  Contact toDomain() {
    return Contact(
      this?.email?.orEmpty() ?? EMPTY,
      this?.phone?.orEmpty() ?? EMPTY,
      this?.link?.orEmpty() ?? EMPTY,
    );
  }
}

extension LoginResponseMapper on LoginResponse? {
  Login toDomain() {
    return Login(
      this?.customer?.toDomain() ?? Customer.empty,
      this?.contact?.toDomain() ?? Contact.empty,
    );
  }
}
