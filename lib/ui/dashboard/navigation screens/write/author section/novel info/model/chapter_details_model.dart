class ChapterDetailModel {
  int? chapterId;
  int? userId;
  int? bookId;
  String? chapterTitle;
  String? chapterContent;
  String? createdAt;
  String? updatedAt;

  ChapterDetailModel(
      {this.chapterId,
        this.userId,
        this.bookId,
        this.chapterTitle,
        this.chapterContent,
        this.createdAt,
        this.updatedAt});

  ChapterDetailModel.fromJson(Map<String, dynamic> json) {
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
