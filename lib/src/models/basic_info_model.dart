// class BasicInfoModel {
//   int? id;
//   int? userId;
//   String? gender;
//   String? profession;
//   String? financialCondition;
//   String? religion;
//   int? smokingStatus;
//   int? drinkingStatus;
//   String? birthDate;
//   List<String>? language; // Modified to handle list of strings
//   String? maritalStatus;
//   PresentAddress? presentAddress;
//   String? createdAt;
//   String? updatedAt;
//   String? community;
//   String? motherTongue;
//   String? aboutUs;
//   int? age;
//
//   BasicInfoModel({
//     this.id,
//     this.userId,
//     this.gender,
//     this.profession,
//     this.financialCondition,
//     this.religion,
//     this.smokingStatus,
//     this.drinkingStatus,
//     this.birthDate,
//     this.language,
//     this.maritalStatus,
//     this.presentAddress,
//     this.createdAt,
//     this.updatedAt,
//     this.community,
//     this.motherTongue,
//     this.aboutUs,
//     this.age,
//   });
//
//   BasicInfoModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     gender = json['gender'];
//     profession = json['profession'];
//     financialCondition = json['financial_condition'];
//     religion = json['religion'];
//     smokingStatus = json['smoking_status'];
//     drinkingStatus = json['drinking_status'];
//     birthDate = json['birth_date'];
//     if (json['language'] != null) {
//       language = List<String>.from(json['language']);
//     }
//     maritalStatus = json['marital_status'];
//     presentAddress = json['present_address'] != null
//         ? PresentAddress.fromJson(json['present_address'])
//         : null;
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     community = json['community'];
//     motherTongue = json['mother_tongue'];
//     aboutUs = json['about_us'];
//     age = json['age'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['gender'] = gender;
//     data['profession'] = profession;
//     data['financial_condition'] = financialCondition;
//     data['religion'] = religion;
//     data['smoking_status'] = smokingStatus;
//     data['drinking_status'] = drinkingStatus;
//     data['birth_date'] = birthDate;
//     if (language != null) {
//       data['language'] = language;
//     }
//     data['marital_status'] = maritalStatus;
//     if (presentAddress != null) {
//       data['present_address'] = presentAddress!.toJson();
//     }
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['community'] = community;
//     data['mother_tongue'] = motherTongue;
//     data['about_us'] = aboutUs;
//     data['age'] = age;
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
//     city = json['city'].toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['country'] = country;
//     data['state'] = state;
//     data['zip'] = zip;
//     data['city'] = city;
//     return data;
//   }
// }
