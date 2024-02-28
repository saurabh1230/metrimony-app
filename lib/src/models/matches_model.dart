class MatchesModel {
  int? id;
  int? profileId;
  String? firstname;
  String? lastname;
  int? lookingFor;
  String? username;
  Address? address;
  String? email;
  String? countryCode;
  String? mobile;
  String? balance;
  int? status;
  String? kycData;
  int? kv;
  int? ev;
  int? sv;
  int? bookmark;
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



  MatchesModel({
    this.id,
    this.profileId,
    this.firstname,
    this.lastname,
    this.lookingFor,
    this.username,
    this.email,
    this.countryCode,
    this.mobile,
    this.balance,
    this.status,
    this.kycData,
    this.address,
    this.kv,
    this.ev,
    this.sv,
    this.bookmark,
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


  });

  MatchesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profile_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    lookingFor = json['lookingFor'];
    username = json['username'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;

    email = json['email'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    balance = json['balance'];
    status = json['status'];
    kycData = json['kycData']?.toString();
    kv = json['kv'];
    ev = json['ev'];
    sv = json['sv'];
    bookmark = json['bookmark'];
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

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['profile_id'] = profileId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['lookingFor'] = lookingFor;
    data['username'] = username;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
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
    data['bookmark'] = bookmark;
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
    data['limitation'] = limitation;
    return data;
  }
}

class Address {
  String? address;
  String? state;
  String? zip;
  String? country;
  String? city;

  Address({this.address, this.state, this.zip, this.country, this.city});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['city'] = this.city;
    return data;
  }
}
