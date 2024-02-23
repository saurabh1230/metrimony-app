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
