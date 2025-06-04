class SlidesModel {
  String? status;
  List<Data>? data;

  SlidesModel({this.status, this.data});

  SlidesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null && json['data'] is List) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? slideImage;

  Data({this.slideImage});

  Data.fromJson(Map<String, dynamic> json) {
    slideImage = json['slide_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['slide_image'] = this.slideImage;
    return data;
  }
}
