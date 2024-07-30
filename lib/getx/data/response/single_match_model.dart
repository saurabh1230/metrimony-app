class SingleMatchModel {
  int? id;
  int? profileId;
  String? firstname;
  String? lastname;
  Address? address;
  String? image;
  String? community;
  String? gender;
  String? religionName;
  String? professionName;
  int? bookmark;
  int? interestStatus;
  BasicInfo? basicInfo;
  List<CareerInfo>? careerInfo;

  SingleMatchModel({
    this.id,
    this.profileId,
    this.firstname,
    this.lastname,
    this.address,
    this.image,
    this.community,
    this.gender,
    this.religionName,
    this.professionName,
    this.bookmark,
    this.interestStatus,
    this.basicInfo,
    this.careerInfo,
  });

  SingleMatchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0;
    profileId = json['profile_id'] is int ? json['profile_id'] : int.tryParse(json['profile_id'].toString()) ?? 0;
    firstname = json['firstname']?.toString();
    lastname = json['lastname']?.toString();
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    image = json['image']?.toString();
    community = json['community']?.toString();
    gender = json['gender']?.toString();
    religionName = json['religion_name']?.toString();
    professionName = json['profession_name']?.toString();
    bookmark = json['bookmark'] is int ? json['bookmark'] : int.tryParse(json['bookmark'].toString()) ?? 0;
    interestStatus = json['interestStatus'] is int ? json['interestStatus'] : int.tryParse(json['interestStatus'].toString()) ?? 0;
    basicInfo = json['basic_info'] != null ? BasicInfo.fromJson(json['basic_info']) : null;
    if (json['career_info'] != null) {
      careerInfo = <CareerInfo>[];
      json['career_info'].forEach((v) {
        careerInfo!.add(CareerInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['profile_id'] = this.profileId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;

    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }

    data['image'] = this.image;
    data['community'] = this.community;
    data['gender'] = this.gender;
    data['religion_name'] = this.religionName;
    data['profession_name'] = this.professionName;
    data['bookmark'] = this.bookmark;
    data['interestStatus'] = this.interestStatus;
    if (this.basicInfo != null) {
      data['basic_info'] = this.basicInfo!.toJson();
    }

    if (this.careerInfo != null) {
      data['career_info'] = this.careerInfo!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}



class Address {
  String? address;
  String? district;
  String? state;
  String? zip;
  String? country;

  Address({this.address, this.district, this.state, this.zip, this.country});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    district = json['district'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = this.address;
    data['district'] = this.district;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    return data;
  }
}

class BasicInfo {
  int? id;
  int? userId;
  String? gender;
  String? profession;
  String? religion;
  String? birthDate;
  PresentAddress? presentAddress;
  PermanentAddress? permanentAddress;
  String? community;
  String? motherTongue;
  String? cadar;

  BasicInfo(
      {this.id,
        this.userId,
        this.gender,
        this.profession,
        this.religion,
        this.birthDate,
        this.presentAddress,
        this.permanentAddress,
        this.community,
        this.motherTongue,
        this.cadar,
     });

  BasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    gender = json['gender'];
    profession = json['profession'];
    religion = json['religion'];

    birthDate = json['birth_date'];

    presentAddress = json['present_address'] != null ? PresentAddress.fromJson(json['present_address']) : null;
    permanentAddress = json['permanent_address'] != null ? PermanentAddress.fromJson(json['permanent_address']) : null;

    community = json['community'];
    motherTongue = json['mother_tongue'];


    cadar = json['cadar'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_id'] = this.userId;

    data['gender'] = this.gender;
    data['profession'] = this.profession;

    data['religion'] = this.religion;

    data['birth_date'] = this.birthDate;

    if (this.presentAddress != null) {
      data['present_address'] = this.presentAddress!.toJson();
    }
    if (this.permanentAddress != null) {
      data['permanent_address'] = this.permanentAddress!.toJson();
    }

    data['community'] = this.community;
    data['mother_tongue'] = this.motherTongue;

    data['cadar'] = this.cadar;

    return data;
  }
}

class PresentAddress {
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;

  PresentAddress({this.address, this.city, this.state, this.zip, this.country});

  PresentAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    return data;
  }
}

class PermanentAddress {
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;

  PermanentAddress({this.address, this.city, this.state, this.zip, this.country});

  PermanentAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    return data;
  }
}

class CareerInfo {
  int? id;
  String? jobTitle;
  String? companyName;
  String? location;
  String? startDate;
  String? endDate;

  CareerInfo({this.id, this.jobTitle, this.companyName, this.location, this.startDate, this.endDate});

  CareerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobTitle = json['job_title'];
    companyName = json['company_name'];
    location = json['location'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['job_title'] = this.jobTitle;
    data['company_name'] = this.companyName;
    data['location'] = this.location;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}

class PartnerExpectation {
  String? height;
  String? age;
  String? religion;
  String? community;
  String? caste;

  PartnerExpectation({this.height, this.age, this.religion, this.community, this.caste});

  PartnerExpectation.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    age = json['age'];
    religion = json['religion'];
    community = json['community'];
    caste = json['caste'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = this.height;
    data['age'] = this.age;
    data['religion'] = this.religion;
    data['community'] = this.community;
    data['caste'] = this.caste;
    return data;
  }
}

class PhysicalAttributes {
  String? height;
  String? weight;
  String? eyeColor;
  String? hairColor;

  PhysicalAttributes({this.height, this.weight, this.eyeColor, this.hairColor});

  PhysicalAttributes.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    eyeColor = json['eye_color'];
    hairColor = json['hair_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['eye_color'] = this.eyeColor;
    data['hair_color'] = this.hairColor;
    return data;
  }
}

class EducationInfo {
  int? id;
  String? degree;
  String? institution;
  String? yearOfPassing;
  String? location;

  EducationInfo({this.id, this.degree, this.institution, this.yearOfPassing, this.location});

  EducationInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    degree = json['degree'];
    institution = json['institution'];
    yearOfPassing = json['year_of_passing'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['degree'] = this.degree;
    data['institution'] = this.institution;
    data['year_of_passing'] = this.yearOfPassing;
    data['location'] = this.location;
    return data;
  }
}
