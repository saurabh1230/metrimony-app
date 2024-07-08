// import 'dashboard_model.dart';
//
// class OtherProfileModel {
//   bool? status;
//   Data? data;
//   String? message;
//
//   OtherProfileModel({this.status, this.data, this.message});
//
//   OtherProfileModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['message'] = message;
//     return data;
//   }
// }
//
// class Data {
//   String? pageTitle;
//   User? user;
//   Matches? matches;
//
//   Data({this.pageTitle, this.user, this.matches});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     pageTitle = json['pageTitle'];
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     matches = json['matches'] != null ? Matches.fromJson(json['matches']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['pageTitle'] = pageTitle;
//     if (user != null) {
//       data['user'] = user!.toJson();
//     }
//     if (matches != null) {
//       data['matches'] = matches!.toJson();
//     }
//     return data;
//   }
// }
//
// class User {
//   int? id;
//   int? profileId;
//   String? firstname;
//   String? lastname;
//   int? lookingFor;
//   String? username;
//   String? image;
//   PartnerExpectation? partnerExpectation;
//
//
//   // Add other properties here
//
//   User({this.id, this.profileId, this.firstname, this.lastname, this.lookingFor, this.username,  this.partnerExpectation});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     profileId = json['profile_id'];
//     firstname = json['firstname'];
//     lastname = json['lastname'];
//     lookingFor = json['looking_for'];
//     username = json['username'];
//     image = json['image'];
//     partnerExpectation = json['partner_expectation'] != null
//         ? new PartnerExpectation.fromJson(json['partner_expectation'])
//         : null;
//     // Initialize other properties here
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id;
//     data['profile_id'] = profileId;
//     data['firstname'] = firstname;
//     data['lastname'] = lastname;
//     data['looking_for'] = lookingFor;
//     data['username'] = username;
//     data['image'] = image;
//     if (this.partnerExpectation != null) {
//       data['partner_expectation'] = this.partnerExpectation!.toJson();
//     }
//
//     return data;
//   }
// }
//
// class Matches {
//   int? id;
//   int? profileId;
//   String? firstname;
//   String? lastname;
//   int? lookingFor;
//   String? username;
//
//   String? email;
//   String? countryCode;
//   String? mobile;
//   String? balance;
//   int? status;
//
//   // int? kv;
//   // int? ev;
//   // int? sv;
//   // int? profileComplete;
//
//   // int? totalStep;
//
//   String? image;
//   String? createdAt;
//   String? updatedAt;
//   String? bloodGroup;
//   String? religion;
//   String? maritalStatus;
//   String? motherTongue;
//   String? community;
//   BasicInfo? basicInfo;
//   PhysicalAttributes? physicalAttributes;
//   Family? family;
//
//   List<CareerInfo>? careerInfo;
//
//   List<EducationInfo>? educationInfo;
//   List<Galleries>? galleries;
//   Address? address;
//   PartnerExpectation? partnerExpectation;
//
//
//   Matches(
//       {this.id,
//         this.profileId,
//         this.firstname,
//         this.lastname,
//         this.lookingFor,
//         this.username,
//         this.address,
//
//         this.email,
//         this.countryCode,
//         this.mobile,
//         this.balance,
//         this.status,
//
//         // this.kv,
//         // this.ev,
//         // this.sv,
//         // this.profileComplete,
//         // this.totalStep,
//         this.image,
//         this.createdAt,
//         this.updatedAt,
//         this.bloodGroup,
//         this.religion,
//         this.maritalStatus,
//         this.motherTongue,
//         this.community,
//         this.basicInfo,
//         this.physicalAttributes,
//         this.family,
//         this.careerInfo,
//         this.educationInfo,
//         this.galleries,
//         this.partnerExpectation
//  });
//
//   Matches.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     profileId = json['profile_id'];
//     firstname = json['firstname'];
//     lastname = json['lastname'];
//     lookingFor = json['looking_for'];
//     username = json['username'];
//
//     email = json['email'];
//     countryCode = json['country_code'];
//     mobile = json['mobile'];
//     balance = json['balance'];
//     status = json['status'];
//
//
//     // kv = json['kv'];
//     // ev = json['ev'];
//     // sv = json['sv'];
//     // profileComplete = json['profile_complete'];
//     // totalStep = json['total_step'];
//     image = json['image'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     bloodGroup = json['blood_group'];
//     religion = json['religion'];
//     maritalStatus = json['marital_status'];
//     motherTongue = json['mother_tongue'];
//     community = json['community'];
//     basicInfo = json['basic_info'] != null
//         ? new BasicInfo.fromJson(json['basic_info'])
//         : null;
//     physicalAttributes = json['physical_attributes'] != null
//         ? new PhysicalAttributes.fromJson(json['physical_attributes'])
//         : null;
//     if (json['education_info'] != null) {
//       educationInfo = <EducationInfo>[];
//       json['education_info'].forEach((v) {
//         educationInfo!.add(new EducationInfo.fromJson(v));
//       });
//     }
//     if (json['galleries'] != null) {
//       galleries = <Galleries>[];
//       json['galleries'].forEach((v) {
//         galleries!.add(new Galleries.fromJson(v));
//       });
//     }
//     family =
//     json['family'] != null ? new Family.fromJson(json['family']) : null;
//     address =
//     json['address'] != null ? new Address.fromJson(json['address']) : null;
//     partnerExpectation = json['partner_expectation'] != null
//         ? new PartnerExpectation.fromJson(json['partner_expectation'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['profile_id'] = this.profileId;
//     data['firstname'] = this.firstname;
//     data['lastname'] = this.lastname;
//     data['looking_for'] = this.lookingFor;
//     data['username'] = this.username;
//
//     data['email'] = this.email;
//     data['country_code'] = this.countryCode;
//     data['mobile'] = this.mobile;
//     data['balance'] = this.balance;
//     data['status'] = this.status;
//
//     // data['kv'] = this.kv;
//     // data['ev'] = this.ev;
//     // data['sv'] = this.sv;
//     // data['profile_complete'] = this.profileComplete;
//     // data['total_step'] = this.totalStep;
//     data['image'] = this.image;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['blood_group'] = this.bloodGroup;
//     data['religion'] = this.religion;
//     data['marital_status'] = this.maritalStatus;
//     data['mother_tongue'] = this.motherTongue;
//     data['community'] = this.community;
//     if (this.basicInfo != null) {
//       data['basic_info'] = this.basicInfo!.toJson();
//     }
//     if (this.physicalAttributes != null) {
//       data['physical_attributes'] = this.physicalAttributes!.toJson();
//     }
//     if (this.family != null) {
//       data['family'] = this.family!.toJson();
//     }
//
//     if (this.careerInfo != null) {
//       data['career_info'] = this.careerInfo!.map((v) => v.toJson()).toList();
//     }
//
//     if (this.educationInfo != null) {
//       data['education_info'] =
//           this.educationInfo!.map((v) => v.toJson()).toList();
//     }
//     if (this.galleries != null) {
//       data['galleries'] = this.galleries!.map((v) => v.toJson()).toList();
//     }
//     if (this.address != null) {
//       data['address'] = this.address!.toJson();
//     }
//     if (this.partnerExpectation != null) {
//       data['partner_expectation'] = this.partnerExpectation!.toJson();
//     }
//
//     return data;
//   }
// }
// class Address {
//   String? address;
//   String? state;
//   String? zip;
//   String? country;
//   String? city;
//
//   Address({this.address, this.state, this.zip, this.country, this.city});
//
//   Address.fromJson(Map<String, dynamic> json) {
//     address = json['address'];
//     state = json['state'];
//     zip = json['zip'];
//     country = json['country'];
//     city = json['city'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['address'] = this.address;
//     data['state'] = this.state;
//     data['zip'] = this.zip;
//     data['country'] = this.country;
//     data['city'] = this.city;
//     return data;
//   }
// }
//
// class BasicInfo {
//   int? id;
//   int? userId;
//   String? gender;
//   String? profession;
//   // Null? financialCondition;
//   String? religion;
//   int? smokingStatus;
//   int? drinkingStatus;
//   String? birthDate;
//   // List<Null>? language;
//   String? maritalStatus;
//   PresentAddress? presentAddress;
//   // Null? permanentAddress;
//   String? createdAt;
//   String? updatedAt;
//   String? community;
//   String? motherTongue;
//   String? aboutUs;
//
//   BasicInfo(
//       {this.id,
//         this.userId,
//         this.gender,
//         this.profession,
//         // this.financialCondition,
//         this.religion,
//         this.smokingStatus,
//         this.drinkingStatus,
//         this.birthDate,
//         // this.language,
//         this.maritalStatus,
//         this.presentAddress,
//         // this.presentAddress,
//         // this.permanentAddress,
//         this.createdAt,
//         this.updatedAt,
//         this.community,
//         this.motherTongue,
//         this.aboutUs,
//       });
//
//   BasicInfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     gender = json['gender'];
//     profession = json['profession'];
//     // financialCondition = json['financial_condition'];
//     religion = json['religion'];
//     smokingStatus = json['smoking_status'];
//     drinkingStatus = json['drinking_status'];
//     birthDate = json['birth_date'];
//
//     maritalStatus = json['marital_status'];
//     presentAddress = json['present_address'] != null
//         ? new PresentAddress.fromJson(json['present_address'])
//         : null;
//     // presentAddress = json['present_address'];
//     // permanentAddress = json['permanent_address'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     community = json['community'];
//     aboutUs = json['about_us'];
//     motherTongue = json['mother_tongue'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['gender'] = this.gender;
//     data['profession'] = this.profession;
//     // data['financial_condition'] = this.financialCondition;
//     data['religion'] = this.religion;
//     data['smoking_status'] = this.smokingStatus;
//     data['drinking_status'] = this.drinkingStatus;
//     data['birth_date'] = this.birthDate;
//     data['marital_status'] = this.maritalStatus;
//     if (this.presentAddress != null) {
//       data['present_address'] = this.presentAddress!.toJson();
//     }
//     // data['present_address'] = this.presentAddress;
//     // data['permanent_address'] = this.permanentAddress;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['community'] = this.community;
//     data['mother_tongue'] = this.motherTongue;
//     return data;
//   }
// }
//
//
// class PresentAddress {
//   String? country;
//   String? state;
//   String? zip;
//   String? city;
//
//   PresentAddress({this.country, this.state, this.zip, this.city});
//
//   PresentAddress.fromJson(Map<String, dynamic> json) {
//     country = json['country'];
//     state = json['state'];
//     zip = json['zip'];
//     city = json['city'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['country'] = this.country;
//     data['state'] = this.state;
//     data['zip'] = this.zip;
//     data['city'] = this.city;
//     return data;
//   }
// }
//
//
// class PhysicalAttributes {
//   int? id;
//   int? userId;
//   String? height;
//   String? weight;
//   String? bloodGroup;
//   String? eyeColor;
//   String? hairColor;
//   String? complexion;
//   String? disability;
//   String? createdAt;
//   String? updatedAt;
//
//   PhysicalAttributes(
//       {this.id,
//         this.userId,
//         this.height,
//         this.weight,
//         this.bloodGroup,
//         this.eyeColor,
//         this.hairColor,
//         this.complexion,
//         this.disability,
//         this.createdAt,
//         this.updatedAt});
//
//   PhysicalAttributes.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     height = json['height'];
//     weight = json['weight'];
//     bloodGroup = json['blood_group'];
//     eyeColor = json['eye_color'];
//     hairColor = json['hair_color'];
//     complexion = json['complexion'];
//     disability = json['disability'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['height'] = this.height;
//     data['weight'] = this.weight;
//     data['blood_group'] = this.bloodGroup;
//     data['eye_color'] = this.eyeColor;
//     data['hair_color'] = this.hairColor;
//     data['complexion'] = this.complexion;
//     data['disability'] = this.disability;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Family {
//   int? id;
//   int? userId;
//   String? fatherName;
//   String? fatherProfession;
//   String? fatherContact;
//   String? motherName;
//   String? motherProfession;
//   String? motherContact;
//   int? totalBrother;
//   int? totalSister;
//   String? createdAt;
//   String? updatedAt;
//
//   Family(
//       {this.id,
//         this.userId,
//         this.fatherName,
//         this.fatherProfession,
//         this.fatherContact,
//         this.motherName,
//         this.motherProfession,
//         this.motherContact,
//         this.totalBrother,
//         this.totalSister,
//         this.createdAt,
//         this.updatedAt});
//
//   Family.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     fatherName = json['father_name'];
//     fatherProfession = json['father_profession'];
//     fatherContact = json['father_contact'];
//     motherName = json['mother_name'];
//     motherProfession = json['mother_profession'];
//     motherContact = json['mother_contact'];
//     totalBrother = json['total_brother'];
//     totalSister = json['total_sister'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['father_name'] = this.fatherName;
//     data['father_profession'] = this.fatherProfession;
//     data['father_contact'] = this.fatherContact;
//     data['mother_name'] = this.motherName;
//     data['mother_profession'] = this.motherProfession;
//     data['mother_contact'] = this.motherContact;
//     data['total_brother'] = this.totalBrother;
//     data['total_sister'] = this.totalSister;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class CareerInfo {
//   int? id;
//   int? userId;
//   String? company;
//   String? designation;
//   String? start;
//   String? end;
//   String? createdAt;
//   String? updatedAt;
//
//   CareerInfo(
//       {this.id,
//         this.userId,
//         this.company,
//         this.designation,
//         this.start,
//         this.end,
//         this.createdAt,
//         this.updatedAt});
//
//   CareerInfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     company = json['company'];
//     designation = json['designation'];
//     start = json['start'];
//     end = json['end'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['company'] = this.company;
//     data['designation'] = this.designation;
//     data['start'] = this.start;
//     data['end'] = this.end;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class EducationInfo {
//   int? id;
//   int? userId;
//   String? degree;
//   String? fieldOfStudy;
//   String? institute;
//   int? regNo;
//   int? rollNo;
//   String? outOf;
//   String? result;
//   String? start;
//   String? end;
//   String? createdAt;
//   String? updatedAt;
//
//   EducationInfo(
//       {this.id,
//         this.userId,
//         this.degree,
//         this.fieldOfStudy,
//         this.institute,
//         this.regNo,
//         this.rollNo,
//         this.outOf,
//         this.result,
//         this.start,
//         this.end,
//         this.createdAt,
//         this.updatedAt});
//
//   EducationInfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     degree = json['degree'];
//     fieldOfStudy = json['field_of_study'];
//     institute = json['institute'];
//     regNo = json['reg_no'];
//     rollNo = json['roll_no'];
//     outOf = json['out_of'];
//     result = json['result'];
//     start = json['start'];
//     end = json['end'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['degree'] = this.degree;
//     data['field_of_study'] = this.fieldOfStudy;
//     data['institute'] = this.institute;
//     data['reg_no'] = this.regNo;
//     data['roll_no'] = this.rollNo;
//     data['out_of'] = this.outOf;
//     data['result'] = this.result;
//     data['start'] = this.start;
//     data['end'] = this.end;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
// class Galleries {
//   int? id;
//   int? userId;
//   String? image;
//
//
//
//   Galleries({this.id, this.userId, this.image, });
//
//   Galleries.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     image = json['image'];
//
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['image'] = this.image;
//     return data;
//   }
// }
//
// class PartnerExpectation {
//   int? id;
//   int? userId;
//   String? generalRequirement;
//   String? country;
//   int? minAge;
//   int? maxAge;
//   String? minHeight;
//   String? maxHeight;
//   String? maxWeight;
//   String? maritalStatus;
//   String? religion;
//
//   int? smokingStatus;
//   int? drinkingStatus;
//   List<String>? language;
//   String? minDegree;
//   String? profession;
//
//   String? financialCondition;
//
//   String? createdAt;
//   String? updatedAt;
//   String? motherTongue;
//   String? community;
//
//   PartnerExpectation(
//       {this.id,
//         this.userId,
//         this.generalRequirement,
//         this.country,
//         this.minAge,
//         this.maxAge,
//         this.minHeight,
//         this.maxWeight,
//         this.maritalStatus,
//         this.religion,
//
//
//         this.smokingStatus,
//         this.drinkingStatus,
//         this.language,
//         this.minDegree,
//         this.profession,
//
//         this.financialCondition,
//
//         this.createdAt,
//         this.updatedAt,
//         this.motherTongue,
//         this.community,
//         this.maxHeight,
//       });
//
//   PartnerExpectation.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     generalRequirement = json['general_requirement'];
//     country = json['country'];
//     minAge = json['min_age'];
//     maxAge = json['max_age'];
//     minHeight = json['min_height'];
//     maxWeight = json['max_weight'];
//     maritalStatus = json['marital_status'];
//     religion = json['religion'];
//
//     smokingStatus = json['smoking_status'];
//     drinkingStatus = json['drinking_status'];
//     language = json['language'].cast<String>();
//     minDegree = json['min_degree'];
//
//     financialCondition = json['financial_condition'];
//
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     motherTongue = json['mother_tongue'];
//     community = json['community'];
//     maxHeight = json['max_height'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['general_requirement'] = this.generalRequirement;
//     data['country'] = this.country;
//     data['min_age'] = this.minAge;
//     data['max_age'] = this.maxAge;
//     data['min_height'] = this.minHeight;
//     data['max_height'] = this.minHeight;
//     data['max_weight'] = this.maxWeight;
//     data['marital_status'] = this.maritalStatus;
//     data['religion'] = this.religion;
//
//     data['smoking_status'] = this.smokingStatus;
//     data['drinking_status'] = this.drinkingStatus;
//     data['language'] = this.language;
//     data['min_degree'] = this.minDegree;
//     data['profession'] = this.profession;
//
//     data['financial_condition'] = this.financialCondition;
//
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['mother_tongue'] = this.motherTongue;
//     data['community'] = this.community;
//     return data;
//   }
// }

class OtherProfileModel {
  bool? status;
  Data? data;
  String? message;

  OtherProfileModel({this.status, this.data, this.message});

  OtherProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? pageTitle;
  User? user;
  Matches? matches;

  Data({this.pageTitle, this.user, this.matches});

  Data.fromJson(Map<String, dynamic> json) {
    pageTitle = json['pageTitle'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    matches =
    json['matches'] != null ? new Matches.fromJson(json['matches']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageTitle'] = this.pageTitle;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.matches != null) {
      data['matches'] = this.matches!.toJson();
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
  // String? balance;
  // int? status;
  // Null? kycData;
  // int? kv;
  // int? ev;
  // int? sv;
  // int? profileComplete;
  // List<Null>? skippedStep;
  // List<int>? completedStep;
  // int? totalStep;
  // Null? verCodeSendAt;
  // Null? tsc;
  // Null? loginBy;
  // Null? banReason;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? bloodGroup;
  String? religion;
  String? maritalStatus;
  String? motherTongue;
  String? community;
  String? gender;
  String? profession;
  String? middleName;
  PartnerExpectation? partnerExpectation;

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
        // this.balance,
        // this.status,
        // this.kycData,
        // this.kv,
        // this.ev,
        // this.sv,
        // this.profileComplete,
        // this.skippedStep,
        // this.completedStep,
        // this.totalStep,
        // this.verCodeSendAt,
        // this.tsc,
        // this.loginBy,
        // this.banReason,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.bloodGroup,
        this.religion,
        this.maritalStatus,
        this.motherTongue,
        this.community,
        this.gender,
        this.profession,
        this.middleName,
        this.partnerExpectation});

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
    // balance = json['balance'];
    // status = json['status'];
    // kycData = json['kyc_data'];
    // kv = json['kv'];
    // ev = json['ev'];
    // sv = json['sv'];
    // profileComplete = json['profile_complete'];
    // if (json['skipped_step'] != null) {
    //   skippedStep = <Null>[];
    //   json['skipped_step'].forEach((v) {
    //     skippedStep!.add(new Null.fromJson(v));
    //   });
    // }
    // completedStep = json['completed_step'].cast<int>();
    // totalStep = json['total_step'];
    // verCodeSendAt = json['ver_code_send_at'];
    // tsc = json['tsc'];
    // loginBy = json['login_by'];
    // banReason = json['ban_reason'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    maritalStatus = json['marital_status'];
    motherTongue = json['mother_tongue'];
    community = json['community'];
    gender = json['gender'];
    profession = json['profession'];
    middleName = json['middle_name'];
    partnerExpectation = json['partner_expectation'] != null
        ? new PartnerExpectation.fromJson(json['partner_expectation'])
        : null;
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
    // data['balance'] = this.balance;
    // data['status'] = this.status;
    // data['kyc_data'] = this.kycData;
    // data['kv'] = this.kv;
    // data['ev'] = this.ev;
    // data['sv'] = this.sv;
    // data['profile_complete'] = this.profileComplete;
    // if (this.skippedStep != null) {
    //   data['skipped_step'] = this.skippedStep!.map((v) => v.toJson()).toList();
    // }
    // data['completed_step'] = this.completedStep;
    // data['total_step'] = this.totalStep;
    // data['ver_code_send_at'] = this.verCodeSendAt;
    // data['tsc'] = this.tsc;
    // data['login_by'] = this.loginBy;
    // data['ban_reason'] = this.banReason;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['blood_group'] = this.bloodGroup;
    data['religion'] = this.religion;
    data['marital_status'] = this.maritalStatus;
    data['mother_tongue'] = this.motherTongue;
    data['community'] = this.community;
    data['gender'] = this.gender;
    data['profession'] = this.profession;
    data['middle_name'] = this.middleName;
    if (this.partnerExpectation != null) {
      data['partner_expectation'] = this.partnerExpectation!.toJson();
    }
    return data;
  }
}

class Address {
  String? address;
  String? state;
  String? zip;
  String? country;
  String? district;

  Address({this.address, this.state, this.zip, this.country, this.district});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['district'] = this.district;
    return data;
  }
}

