// class BasicInfoModel {
//   int? id;
//   int? userId;
//   int? userType;
//   String? gender;
//   String? profession;
//   String? financialCondition;
//   String? religion;
//   int? smokingStatus;
//   int? drinkingStatus;
//   String? birthDate;
//
//   String? maritalStatus;
//
//   String? createdAt;
//   String? updatedAt;
//   String? community;
//   String? motherTongue;
//   String? aboutUs;
//   int? age;
//   String? batchStart;
//   String? cadar;
//   String? batchEnd;
//   String? religionName;
//   String? communityName;
//   String? professionName;
//   String? motherTongueName;
//   String? smoking;
//   String? drinking;
//
//   BasicInfoModel(
//       {this.id,
//         this.userId,
//         this.userType,
//         this.gender,
//         this.profession,
//         this.financialCondition,
//         this.religion,
//         this.smokingStatus,
//         this.drinkingStatus,
//         this.birthDate,
//
//         this.maritalStatus,
//
//         this.createdAt,
//         this.updatedAt,
//         this.community,
//         this.motherTongue,
//         this.aboutUs,
//         this.age,
//         this.batchStart,
//         this.cadar,
//         this.batchEnd,
//         this.religionName,
//         this.communityName,
//         this.professionName,
//         this.motherTongueName,
//         this.smoking,
//         this.drinking});
//
//   BasicInfoModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     userType = json['user_type'];
//     gender = json['gender'];
//     profession = json['profession'];
//     financialCondition = json['financial_condition'];
//     religion = json['religion'];
//     smokingStatus = json['smoking_status'];
//     drinkingStatus = json['drinking_status'];
//     birthDate = json['birth_date'];
//
//     maritalStatus = json['marital_status'];
//
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     community = json['community'];
//     motherTongue = json['mother_tongue'];
//     aboutUs = json['about_us'];
//     age = json['age'];
//     batchStart = json['batch_start'];
//     cadar = json['cadar'];
//     batchEnd = json['batch_end'];
//     religionName = json['religion_name'];
//     communityName = json['community_name'];
//     professionName = json['profession_name'];
//     motherTongueName = json['mother_tongue_name'];
//     smoking = json['smoking'];
//     drinking = json['drinking'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     // data['user_type'] = this.userType;
//     data['gender'] = this.gender;
//     data['profession'] = this.profession;
//     data['financial_condition'] = this.financialCondition;
//     data['religion'] = this.religion;
//     data['smoking_status'] = this.smokingStatus;
//     data['drinking_status'] = this.drinkingStatus;
//     data['birth_date'] = this.birthDate;
//
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['community'] = this.community;
//     data['mother_tongue'] = this.motherTongue;
//     data['about_us'] = this.aboutUs;
//     data['age'] = this.age;
//     data['batch_start'] = this.batchStart;
//     data['cadar'] = this.cadar;
//     data['batch_end'] = this.batchEnd;
//     data['religion_name'] = this.religionName;
//     data['community_name'] = this.communityName;
//     data['profession_name'] = this.professionName;
//     data['mother_tongue_name'] = this.motherTongueName;
//     data['smoking'] = this.smoking;
//     data['drinking'] = this.drinking;
//     return data;
//   }
// }
//
//
//
