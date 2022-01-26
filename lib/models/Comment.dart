class Comment {
  final int? id;
  final String? author;
  final String? avatar;
  final String? content;

  Comment({this.id, this.author, this.avatar, this.content});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        author: json['author_name'],
        avatar: json['author_avatar_urls']["48"],
        content: json["content"]["rendered"]);
  }
}

class AddModelComment {
  final int? id;
  final String? name, email, website, comment;

  AddModelComment({this.id, this.name, this.email, this.website, this.comment});

  Map<String, dynamic> toJson() => {
        "author_email": email?.trim().toLowerCase(),
        "author_name": name,
        "author_website": website,
        "content": comment,
        "post": id.toString(),
      };
}
