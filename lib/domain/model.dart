class SliderObject {
  final String title;

  final String subTitle;

  final String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  String id;

  String name;

  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contact {
  String email;

  String phone;

  String link;

  Contact(this.email, this.phone, this.link);
}

class Login {
  Customer customer;
  Contact contact;

  Login(this.customer, this.contact);
}
