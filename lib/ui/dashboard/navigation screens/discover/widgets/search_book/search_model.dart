class SearchModel {
  String? status;
  List<Data>? data;

  SearchModel({this.status, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? bookId;
  String? bookTitle;
  String? novelType;
  String? genre;
  String? authorName;

  Data(
      {this.bookId,
        this.bookTitle,
        this.novelType,
        this.genre,
        this.authorName});

  Data.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    bookTitle = json['book_title'];
    novelType = json['novel_type'];
    genre = json['genre'];
    authorName = json['author_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['book_title'] = this.bookTitle;
    data['novel_type'] = this.novelType;
    data['genre'] = this.genre;
    data['author_name'] = this.authorName;
    return data;
  }
}
