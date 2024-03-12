class ProfileModel {
  bool? status;
  Data? data;
  String? message;

  ProfileModel({this.status, this.data, this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
  int? kv;
  int? ev;
  int? sv;
  int? profileComplete;
  int? totalStep;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? bloodGroup;
  String? religion;
  String? maritalStatus;
  String? motherTongue;
  String? community;
  BasicInfo? basicInfo;
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
        this.kv,
        this.ev,
        this.sv,
        this.profileComplete,
        this.totalStep,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.bloodGroup,
        this.religion,
        this.maritalStatus,
        this.motherTongue,
        this.community,
        this.basicInfo,
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
    json['address'] != null ? Address.fromJson(json['address']) : null;
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    balance = json['balance'];
    status = json['status'];
    kv = json['kv'];
    ev = json['ev'];
    sv = json['sv'];
    profileComplete = json['profile_complete'];
    totalStep = json['total_step'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    maritalStatus = json['marital_status'];
    motherTongue = json['mother_tongue'];
    community = json['community'];
    basicInfo = json['basic_info'] != null
        ? BasicInfo.fromJson(json['basic_info'])
        : null;
    physicalAttributes = json['physical_attributes'] != null
        ? PhysicalAttributes.fromJson(json['physical_attributes'])
        : null;
    family =
    json['family'] != null ? Family.fromJson(json['family']) : null;
    if (json['career_info'] != null) {
      careerInfo = <CareerInfo>[];
      json['career_info'].forEach((v) {
        careerInfo!.add(CareerInfo.fromJson(v));
      });
    }
    if (json['education_info'] != null) {
      educationInfo = <EducationInfo>[];
      json['education_info'].forEach((v) {
        educationInfo!.add(EducationInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['profile_id'] = profileId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['looking_for'] = lookingFor;
    data['username'] = username;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['email'] = email;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['balance'] = balance;
    data['status'] = status;
    data['kv'] = kv;
    data['ev'] = ev;
    data['sv'] = sv;
    data['profile_complete'] = profileComplete;
    data['total_step'] = totalStep;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['blood_group'] = bloodGroup;
    data['religion'] = religion;
    data['marital_status'] = maritalStatus;
    data['mother_tongue'] = motherTongue;
    data['community'] = community;
    if (basicInfo != null) {
      data['basic_info'] = basicInfo!.toJson();
    }
    if (physicalAttributes != null) {
      data['physical_attributes'] = physicalAttributes!.toJson();
    }
    if (family != null) {
      data['family'] = family!.toJson();
    }
    if (careerInfo != null) {
      data['career_info'] = careerInfo!.map((v) => v.toJson()).toList();
    }
    if (educationInfo != null) {
      data['education_info'] =
          educationInfo!.map((v) => v.toJson()).toList();
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
    data['address'] = address;
    data['state'] = state;
    data['zip'] = zip;
    data['country'] = country;
    data['city'] = city;
    return data;
  }
}

class BasicInfo {
  int? id;
  int? userId;
  String? gender;
  String? profession;
  String? financialCondition;
  String? religion;
  int? smokingStatus;
  int? drinkingStatus;
  String? birthDate;
  List<String>? language;
  String? maritalStatus;
  Map<String, dynamic>? presentAddress;
  Map<String, dynamic>? permanentAddress;
  String? createdAt;
  String? updatedAt;
  String? community;
  String? motherTongue;
  String? aboutUs;

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
        this.motherTongue,
        this.aboutUs,
      });

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
    aboutUs = json['about_us'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['gender'] = gender;
    data['profession'] = profession;
    data['financial_condition'] = financialCondition;
    data['religion'] = religion;
    data['smoking_status'] = smokingStatus;
    data['drinking_status'] = drinkingStatus;
    data['birth_date'] = birthDate;
    data['marital_status'] = maritalStatus;
    data['present_address'] = presentAddress;
    data['permanent_address'] = permanentAddress;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['community'] = community;
    data['mother_tongue'] = motherTongue;
    data['about_us'] = this.aboutUs;
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
    data['id'] = id;
    data['user_id'] = userId;
    data['height'] = height;
    data['weight'] = weight;
    data['blood_group'] = bloodGroup;
    data['eye_color'] = eyeColor;
    data['hair_color'] = hairColor;
    data['complexion'] = complexion;
    data['disability'] = disability;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
    data['id'] = id;
    data['user_id'] = userId;
    data['father_name'] = fatherName;
    data['father_profession'] = fatherProfession;
    data['father_contact'] = fatherContact;
    data['mother_name'] = motherName;
    data['mother_profession'] = motherProfession;
    data['mother_contact'] = motherContact;
    data['total_brother'] = totalBrother;
    data['total_sister'] = totalSister;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
    data['id'] = id;
    data['user_id'] = userId;
    data['company'] = company;
    data['designation'] = designation;
    data['start'] = start;
    data['end'] = end;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class EducationInfo {
  int? id;
  int? userId;
  String? institution;
  String? degree;
  String? fieldOfStudy;
  String? start;
  String? end;
  String? createdAt;
  String? updatedAt;

  EducationInfo(
      {this.id,
        this.userId,
        this.institution,
        this.degree,
        this.fieldOfStudy,
        this.start,
        this.end,
        this.createdAt,
        this.updatedAt});

  EducationInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    institution = json['institution'];
    degree = json['degree'];
    fieldOfStudy = json['field_of_study'];
    start = json['start'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['institution'] = institution;
    data['degree'] = degree;
    data['field_of_study'] = fieldOfStudy;
    data['start'] = start;
    data['end'] = end;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
