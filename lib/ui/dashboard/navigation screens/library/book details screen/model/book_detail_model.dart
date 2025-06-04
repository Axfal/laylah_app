class BookDetailModel {
  String? status;
  List<Data>? data;

  BookDetailModel({this.status, this.data});

  BookDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? bookTitle;
  String? language;
  String? targetAudience;
  String? contentRating;
  String? novelType;
  String? genre;
  String? description;
  String? bookCoverImage;
  String? authorName;
  int? words;
  int? ongoing;
  int? views;
  int? likes;
  int? numberOfChapters;
  String? updated;
  List<Tags>? tags;
  bool? contractStatus;

  Data(
      {this.bookId,
        this.userId,
        this.bookTitle,
        this.language,
        this.targetAudience,
        this.contentRating,
        this.novelType,
        this.genre,
        this.description,
        this.bookCoverImage,
        this.authorName,
        this.words,
        this.ongoing,
        this.views,
        this.likes,
        this.numberOfChapters,
        this.updated,
        this.tags,
        this.contractStatus});

  Data.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    userId = json['user_id'];
    bookTitle = json['book_title'];
    language = json['language'];
    targetAudience = json['target_audience'];
    contentRating = json['content_rating'];
    novelType = json['novel_type'];
    genre = json['genre'];
    description = json['description'];
    bookCoverImage = json['book_cover_image'];
    authorName = json['author_name'];
    words = json['words'];
    ongoing = json['ongoing'];
    views = json['views'];
    likes = json['likes'];
    numberOfChapters = json['number_of_chapters'];
    updated = json['updated'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    contractStatus = json['contract_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['user_id'] = this.userId;
    data['book_title'] = this.bookTitle;
    data['language'] = this.language;
    data['target_audience'] = this.targetAudience;
    data['content_rating'] = this.contentRating;
    data['novel_type'] = this.novelType;
    data['genre'] = this.genre;
    data['description'] = this.description;
    data['book_cover_image'] = this.bookCoverImage;
    data['author_name'] = this.authorName;
    data['words'] = this.words;
    data['ongoing'] = this.ongoing;
    data['views'] = this.views;
    data['likes'] = this.likes;
    data['number_of_chapters'] = this.numberOfChapters;
    data['updated'] = this.updated;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    data['contract_status'] = this.contractStatus;
    return data;
  }
}

class Tags {
  String? tagId;
  String? tagName;

  Tags({this.tagId, this.tagName});

  Tags.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    tagName = json['tag_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['tag_name'] = this.tagName;
    return data;
  }
}
