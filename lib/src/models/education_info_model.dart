// class EducationInfoModel {
//   int? id;
//   int? userId;
//   String? degree;
//   String? fieldOfStudy;
//   String? institute;
//   int? regNo;
//   int? rollNo;
//   String? outOf;
//   String? result;
//   String? start;
//   String? end;
//   String? createdAt;
//   String? updatedAt;
//
//   EducationInfoModel(
//       {this.id,
//         this.userId,
//         this.degree,
//         this.fieldOfStudy,
//         this.institute,
//         this.regNo,
//         this.rollNo,
//         this.outOf,
//         this.result,
//         this.start,
//         this.end,
//         this.createdAt,
//         this.updatedAt});
//
//   EducationInfoModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     degree = json['degree'];
//     fieldOfStudy = json['field_of_study'];
//     institute = json['institute'];
//     regNo = json['reg_no'];
//     rollNo = json['roll_no'];
//     outOf = json['out_of'];
//     result = json['result'];
//     start = json['start'];
//     end = json['end'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['degree'] = this.degree;
//     data['field_of_study'] = this.fieldOfStudy;
//     data['institute'] = this.institute;
//     data['reg_no'] = this.regNo;
//     data['roll_no'] = this.rollNo;
//     data['out_of'] = this.outOf;
//     data['result'] = this.result;
//     data['start'] = this.start;
//     data['end'] = this.end;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
