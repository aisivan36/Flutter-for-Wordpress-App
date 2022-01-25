import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

Widget commentBox(
    BuildContext context, String author, String avatar, String content) {
  return Card(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: ListTile(
      dense: true,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatar),
      ),
      title: Html(data: content, style: {
        "p": Style(
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.w400,
            fontSize: FontSize.em(1),
            padding: const EdgeInsets.all(4)),
      }),
      subtitle: Container(
        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        padding: const EdgeInsets.fromLTRB(4, 8, 0, 8),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        child: Text(
          author,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    ),
  );
}
