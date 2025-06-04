class GetLibraryBookModel {
  String? status;
  List<Books>? books;

  GetLibraryBookModel({this.status, this.books});

  GetLibraryBookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.books != null) {
      data['books'] = this.books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  int? id;
  int? userId;
  int? bookId;
  int? tagId;
  String? bookTitle;
  String? language;
  String? targetAudience;
  String? contentRating;
  String? novelType;
  String? genre;
  String? description;
  String? bookCoverImage;
  String? createdAt;
  String? updatedAt;
  Null? authorName;
  int? words;
  int? ongoing;
  int? views;
  int? likes;
  int? numberOfChapters;
  String? updated;
  String? libraryStatus;

  Books(
      {this.id,
        this.userId,
        this.bookId,
        this.tagId,
        this.bookTitle,
        this.language,
        this.targetAudience,
        this.contentRating,
        this.novelType,
        this.genre,
        this.description,
        this.bookCoverImage,
        this.createdAt,
        this.updatedAt,
        this.authorName,
        this.words,
        this.ongoing,
        this.views,
        this.likes,
        this.numberOfChapters,
        this.updated,
        this.libraryStatus});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bookId = json['book_id'];
    tagId = json['tag_id'];
    bookTitle = json['book_title'];
    language = json['language'];
    targetAudience = json['target_audience'];
    contentRating = json['content_rating'];
    novelType = json['novel_type'];
    genre = json['genre'];
    description = json['description'];
    bookCoverImage = json['book_cover_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    authorName = json['author_name'];
    words = json['words'];
    ongoing = json['ongoing'];
    views = json['views'];
    likes = json['likes'];
    numberOfChapters = json['number_of_chapters'];
    updated = json['updated'];
    libraryStatus = json['library_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['book_id'] = this.bookId;
    data['tag_id'] = this.tagId;
    data['book_title'] = this.bookTitle;
    data['language'] = this.language;
    data['target_audience'] = this.targetAudience;
    data['content_rating'] = this.contentRating;
    data['novel_type'] = this.novelType;
    data['genre'] = this.genre;
    data['description'] = this.description;
    data['book_cover_image'] = this.bookCoverImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['author_name'] = this.authorName;
    data['words'] = this.words;
    data['ongoing'] = this.ongoing;
    data['views'] = this.views;
    data['likes'] = this.likes;
    data['number_of_chapters'] = this.numberOfChapters;
    data['updated'] = this.updated;
    data['library_status'] = this.libraryStatus;
    return data;
  }
}
