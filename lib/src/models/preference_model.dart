class PreferenceModel {
  int? id;
  int? userId;
  String? generalRequirement;
  String? country;
  int? minAge;
  int? maxAge;
  String? minHeight;
  String? max_height;
  String? maxWeight;
  String? maritalStatus;
  String? religion;
  int? smokingStatus;
  int? drinkingStatus;
  List<String>? language;
  String? minDegree;
  String? profession;
  String? financialCondition;
  String? createdAt;
  String? updatedAt;
  String? motherTongue;
  String? community;

  PreferenceModel(
      {this.id,
        this.userId,
        this.generalRequirement,
        this.country,
        this.minAge,
        this.maxAge,
        this.minHeight,
        this.max_height,
        this.maxWeight,
        this.maritalStatus,
        this.religion,

        this.smokingStatus,
        this.drinkingStatus,
        this.language,
        this.minDegree,
        this.profession,

        this.financialCondition,
        this.createdAt,
        this.updatedAt,
        this.motherTongue,
        this.community});

  PreferenceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    generalRequirement = json['general_requirement'];
    country = json['country'];
    minAge = json['min_age'];
    maxAge = json['max_age'];
    minHeight = json['min_height'];
    max_height = json['max_height'];
    maxWeight = json['max_weight'];
    maritalStatus = json['marital_status'];
    religion = json['religion'];

    smokingStatus = json['smoking_status'];
    drinkingStatus = json['drinking_status'];
    language = json['language'].cast<String>();
    minDegree = json['min_degree'];
    profession = json['profession'];

    financialCondition = json['financial_condition'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    motherTongue = json['mother_tongue'];
    community = json['community'];
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
    data['max_height'] = this.max_height;
    data['max_weight'] = this.maxWeight;
    data['marital_status'] = this.maritalStatus;
    data['religion'] = this.religion;
  data['smoking_status'] = this.smokingStatus;
    data['drinking_status'] = this.drinkingStatus;
    data['language'] = this.language;
    data['min_degree'] = this.minDegree;
    data['profession'] = this.profession;

    data['financial_condition'] = this.financialCondition;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['mother_tongue'] = this.motherTongue;
    data['community'] = this.community;
    return data;
  }
}
