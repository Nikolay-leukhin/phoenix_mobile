import 'package:izobility_mobile/models/user_details.dart';

class UserModel {
  int? id;
  String? email;
  String? phone;
  String? phoneCountry;
  String? emailPartner;
  String? phonePartner;
  int? cityId;
  int? isActive;
  int? isAdmin;
  int? isPartner;
  String? createdAt;
  String? lastLogin;
  String? dateLimit;
  int? siteId;
  List<String>? permissions;
  UserDetailsModel? details;

  UserModel(
      {this.id,
      this.email,
      this.phone,
      this.phoneCountry,
      this.emailPartner,
      this.phonePartner,
      this.cityId,
      this.isActive,
      this.isAdmin,
      this.isPartner,
      this.createdAt,
      this.lastLogin,
      this.dateLimit,
      this.siteId});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    phoneCountry = json['phone_country'];
    emailPartner = json['emailPartner'];
    phonePartner = json['phonePartner'];
    cityId = json['city_id'];
    isActive = json['is_active'];
    isAdmin = json['is_admin'];
    isPartner = json['is_partner'];
    createdAt = json['created_at'];
    lastLogin = json['last_login'];
    dateLimit = json['date_limit'];
    siteId = json['site_id'];

    if (json['details'] != null) {
      details = UserDetailsModel.fromJson(json["details"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['phone'] = phone;
    data['phone_country'] = phoneCountry;
    data['emailPartner'] = emailPartner;
    data['phonePartner'] = phonePartner;
    data['city_id'] = cityId;
    data['is_active'] = isActive;
    data['is_admin'] = isAdmin;
    data['is_partner'] = isPartner;
    data['created_at'] = createdAt;
    data['last_login'] = lastLogin;
    data['date_limit'] = dateLimit;
    data['site_id'] = siteId;
    if (details != null) {
      data["details"] = details!.toJson();
    }

    return data;
  }

  @override
  String toString() {
    return 'UserModel {'
        'id: $id, '
        'email: $email, '
        'phone: $phone, '
        'phoneCountry: $phoneCountry, '
        'emailPartner: $emailPartner, '
        'phonePartner: $phonePartner, '
        'cityId: $cityId, '
        'isActive: $isActive, '
        'isAdmin: $isAdmin, '
        'isPartner: $isPartner, '
        'createdAt: $createdAt, '
        'lastLogin: $lastLogin, '
        'dateLimit: $dateLimit, '
        'siteId: $siteId, '
        'permissions: $permissions, '
        'details: $details'
        '}';
  }
}