class PartnerExpectation {
  int? id;
  int? userId;
  String? generalRequirement;
  String? country;
  int? minAge;
  int? maxAge;
  String? minHeight;
  String? maxHeight;
  // String? maxWeight;
  String? maritalStatus;
  int? religion;
  String? complexion;
  int? smokingStatus;
  int? drinkingStatus;
  // List<Null>? language;
  String? minDegree;
  String? profession;
  // Null? personality;
  String? financialCondition;
  // Null? familyPosition;
  String? createdAt;
  String? updatedAt;
  String? motherTongue;
  int? community;
  String? positionHeld;

  PartnerExpectation(
      {this.id,
        this.userId,
        this.generalRequirement,
        this.country,
        this.minAge,
        this.maxAge,
        this.minHeight,
        this.maxHeight,
        // this.maxWeight,
        this.maritalStatus,
        this.religion,
        this.complexion,
        this.smokingStatus,
        this.drinkingStatus,
        // this.language,
        this.minDegree,
        this.profession,
        // this.personality,
        this.financialCondition,
        // this.familyPosition,
        this.createdAt,
        this.updatedAt,
        this.motherTongue,
        this.community,
        this.positionHeld});

  PartnerExpectation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    generalRequirement = json['general_requirement'];
    country = json['country'];
    minAge = json['min_age'];
    maxAge = json['max_age'];
    minHeight = json['min_height'];
    maxHeight = json['max_height'];
    // maxWeight = json['max_weight'];
    maritalStatus = json['marital_status'];
    religion = json['religion'];
    complexion = json['complexion'];
    smokingStatus = json['smoking_status'];
    drinkingStatus = json['drinking_status'];
    // if (json['language'] != null) {
    //   language = <Null>[];
    //   json['language'].forEach((v) {
    //     language!.add(new Null.fromJson(v));
    //   });
    // }
    minDegree = json['min_degree'];
    profession = json['profession'];
    // personality = json['personality'];
    financialCondition = json['financial_condition'];
    // familyPosition = json['family_position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    motherTongue = json['mother_tongue'];
    community = json['community'];
    positionHeld = json['position_held'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['general_requirement'] = this.generalRequirement;
    data['country'] = this.country;
    data['min_age'] = this.minAge;
    data['max_age'] = this.maxAge;
    data['min_height'] = this.minHeight;
    data['max_height'] = this.maxHeight;
    // data['max_weight'] = this.maxWeight;
    data['marital_status'] = this.maritalStatus;
    data['religion'] = this.religion;
    data['complexion'] = this.complexion;
    data['smoking_status'] = this.smokingStatus;
    data['drinking_status'] = this.drinkingStatus;
    // if (this.language != null) {
    //   data['language'] = this.language!.map((v) => v.toJson()).toList();
    // }
    data['min_degree'] = this.minDegree;
    data['profession'] = this.profession;
    // data['personality'] = this.personality;
    data['financial_condition'] = this.financialCondition;
    // data['family_position'] = this.familyPosition;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['mother_tongue'] = this.motherTongue;
    data['community'] = this.community;
    data['position_held'] = this.positionHeld;
    return data;
  }
}

