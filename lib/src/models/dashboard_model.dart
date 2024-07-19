// class DashboardModel {
//   bool? status;
//   Data? data;
//   String? message;
//
//   DashboardModel({this.status, this.data, this.message});
//
//   DashboardModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class Data {
//   User? user;
//   List<PremiumMatch>? premiumMatch;
//
//   Data({this.user, this.premiumMatch});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     if (json['premium_match'] != null) {
//       premiumMatch = <PremiumMatch>[];
//       json['premium_match'].forEach((v) {
//         premiumMatch!.add(new PremiumMatch.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.premiumMatch != null) {
//       data['premium_match'] =
//           this.premiumMatch!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class User {
//   int? id;
//   int? profileId;
//   Null? firstname;
//   Null? lastname;
//   int? lookingFor;
//   String? username;
//   Address? address;
//   String? email;
//   String? countryCode;
//   String? mobile;
//   String? balance;
//   int? status;
//   Null? kycData;
//   int? kv;
//   int? ev;
//   int? sv;
//   int? profileComplete;
//   // List<int>? skippedStep;
//   // List<Null>? completedStep;
//   int? totalStep;
//   Null? verCodeSendAt;
//   Null? tsc;
//   Null? loginBy;
//   Null? banReason;
//   Null? image;
//   String? createdAt;
//   String? updatedAt;
//   String? bloodGroup;
//   String? religion;
//   String? maritalStatus;
//   Null? motherTongue;
//   Null? community;
//   BasicInfo? basicInfo;
//   PartnerExpectation? partnerExpectation;
//   PhysicalAttributes? physicalAttributes;
//   Null? family;
//   // List<Null>? careerInfo;
//   // List<Null>? educationInfo;
//
//   User(
//       {this.id,
//         this.profileId,
//         this.firstname,
//         this.lastname,
//         this.lookingFor,
//         this.username,
//         this.address,
//         this.email,
//         this.countryCode,
//         this.mobile,
//         this.balance,
//         this.status,
//         this.kycData,
//         this.kv,
//         this.ev,
//         this.sv,
//         this.profileComplete,
//         // this.skippedStep,
//         // this.completedStep,
//         this.totalStep,
//         this.verCodeSendAt,
//         this.tsc,
//         this.loginBy,
//         this.banReason,
//         this.image,
//         this.createdAt,
//         this.updatedAt,
//         this.bloodGroup,
//         this.religion,
//         this.maritalStatus,
//         this.motherTongue,
//         this.community,
//         this.basicInfo,
//         this.partnerExpectation,
//         this.physicalAttributes,
//         this.family,
//         // this.careerInfo,
//         // this.educationInfo
//       });
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     profileId = json['profile_id'];
//     firstname = json['firstname'];
//     lastname = json['lastname'];
//     lookingFor = json['looking_for'];
//     username = json['username'];
//     address =
//     json['address'] != null ? new Address.fromJson(json['address']) : null;
//     email = json['email'];
//     countryCode = json['country_code'];
//     mobile = json['mobile'];
//     balance = json['balance'];
//     status = json['status'];
//     kycData = json['kyc_data'];
//     kv = json['kv'];
//     ev = json['ev'];
//     sv = json['sv'];
//     profileComplete = json['profile_complete'];
//     // skippedStep = json['skipped_step'].cast<int>();
//     // if (json['completed_step'] != null) {
//     //   completedStep = <Null>[];
//     //   json['completed_step'].forEach((v) {
//     //     completedStep!.add(new Null.fromJson(v));
//     //   });
//     // }
//     totalStep = json['total_step'];
//     verCodeSendAt = json['ver_code_send_at'];
//     tsc = json['tsc'];
//     loginBy = json['login_by'];
//     banReason = json['ban_reason'];
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
//     partnerExpectation = json['partner_expectation'] != null
//         ? new PartnerExpectation.fromJson(json['partner_expectation'])
//         : null;
//     physicalAttributes = json['physical_attributes'] != null
//         ? new PhysicalAttributes.fromJson(json['physical_attributes'])
//         : null;
//     family = json['family'];
//     // if (json['career_info'] != null) {
//     //   careerInfo = <Null>[];
//     //   json['career_info'].forEach((v) {
//     //     careerInfo!.add(new Null.fromJson(v));
//     //   });
//     // }
//     // if (json['education_info'] != null) {
//     //   educationInfo = <Null>[];
//     //   json['education_info'].forEach((v) {
//     //     educationInfo!.add(new Null.fromJson(v));
//     //   });
//     // }
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
//     if (this.address != null) {
//       data['address'] = this.address!.toJson();
//     }
//     data['email'] = this.email;
//     data['country_code'] = this.countryCode;
//     data['mobile'] = this.mobile;
//     data['balance'] = this.balance;
//     data['status'] = this.status;
//     data['kyc_data'] = this.kycData;
//     data['kv'] = this.kv;
//     data['ev'] = this.ev;
//     data['sv'] = this.sv;
//     data['profile_complete'] = this.profileComplete;
//     // data['skipped_step'] = this.skippedStep;
//     // if (this.completedStep != null) {
//     //   data['completed_step'] =
//     //       this.completedStep!.map((v) => v.toJson()).toList();
//     // }
//     data['total_step'] = this.totalStep;
//     data['ver_code_send_at'] = this.verCodeSendAt;
//     data['tsc'] = this.tsc;
//     data['login_by'] = this.loginBy;
//     data['ban_reason'] = this.banReason;
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
//     if (this.partnerExpectation != null) {
//       data['partner_expectation'] = this.partnerExpectation!.toJson();
//     }
//     if (this.physicalAttributes != null) {
//       data['physical_attributes'] = this.physicalAttributes!.toJson();
//     }
//     data['family'] = this.family;
//     // if (this.careerInfo != null) {
//     //   data['career_info'] = this.careerInfo!.map((v) => v.toJson()).toList();
//     // }
//     // if (this.educationInfo != null) {
//     //   data['education_info'] =
//     //       this.educationInfo!.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }
//
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
//   String? financialCondition;
//   String? religion;
//   int? smokingStatus;
//   int? drinkingStatus;
//   String? birthDate;
//   // List<String>? language;
//   String? maritalStatus;
//   PresentAddress? presentAddress;
//   PresentAddress? permanentAddress;
//   String? createdAt;
//   String? updatedAt;
//   Null? community;
//   Null? motherTongue;
//
//   BasicInfo(
//       {this.id,
//         this.userId,
//         this.gender,
//         this.profession,
//         this.financialCondition,
//         this.religion,
//         this.smokingStatus,
//         this.drinkingStatus,
//         this.birthDate,
//         // this.language,
//         this.maritalStatus,
//         this.presentAddress,
//         this.permanentAddress,
//         this.createdAt,
//         this.updatedAt,
//         this.community,
//         this.motherTongue});
//
//   BasicInfo.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     gender = json['gender'];
//     profession = json['profession'];
//     financialCondition = json['financial_condition'];
//     religion = json['religion'];
//     smokingStatus = json['smoking_status'];
//     drinkingStatus = json['drinking_status'];
//     birthDate = json['birth_date'];
//     // language = json['language'].cast<String>();
//     maritalStatus = json['marital_status'];
//     presentAddress = json['present_address'] != null
//         ? new PresentAddress.fromJson(json['present_address'])
//         : null;
//     permanentAddress = json['permanent_address'] != null
//         ? new PresentAddress.fromJson(json['permanent_address'])
//         : null;
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     community = json['community'];
//     motherTongue = json['mother_tongue'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['gender'] = this.gender;
//     data['profession'] = this.profession;
//     data['financial_condition'] = this.financialCondition;
//     data['religion'] = this.religion;
//     data['smoking_status'] = this.smokingStatus;
//     data['drinking_status'] = this.drinkingStatus;
//     data['birth_date'] = this.birthDate;
//     // data['language'] = this.language;
//     data['marital_status'] = this.maritalStatus;
//     if (this.presentAddress != null) {
//       data['present_address'] = this.presentAddress!.toJson();
//     }
//     if (this.permanentAddress != null) {
//       data['permanent_address'] = this.permanentAddress!.toJson();
//     }
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['community'] = this.community;
//     data['mother_tongue'] = this.motherTongue;
//     return data;
//   }
// }
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
// class PartnerExpectation {
//   int? id;
//   int? userId;
//   Null? generalRequirement;
//   String? country;
//   int? minAge;
//   int? maxAge;
//   String? minHeight;
//   String? maxWeight;
//   String? maritalStatus;
//   String? religion;
//   Null? complexion;
//   int? smokingStatus;
//   int? drinkingStatus;
//   Null? language;
//   Null? minDegree;
//   Null? profession;
//   Null? personality;
//   Null? financialCondition;
//   Null? familyPosition;
//   Null? createdAt;
//   Null? updatedAt;
//   Null? motherTongue;
//   Null? community;
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
//         this.complexion,
//         this.smokingStatus,
//         this.drinkingStatus,
//         this.language,
//         this.minDegree,
//         this.profession,
//         this.personality,
//         this.financialCondition,
//         this.familyPosition,
//         this.createdAt,
//         this.updatedAt,
//         this.motherTongue,
//         this.community});
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
//     complexion = json['complexion'];
//     smokingStatus = json['smoking_status'];
//     drinkingStatus = json['drinking_status'];
//     language = json['language'];
//     minDegree = json['min_degree'];
//     profession = json['profession'];
//     personality = json['personality'];
//     financialCondition = json['financial_condition'];
//     familyPosition = json['family_position'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     motherTongue = json['mother_tongue'];
//     community = json['community'];
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
//     data['max_weight'] = this.maxWeight;
//     data['marital_status'] = this.maritalStatus;
//     data['religion'] = this.religion;
//     data['complexion'] = this.complexion;
//     data['smoking_status'] = this.smokingStatus;
//     data['drinking_status'] = this.drinkingStatus;
//     data['language'] = this.language;
//     data['min_degree'] = this.minDegree;
//     data['profession'] = this.profession;
//     data['personality'] = this.personality;
//     data['financial_condition'] = this.financialCondition;
//     data['family_position'] = this.familyPosition;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['mother_tongue'] = this.motherTongue;
//     data['community'] = this.community;
//     return data;
//   }
// }
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
// class PremiumMatch {
//   int? id;
//   int? userId;
//   Null? generalRequirement;
//   String? country;
//   int? minAge;
//   int? maxAge;
//   String? minHeight;
//   String? maxWeight;
//   String? maritalStatus;
//   String? religion;
//   Null? complexion;
//   int? smokingStatus;
//   int? drinkingStatus;
//   // List<Null>? language;
//   Null? minDegree;
//   Null? profession;
//   Null? personality;
//   Null? financialCondition;
//   Null? familyPosition;
//   String? createdAt;
//   String? updatedAt;
//   String? motherTongue;
//   Null? community;
//
//   PremiumMatch(
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
//         this.complexion,
//         this.smokingStatus,
//         this.drinkingStatus,
//         // this.language,
//         this.minDegree,
//         this.profession,
//         this.personality,
//         this.financialCondition,
//         this.familyPosition,
//         this.createdAt,
//         this.updatedAt,
//         this.motherTongue,
//         this.community});
//
//   PremiumMatch.fromJson(Map<String, dynamic> json) {
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
//     complexion = json['complexion'];
//     smokingStatus = json['smoking_status'];
//     drinkingStatus = json['drinking_status'];
//     // if (json['language'] != null) {
//     //   language = <Null>[];
//     //   json['language'].forEach((v) {
//     //     language!.add(new Null.fromJson(v));
//     //   });
//     // }
//     minDegree = json['min_degree'];
//     profession = json['profession'];
//     personality = json['personality'];
//     financialCondition = json['financial_condition'];
//     familyPosition = json['family_position'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     motherTongue = json['mother_tongue'];
//     community = json['community'];
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
//     data['max_weight'] = this.maxWeight;
//     data['marital_status'] = this.maritalStatus;
//     data['religion'] = this.religion;
//     data['complexion'] = this.complexion;
//     data['smoking_status'] = this.smokingStatus;
//     data['drinking_status'] = this.drinkingStatus;
//     // if (this.language != null) {
//     //   data['language'] = this.language!.map((v) => v.toJson()).toList();
//     // }
//     data['min_degree'] = this.minDegree;
//     data['profession'] = this.profession;
//     data['personality'] = this.personality;
//     data['financial_condition'] = this.financialCondition;
//     data['family_position'] = this.familyPosition;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['mother_tongue'] = this.motherTongue;
//     data['community'] = this.community;
//     return data;
//   }
// }
