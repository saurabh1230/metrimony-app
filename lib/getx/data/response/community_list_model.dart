
class CommunityListModel {
  int? id;
  String? name;
  int? religionId;
  String? createdAt;
  String? updatedAt;

  CommunityListModel(
      {this.id, this.name, this.religionId, this.createdAt, this.updatedAt});

  CommunityListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    religionId = json['religion_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['religion_id'] = this.religionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
