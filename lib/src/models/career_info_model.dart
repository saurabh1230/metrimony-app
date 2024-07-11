// // class CareerInfoModel {
// //   int? id;
// //   int? userId;
// //   String? position;
// //   String? designation;
// //   String? start;
// //   String? end;
// //   String? createdAt;
// //   String? updatedAt;
// //
// //   CareerInfoModel(
// //       {this.id,
// //         this.userId,
// //         this.position,
// //         this.designation,
// //         this.start,
// //         this.end,
// //         this.createdAt,
// //         this.updatedAt});
// //
// //   CareerInfoModel.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     userId = json['user_id'];
// //     position = json['position'];
// //     designation = json['designation'];
// //     start = json['start'];
// //     end = json['end'];
// //     createdAt = json['created_at'];
// //     updatedAt = json['updated_at'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['user_id'] = this.userId;
// //     data['position'] = this.position;
// //     data['designation'] = this.designation;
// //     data['start'] = this.start;
// //     data['end'] = this.end;
// //     data['created_at'] = this.createdAt;
// //     data['updated_at'] = this.updatedAt;
// //     return data;
// //   }
// // }
//
//
//
// class CareerInfoModel {
//   int? id;
//   int? userId;
//   String? position;
//   String? from;
//   String? end;
//   // String? createdAt;
//   // String? updatedAt;
//   String? statePosting;
//   String? districtPosting;
//
//   CareerInfoModel(
//       {this.id,
//         this.userId,
//         this.position,
//         this.from,
//         this.end,
//         // this.createdAt,
//         // this.updatedAt,
//         this.statePosting,
//         this.districtPosting});
//
//   CareerInfoModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     position = json['position'];
//     from = json['from'];
//     end = json['end'];
//     // createdAt = json['created_at'];
//     // updatedAt = json['updated_at'];
//     statePosting = json['state_posting'];
//     districtPosting = json['district_posting'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['position'] = this.position;
//     data['from'] = this.from;
//     data['end'] = this.end;
//     // data['created_at'] = this.createdAt;
//     // data['updated_at'] = this.updatedAt;
//     data['state_posting'] = this.statePosting;
//     data['district_posting'] = this.districtPosting;
//     return data;
//   }
// }
