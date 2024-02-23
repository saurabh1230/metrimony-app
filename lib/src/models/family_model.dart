class FamilyModel {
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

  FamilyModel(
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

  FamilyModel.fromJson(Map<String, dynamic> json) {
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
