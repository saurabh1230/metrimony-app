class BasicInfoModel {
  int? id;
  int? userId;
  String? gender;
  String? profession;
  String? financialCondition;
  String? religion;
  int? smokingStatus;
  int? drinkingStatus;
  String? birthDate;
  // List<Null>? language;
  String? maritalStatus;
  String? presentAddress;
  String? permanentAddress;
  String? createdAt;
  String? updatedAt;
  String? community;
  String? motherTongue;

  BasicInfoModel(
      {this.id,
        this.userId,
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
        this.motherTongue});

  BasicInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    gender = json['gender'];
    profession = json['profession'];
    financialCondition = json['financial_condition'].toString();
    religion = json['religion'];
    smokingStatus = json['smoking_status'];
    drinkingStatus = json['drinking_status'];
    birthDate = json['birth_date'];
    // if (json['language'] != null) {
    //   language = <Null>[];
    //   json['language'].forEach((v) {
    //     language!.add(new Null.fromJson(v));
    //   });
    // }
    maritalStatus = json['marital_status'];
    presentAddress = json['present_address'].toString();
    permanentAddress = json['permanent_address'].toString();
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
    // if (this.language != null) {
    //   data['language'] = this.language!.map((v) => v.toJson()).toList();
    // }
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
