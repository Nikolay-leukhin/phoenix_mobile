class UserDetailsModel {
  String? id;
  String? email;
  String? phone;
  String? phoneCountry;
  int? cityId;
  bool? isActive;
  bool? isAdmin;
  bool? isPartner;
  String? createdAt;
  String? updatedAt;
  String? fam;
  String? name;
  String? otch;
  String? partnerRole;
  String? referalcode;
  String? lastLogin;
  String? dateLimit;
  String? siteId;
  String? cityname;
  String? countryname;
  int? gender;
  int? notif;
  String? fio;
  DateTime? birthday;
  String? photo;

  UserDetailsModel(
      {required this.id,
      required this.email,
      required this.phone,
      required this.phoneCountry,
      required this.cityId,
      required this.isActive,
      required this.isAdmin,
      required this.isPartner,
      required this.createdAt,
      required this.updatedAt,
      required this.fam,
      required this.name,
      required this.otch,
      required this.partnerRole,
      required this.referalcode,
      required this.lastLogin,
      required this.dateLimit,
      required this.siteId,
      required this.cityname,
      required this.countryname,
      required this.gender,
      required this.notif,
      required this.fio,
      required this.birthday,
      this.photo});

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
        id: json['id'],
        email: json['email'],
        phone: json['phone'],
        phoneCountry: json['phone_country'],
        cityId: json['city_id'],
        isActive: json['is_active'],
        isAdmin: json['is_admin'],
        isPartner: json['is_partner'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        fam: json['fam'],
        name: json['name'],
        otch: json['otch'],
        partnerRole: json['partner_role'],
        referalcode: json['referalcode'],
        lastLogin: json['last_login'],
        dateLimit: json['date_limit'],
        siteId: json['site_id'],
        cityname: json['cityname'],
        countryname: json['countryname'],
        gender: json['gender'],
        notif: json['notif'],
        fio: json['fio'],
        photo: json['photo'],
        birthday: json["date_birth"] == null
            ? null
            : DateTime.tryParse(json["date_birth"]));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['photo'] = photo;
    data['email'] = email;
    data['phone'] = phone;
    data['phone_country'] = phoneCountry;
    data['city_id'] = cityId;
    data['is_active'] = isActive;
    data['is_admin'] = isAdmin;
    data['is_partner'] = isPartner;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['fam'] = fam;
    data['name'] = name;
    data['otch'] = otch;
    data['partner_role'] = partnerRole;
    data['referalcode'] = referalcode;
    data['last_login'] = lastLogin;
    data['date_limit'] = dateLimit;
    data['site_id'] = siteId;
    data['cityname'] = cityname;
    data['countryname'] = countryname;
    data['gender'] = gender;
    data['notif'] = notif;
    data['fio'] = fio;
    data['date_birth'] = birthday.toString();
    return data;
  }

  @override
  String toString() {
    return 'UserDetailsModel {'
        'id: $id, '
        'email: $email, '
        'phone: $phone, '
        'phoneCountry: $phoneCountry, '
        'cityId: $cityId, '
        'isActive: $isActive, '
        'isAdmin: $isAdmin, '
        'isPartner: $isPartner, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'fam: $fam, '
        'name: $name, '
        'otch: $otch, '
        'partnerRole: $partnerRole, '
        'referalcode: $referalcode, '
        'lastLogin: $lastLogin, '
        'dateLimit: $dateLimit, '
        'siteId: $siteId, '
        'cityname: $cityname, '
        'countryname: $countryname, '
        'gender: $gender, '
        'notif: $notif, '
        'fio: $fio'
        '}';
  }
}
