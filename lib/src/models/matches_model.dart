class MatchesModel {
  int? id;
  int? profileId;
  String? firstname;
  String? lastname;
  int? lookingFor;
  String? username;
  String? address;
  String? email;
  String? countryCode;
  String? mobile;
  String? balance;
  int? status;
  String? kycData;
  int? kv;
  int? ev;
  int? sv;
  int? profileComplete;
  int? totalStep;
  String? verCodeSendAt;
  String? tsc;
  String? loginBy;
  String? banReason;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? bloodGroup;
  String? religion;
  String? maritalStatus;
  String? motherTongue;
  String? community;
  String? physicalAttributes;
  String? limitation;
  String? basicInfo;

  MatchesModel({
    this.id,
    this.profileId,
    this.firstname,
    this.lastname,
    this.lookingFor,
    this.username,
    // this.address,
    this.email,
    this.countryCode,
    this.mobile,
    this.balance,
    this.status,
    this.kycData,
    this.kv,
    this.ev,
    this.sv,
    this.profileComplete,
    this.totalStep,
    this.verCodeSendAt,
    this.tsc,
    this.loginBy,
    this.banReason,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.bloodGroup,
    this.religion,
    this.maritalStatus,
    this.motherTongue,
    this.community,
    this.physicalAttributes,
    this.limitation,
    this.basicInfo,
  });

  MatchesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profileId'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    lookingFor = json['lookingFor'];
    username = json['username'];
    // address = json['address'] != null ? address.fromJson(json['address']) : null;
    email = json['email'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    balance = json['balance'];
    status = json['status'];
    kycData = json['kycData']?.toString();
    kv = json['kv'];
    ev = json['ev'];
    sv = json['sv'];
    profileComplete = json['profileComplete'];
    totalStep = json['totalStep'];
    verCodeSendAt = json['verCodeSendAt']?.toString();
    tsc = json['tsc']?.toString();
    loginBy = json['loginBy']?.toString();
    banReason = json['banReason']?.toString();
    image = json['image']?.toString();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bloodGroup = json['bloodGroup'];
    religion = json['religion'];
    maritalStatus = json['maritalStatus'];
    motherTongue = json['motherTongue'];
    community = json['community'];
    // physicalAttributes = json['physicalAttributes'] != null
    //     ? physicalAttributes.fromJson(json['physicalAttributes'])
    //     : null;
    // limitation = json['limitation']?.toString();
    // basicInfo = json['basicInfo'] != null
    //     ? basicInfo.fromJson(json['basicInfo'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['profileId'] = profileId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['lookingFor'] = lookingFor;
    data['username'] = username;
    // data['address'] = address?.toJson();
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['mobile'] = mobile;
    data['balance'] = balance;
    data['status'] = status;
    data['kycData'] = kycData;
    data['kv'] = kv;
    data['ev'] = ev;
    data['sv'] = sv;
    data['profileComplete'] = profileComplete;
    data['totalStep'] = totalStep;
    data['verCodeSendAt'] = verCodeSendAt;
    data['tsc'] = tsc;
    data['loginBy'] = loginBy;
    data['banReason'] = banReason;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['bloodGroup'] = bloodGroup;
    data['religion'] = religion;
    data['maritalStatus'] = maritalStatus;
    data['motherTongue'] = motherTongue;
    data['community'] = community;
    // data['physicalAttributes'] = physicalAttributes?.toJson();
    data['limitation'] = limitation;
    // data['basicInfo'] = basicInfo?.toJson();
    return data;
  }
}
