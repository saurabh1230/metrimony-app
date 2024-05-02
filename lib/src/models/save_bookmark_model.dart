class SaveBookMarkModel {
  bool? status;
  Data? data;
  String? message;

  SaveBookMarkModel({this.status, this.data, this.message});

  SaveBookMarkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  Null? bookmarkUser;
  int? bookmark;

  Data({this.bookmarkUser, this.bookmark});

  Data.fromJson(Map<String, dynamic> json) {
    bookmarkUser = json['bookmarkUser'];
    bookmark = json['bookmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookmarkUser'] = this.bookmarkUser;
    data['bookmark'] = this.bookmark;
    return data;
  }
}
