class RegisterData {
  String? email;
  String? name;
  int? pin;
  String? password;

  RegisterData({this.password, required this.email, this.name, this.pin});
}
