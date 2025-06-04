class DiscoverModel {
  String? status;
  List<Data>? data;

  DiscoverModel({this.status, this.data});

  DiscoverModel.fromJson(Map<String, dynamic> json) {
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
  String? tagId;
  String? tagName;
  List<Books>? books;

  Data({this.tagId, this.tagName, this.books});

  Data.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    tagName = json['tag_name'];
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['tag_name'] = this.tagName;
    if (this.books != null) {
      data['books'] = this.books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  String? bookCoverImage;
  int? bookId;
  int? tagId;
  String? bookTitle;
  String? genre;
  String? tagName;

  Books(
      {this.bookCoverImage,
        this.bookId,
        this.tagId,
        this.bookTitle,
        this.genre,
        this.tagName});

  Books.fromJson(Map<String, dynamic> json) {
    bookCoverImage = json['book_cover_image'];
    bookId = json['book_id'];
    tagId = json['tag_id'];
    bookTitle = json['book_title'];
    genre = json['genre'];
    tagName = json['tag_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_cover_image'] = this.bookCoverImage;
    data['book_id'] = this.bookId;
    data['tag_id'] = this.tagId;
    data['book_title'] = this.bookTitle;
    data['genre'] = this.genre;
    data['tag_name'] = this.tagName;
    return data;
  }
}
