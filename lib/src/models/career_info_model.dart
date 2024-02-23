class CareerInfoModel {
  int? id;
  int? userId;
  String? company;
  String? designation;
  String? start;
  String? end;
  String? createdAt;
  String? updatedAt;

  CareerInfoModel(
      {this.id,
        this.userId,
        this.company,
        this.designation,
        this.start,
        this.end,
        this.createdAt,
        this.updatedAt});

  CareerInfoModel.fromJson(Map<String, dynamic> json) {
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
