class ProfileModel {
  bool? status;
  Data? data;
  String? message;

  ProfileModel({this.status, this.data, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
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
  Null? kycData;
  int? kv;
  int? ev;
  int? sv;
  int? profileComplete;
  List<Null>? skippedStep;
  List<Null>? completedStep;
  int? totalStep;
  Null? verCodeSendAt;
  Null? tsc;
  Null? loginBy;
  Null? banReason;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? bloodGroup;
  String? religion;
  String? maritalStatus;
  String? motherTongue;
  String? community;
  BasicInfo? basicInfo;
  Null? partnerExpectation;
  PhysicalAttributes? physicalAttributes;
  Family? family;
  List<CareerInfo>? careerInfo;
  List<EducationInfo>? educationInfo;

  User(
      {this.id,
        this.profileId,
        this.firstname,
        this.lastname,
        this.lookingFor,
        this.username,
        this.address,
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
        this.skippedStep,
        this.completedStep,
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
        this.basicInfo,
        this.partnerExpectation,
        this.physicalAttributes,
        this.family,
        this.careerInfo,
        this.educationInfo});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profile_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    lookingFor = json['looking_for'];
    username = json['username'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    balance = json['balance'];
    status = json['status'];
    kycData = json['kyc_data'];
    kv = json['kv'];
    ev = json['ev'];
    sv = json['sv'];
    profileComplete = json['profile_complete'];
    totalStep = json['total_step'];
    verCodeSendAt = json['ver_code_send_at'];
    tsc = json['tsc'];
    loginBy = json['login_by'];
    banReason = json['ban_reason'];
    image = json['image'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    maritalStatus = json['marital_status'];
    motherTongue = json['mother_tongue'];
    community = json['community'];
    basicInfo = json['basic_info'] != null
        ? new BasicInfo.fromJson(json['basic_info'])
        : null;
    partnerExpectation = json['partner_expectation'];
    physicalAttributes = json['physical_attributes'] != null
        ? new PhysicalAttributes.fromJson(json['physical_attributes'])
        : null;
    family =
    json['family'] != null ? new Family.fromJson(json['family']) : null;
    if (json['career_info'] != null) {
      careerInfo = <CareerInfo>[];
      json['career_info'].forEach((v) {
        careerInfo!.add(new CareerInfo.fromJson(v));
      });
    }
    if (json['education_info'] != null) {
      educationInfo = <EducationInfo>[];
      json['education_info'].forEach((v) {
        educationInfo!.add(new EducationInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_id'] = this.profileId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['looking_for'] = this.lookingFor;
    data['username'] = this.username;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['balance'] = this.balance;
    data['status'] = this.status;
    data['kyc_data'] = this.kycData;
    data['kv'] = this.kv;
    data['ev'] = this.ev;
    data['sv'] = this.sv;
    data['profile_complete'] = this.profileComplete;


    data['total_step'] = this.totalStep;
    data['ver_code_send_at'] = this.verCodeSendAt;
    data['tsc'] = this.tsc;
    data['login_by'] = this.loginBy;
    data['ban_reason'] = this.banReason;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['blood_group'] = this.bloodGroup;
    data['religion'] = this.religion;
    data['marital_status'] = this.maritalStatus;
    data['mother_tongue'] = this.motherTongue;
    data['community'] = this.community;
    if (this.basicInfo != null) {
      data['basic_info'] = this.basicInfo!.toJson();
    }
    data['partner_expectation'] = this.partnerExpectation;
    if (this.physicalAttributes != null) {
      data['physical_attributes'] = this.physicalAttributes!.toJson();
    }
    if (this.family != null) {
      data['family'] = this.family!.toJson();
    }
    if (this.careerInfo != null) {
      data['career_info'] = this.careerInfo!.map((v) => v.toJson()).toList();
    }
    if (this.educationInfo != null) {
      data['education_info'] =
          this.educationInfo!.map((v) => v.toJson()).toList();
    }
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

class BasicInfo {
  int? id;
  int? userId;
  String? gender;
  String? profession;
  Null? financialCondition;
  String? religion;
  int? smokingStatus;
  int? drinkingStatus;
  String? birthDate;
  List<Null>? language;
  String? maritalStatus;
  Null? presentAddress;
  Null? permanentAddress;
  String? createdAt;
  String? updatedAt;
  String? community;
  String? motherTongue;

  BasicInfo(
      {this.id,
        this.userId,
        this.gender,
        this.profession,
        this.financialCondition,
        this.religion,
        this.smokingStatus,
        this.drinkingStatus,
        this.birthDate,
        this.language,
        this.maritalStatus,
        this.presentAddress,
        this.permanentAddress,
        this.createdAt,
        this.updatedAt,
        this.community,
        this.motherTongue});

  BasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    gender = json['gender'];
    profession = json['profession'];
    financialCondition = json['financial_condition'];
    religion = json['religion'];
    smokingStatus = json['smoking_status'];
    drinkingStatus = json['drinking_status'];
    birthDate = json['birth_date'];

    maritalStatus = json['marital_status'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    community = json['community'];
    motherTongue = json['mother_tongue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['gender'] = this.gender;
    data['profession'] = this.profession;
    data['financial_condition'] = this.financialCondition;
    data['religion'] = this.religion;
    data['smoking_status'] = this.smokingStatus;
    data['drinking_status'] = this.drinkingStatus;
    data['birth_date'] = this.birthDate;

    data['marital_status'] = this.maritalStatus;
    data['present_address'] = this.presentAddress;
    data['permanent_address'] = this.permanentAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['community'] = this.community;
    data['mother_tongue'] = this.motherTongue;
    return data;
  }
}

class PhysicalAttributes {
  int? id;
  int? userId;
  String? height;
  String? weight;
  String? bloodGroup;
  String? eyeColor;
  String? hairColor;
  String? complexion;
  String? disability;
  String? createdAt;
  String? updatedAt;

  PhysicalAttributes(
      {this.id,
        this.userId,
        this.height,
        this.weight,
        this.bloodGroup,
        this.eyeColor,
        this.hairColor,
        this.complexion,
        this.disability,
        this.createdAt,
        this.updatedAt});

  PhysicalAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    height = json['height'];
    weight = json['weight'];
    bloodGroup = json['blood_group'];
    eyeColor = json['eye_color'];
    hairColor = json['hair_color'];
    complexion = json['complexion'];
    disability = json['disability'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['blood_group'] = this.bloodGroup;
    data['eye_color'] = this.eyeColor;
    data['hair_color'] = this.hairColor;
    data['complexion'] = this.complexion;
    data['disability'] = this.disability;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Family {
  int? id;
  int? userId;
  String? fatherName;
  String? fatherProfession;
  String? fatherContact;
  String? motherName;
  String? motherProfession;
  String? motherContact;
  int? totalBrother;
  int? totalSister;
  String? createdAt;
  String? updatedAt;

  Family(
      {this.id,
        this.userId,
        this.fatherName,
        this.fatherProfession,
        this.fatherContact,
        this.motherName,
        this.motherProfession,
        this.motherContact,
        this.totalBrother,
        this.totalSister,
        this.createdAt,
        this.updatedAt});

  Family.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fatherName = json['father_name'];
    fatherProfession = json['father_profession'];
    fatherContact = json['father_contact'];
    motherName = json['mother_name'];
    motherProfession = json['mother_profession'];
    motherContact = json['mother_contact'];
    totalBrother = json['total_brother'];
    totalSister = json['total_sister'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['father_name'] = this.fatherName;
    data['father_profession'] = this.fatherProfession;
    data['father_contact'] = this.fatherContact;
    data['mother_name'] = this.motherName;
    data['mother_profession'] = this.motherProfession;
    data['mother_contact'] = this.motherContact;
    data['total_brother'] = this.totalBrother;
    data['total_sister'] = this.totalSister;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CareerInfo {
  int? id;
  int? userId;
  String? company;
  String? designation;
  String? start;
  String? end;
  String? createdAt;
  String? updatedAt;

  CareerInfo(
      {this.id,
        this.userId,
        this.company,
        this.designation,
        this.start,
        this.end,
        this.createdAt,
        this.updatedAt});

  CareerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    company = json['company'];
    designation = json['designation'];
    start = json['start'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['company'] = this.company;
    data['designation'] = this.designation;
    data['start'] = this.start;
    data['end'] = this.end;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class EducationInfo {
  int? id;
  int? userId;
  String? degree;
  String? fieldOfStudy;
  String? institute;
  int? regNo;
  int? rollNo;
  String? outOf;
  String? result;
  String? start;
  String? end;
  String? createdAt;
  String? updatedAt;

  EducationInfo(
      {this.id,
        this.userId,
        this.degree,
        this.fieldOfStudy,
        this.institute,
        this.regNo,
        this.rollNo,
        this.outOf,
        this.result,
        this.start,
        this.end,
        this.createdAt,
        this.updatedAt});

  EducationInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    degree = json['degree'];
    fieldOfStudy = json['field_of_study'];
    institute = json['institute'];
    regNo = json['reg_no'];
    rollNo = json['roll_no'];
    outOf = json['out_of'];
    result = json['result'];
    start = json['start'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['degree'] = this.degree;
    data['field_of_study'] = this.fieldOfStudy;
    data['institute'] = this.institute;
    data['reg_no'] = this.regNo;
    data['roll_no'] = this.rollNo;
    data['out_of'] = this.outOf;
    data['result'] = this.result;
    data['start'] = this.start;
    data['end'] = this.end;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
