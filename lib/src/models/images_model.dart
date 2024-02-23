class PhotosModel {
  int? id;
  int? userId;
  String? image;
  String? createdAt;
  String? updatedAt;

  PhotosModel(
      {this.id, this.userId, this.image, this.createdAt, this.updatedAt});

  PhotosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