class Matches {
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
  // int? status;
  // Null? kycData;
  // int? kv;
  // int? ev;
  // int? sv;
  // int? profileComplete;
  // List<Null>? skippedStep;
  // List<int>? completedStep;
  // int? totalStep;
  // Null? verCodeSendAt;
  // Null? tsc;
  // Null? loginBy;
  // Null? banReason;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? bloodGroup;
  String? religion;
  String? maritalStatus;
  String? motherTongue;
  String? community;
  String? gender;
  String? profession;
  String? middleName;
  BasicInfo? basicInfo;
  PhysicalAttributes? physicalAttributes;
  // Null? family;
  PartnerExpectation? partnerExpectation;
  List<CareerInfo>? careerInfo;
  // Null? limitation;
  List<EducationInfo>? educationInfo;
  List<Galleries>? galleries;

  Matches(
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
        // this.status,
        // this.kycData,
        // this.kv,
        // this.ev,
        // this.sv,
        // this.profileComplete,
        // this.skippedStep,
        // this.completedStep,
        // this.totalStep,
        // this.verCodeSendAt,
        // this.tsc,
        // this.loginBy,
        // this.banReason,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.bloodGroup,
        this.religion,
        this.maritalStatus,
        this.motherTongue,
        this.community,
        this.gender,
        this.profession,
        this.middleName,
        this.basicInfo,
        this.physicalAttributes,
        // this.family,
        this.partnerExpectation,
        this.careerInfo,
        // this.limitation,
        this.educationInfo,
        this.galleries
      });

  Matches.fromJson(Map<String, dynamic> json) {
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
    // status = json['status'];
    // kycData = json['kyc_data'];
    // kv = json['kv'];
    // ev = json['ev'];
    // sv = json['sv'];
    // profileComplete = json['profile_complete'];
    // if (json['skipped_step'] != null) {
    //   skippedStep = <Null>[];
    //   json['skipped_step'].forEach((v) {
    //     skippedStep!.add(new Null.fromJson(v));
    //   });
    // }
    // completedStep = json['completed_step'].cast<int>();
    // totalStep = json['total_step'];
    // verCodeSendAt = json['ver_code_send_at'];
    // tsc = json['tsc'];
    // loginBy = json['login_by'];
    // banReason = json['ban_reason'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    maritalStatus = json['marital_status'];
    motherTongue = json['mother_tongue'];
    community = json['community'];
    gender = json['gender'];
    profession = json['profession'];
    middleName = json['middle_name'];
    basicInfo = json['basic_info'] != null
        ? new BasicInfo.fromJson(json['basic_info'])
        : null;
    physicalAttributes = json['physical_attributes'] != null
        ? new PhysicalAttributes.fromJson(json['physical_attributes'])
        : null;
    // family = json['family'];
    partnerExpectation = json['partner_expectation'] != null
        ? new PartnerExpectation.fromJson(json['partner_expectation'])
        : null;
    if (json['career_info'] != null) {
      careerInfo = <CareerInfo>[];
      json['career_info'].forEach((v) {
        careerInfo!.add(new CareerInfo.fromJson(v));
      });
    }
    // limitation = json['limitation'];
    if (json['education_info'] != null) {
      educationInfo = <EducationInfo>[];
      json['education_info'].forEach((v) {
        educationInfo!.add(new EducationInfo.fromJson(v));
      });
    }
    if (json['galleries'] != null) {
      galleries = <Galleries>[];
      json['galleries'].forEach((v) {
        galleries!.add(new Galleries.fromJson(v));
      });
    }
    // if (json['galleries'] != null) {
    //   galleries = <Null>[];
    //   json['galleries'].forEach((v) {
    //     galleries!.add(new Null.fromJson(v));
    //   });
    // }
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
    // data['status'] = this.status;
    // data['kyc_data'] = this.kycData;
    // data['kv'] = this.kv;
    // data['ev'] = this.ev;
    // data['sv'] = this.sv;
    // data['profile_complete'] = this.profileComplete;
    // if (this.skippedStep != null) {
    //   data['skipped_step'] = this.skippedStep!.map((v) => v.toJson()).toList();
    // }
    // data['completed_step'] = this.completedStep;
    // data['total_step'] = this.totalStep;
    // data['ver_code_send_at'] = this.verCodeSendAt;
    // data['tsc'] = this.tsc;
    // data['login_by'] = this.loginBy;
    // data['ban_reason'] = this.banReason;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['blood_group'] = this.bloodGroup;
    data['religion'] = this.religion;
    data['marital_status'] = this.maritalStatus;
    data['mother_tongue'] = this.motherTongue;
    data['community'] = this.community;
    data['gender'] = this.gender;
    data['profession'] = this.profession;
    data['middle_name'] = this.middleName;
    if (this.basicInfo != null) {
      data['basic_info'] = this.basicInfo!.toJson();
    }
    if (this.physicalAttributes != null) {
      data['physical_attributes'] = this.physicalAttributes!.toJson();
    }
    // data['family'] = this.family;
    if (this.partnerExpectation != null) {
      data['partner_expectation'] = this.partnerExpectation!.toJson();
    }
    if (this.careerInfo != null) {
      data['career_info'] = this.careerInfo!.map((v) => v.toJson()).toList();
    }
    // data['limitation'] = this.limitation;
    if (this.educationInfo != null) {
      data['education_info'] =
          this.educationInfo!.map((v) => v.toJson()).toList();
    }
    if (this.galleries != null) {
      data['galleries'] = this.galleries!.map((v) => v.toJson()).toList();
    }
    // if (this.galleries != null) {
    //   data['galleries'] = this.galleries!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class BasicInfo {
  int? id;
  int? userId;
  int? userType;
  String? gender;
  String? profession;
  String? financialCondition;
  String? religion;
  int? smokingStatus;
  int? drinkingStatus;
  String? birthDate;
  // Null? language;
  String? maritalStatus;
  PresentAddress? presentAddress;
  PermanentAddress? permanentAddress;
  String? createdAt;
  String? updatedAt;
  String? community;
  String? motherTongue;
  String? aboutUs;
  int? age;
  String? batchStart;
  String? cadar;
  String? batchEnd;

  BasicInfo(
      {this.id,
        this.userId,
        this.userType,
        this.gender,
        this.profession,
        this.financialCondition,
        this.religion,
        this.smokingStatus,
        this.drinkingStatus,
        this.birthDate,
        // this.language,
        this.maritalStatus,
        this.presentAddress,
        this.permanentAddress,
        this.createdAt,
        this.updatedAt,
        this.community,
        this.motherTongue,
        this.aboutUs,
        this.age,
        this.batchStart,
        this.cadar,
        this.batchEnd});

  BasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    gender = json['gender'];
    profession = json['profession'];
    financialCondition = json['financial_condition'];
    religion = json['religion'];
    smokingStatus = json['smoking_status'];
    drinkingStatus = json['drinking_status'];
    birthDate = json['birth_date'];
    // language = json['language'];
    maritalStatus = json['marital_status'];
    presentAddress = json['present_address'] != null
        ? new PresentAddress.fromJson(json['present_address'])
        : null;
    permanentAddress = json['permanent_address'] != null
        ? new PermanentAddress.fromJson(json['permanent_address'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    community = json['community'];
    motherTongue = json['mother_tongue'];
    aboutUs = json['about_us'];
    age = json['age'];
    batchStart = json['batch_start'];
    cadar = json['cadar'];
    batchEnd = json['batch_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['gender'] = this.gender;
    data['profession'] = this.profession;
    data['financial_condition'] = this.financialCondition;
    data['religion'] = this.religion;
    data['smoking_status'] = this.smokingStatus;
    data['drinking_status'] = this.drinkingStatus;
    data['birth_date'] = this.birthDate;
    // data['language'] = this.language;
    data['marital_status'] = this.maritalStatus;
    if (this.presentAddress != null) {
      data['present_address'] = this.presentAddress!.toJson();
    }
    if (this.permanentAddress != null) {
      data['permanent_address'] = this.permanentAddress!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['community'] = this.community;
    data['mother_tongue'] = this.motherTongue;
    data['about_us'] = this.aboutUs;
    data['age'] = this.age;
    data['batch_start'] = this.batchStart;
    data['cadar'] = this.cadar;
    data['batch_end'] = this.batchEnd;
    return data;
  }
}

class PresentAddress {
  String? country;
  String? state;
  String? zip;
  String? city;

  PresentAddress({this.country, this.state, this.zip, this.city});

  PresentAddress.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    zip = json['zip'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['city'] = this.city;
    return data;
  }
}

class PermanentAddress {
  String? country;
  String? state;
  String? zip;
  String? city;

  PermanentAddress({this.country, this.state, this.zip, this.city});

  PermanentAddress.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    zip = json['zip'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['city'] = this.city;
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

class CareerInfo {
  int? id;
  int? userId;
  String? position;
  String? from;
  String? end;
  String? createdAt;
  String? updatedAt;
  String? statePosting;
  String? districtPosting;

  CareerInfo(
      {this.id,
        this.userId,
        this.position,
        this.from,
        this.end,
        this.createdAt,
        this.updatedAt,
        this.statePosting,
        this.districtPosting});

  CareerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    position = json['position'];
    from = json['from'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statePosting = json['state_posting'];
    districtPosting = json['district_posting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['position'] = this.position;
    data['from'] = this.from;
    data['end'] = this.end;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['state_posting'] = this.statePosting;
    data['district_posting'] = this.districtPosting;
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
  // String? createdAt;
  // String? updatedAt;

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
        // this.createdAt,
        // this.updatedAt
      });

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
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
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
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}
class Galleries {
  int? id;
  int? userId;
  String? image;
  // String? createdAt;
  // Null? updatedAt;

  Galleries({this.id, this.userId, this.image, /*this.createdAt, this.updatedAt*/});

  Galleries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}