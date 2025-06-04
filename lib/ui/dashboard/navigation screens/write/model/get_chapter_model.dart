class GetChaptersModel {
  String? status;
  List<Chapters>? chapters;

  GetChaptersModel({this.status, this.chapters});

  GetChaptersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapters {
  int? chapterId;
  int? userId;
  int? bookId;
  String? chapterTitle;
  String? chapterContent;
  String? createdAt;
  String? updatedAt;

  Chapters(
      {this.chapterId,
        this.userId,
        this.bookId,
        this.chapterTitle,
        this.chapterContent,
        this.createdAt,
        this.updatedAt});

  Chapters.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapter_id'];
    userId = json['user_id'];
    bookId = json['book_id'];
    chapterTitle = json['chapter_title'];
    chapterContent = json['chapter_content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_id'] = this.chapterId;
    data['user_id'] = this.userId;
    data['book_id'] = this.bookId;
    data['chapter_title'] = this.chapterTitle;
    data['chapter_content'] = this.chapterContent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
