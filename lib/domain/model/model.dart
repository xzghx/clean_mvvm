class SliderObject {
  final String title;

  final String subTitle;

  final String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  final int id;

  final String name;

  final int numOfNotifications;

  const Customer(this.id, this.name, this.numOfNotifications);

  static const empty = Customer(0, '', 0);
}

class Contact {
  final String email;

  final int phone;

  final String link;

  const Contact(this.email, this.phone, this.link);

  static const empty = Contact('', 0, '');
}

class Login {
  Customer customer;
  Contact contact;

  Login(this.customer, this.contact);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo(this.name, this.identifier, this.version);
}

class ResetPassword {
  final String supportMessage;

  ResetPassword(this.supportMessage);
}
