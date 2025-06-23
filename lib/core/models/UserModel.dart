class UserModel {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? password;
  bool? aggriedToTerms;
  String? role;
  bool? allowPasswordChange;
  bool? OTPverified;
  bool? isDeleted;
  bool? isBlocked;
  bool? isLoggedIn;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? sentOTP;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.aggriedToTerms,
    this.role,
    this.allowPasswordChange,
    this.OTPverified,
    this.isDeleted,
    this.isBlocked,
    this.isLoggedIn,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.sentOTP,
  });

  // from json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      aggriedToTerms: json['aggriedToTerms'],
      role: json['role'],
      allowPasswordChange: json['allowPasswordChange'],
      OTPverified: json['OTPverified'],
      isDeleted: json['isDeleted'],
      isBlocked: json['isBlocked'],
      isLoggedIn: json['isLoggedIn'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      sentOTP: json['sentOTP'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['aggriedToTerms'] = aggriedToTerms;
    data['role'] = role;
    data['allowPasswordChange'] = allowPasswordChange;
    data['OTPverified'] = OTPverified;
    data['isDeleted'] = isDeleted;
    data['isBlocked'] = isBlocked;
    data['isLoggedIn'] = isLoggedIn;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    data['sentOTP'] = sentOTP;
    return data;
  }
}
