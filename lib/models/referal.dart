class ReferalModel {
  String id;
  String phone;
  String email;
  String? photo;
  String? fam;
  String? name;
  String? otch;
  List<dynamic> referalList;
  int subcount;
  int sum;
  int referalLevel;

  ReferalModel(
      {required this.id,
      required this.phone,
      required this.email,
      required this.photo,
      required this.fam,
      required this.name,
      required this.otch,
      required this.referalList,
      required this.subcount,
      required this.sum,
      this.referalLevel = 1});

  factory ReferalModel.fromJson(Map<String, dynamic> json, int level) {
    return ReferalModel(
        id: json['id'],
        phone: json['phone'],
        email: json['email'],
        photo: json['photo'],
        fam: json['fam'],
        name: json['name'],
        otch: json['otch'],
        referalList: json['referals']
            .map((e) => ReferalModel.fromJson(e, level + 1))
            .toList(),
        subcount: json['subcount'],
        sum: json['sum'],
        referalLevel: level);
  }

  @override
  String toString() {
    return 'ReferalModel{id: $id, phone: $phone, email: $email, photo: $photo, fam: $fam, name: $name, otch: $otch, referalList: $referalList, subcount: $subcount, sum: $sum, referalLevel: $referalLevel}';
  }
}
