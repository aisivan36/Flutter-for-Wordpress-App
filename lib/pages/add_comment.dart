import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wordpress_app/common/constants.dart';
import 'package:flutter_wordpress_app/models/comment.dart';
import 'package:http/http.dart' as http;

Future<bool> postComment(
    int id, String name, String email, String website, String comment) async {
  try {
    var getU = AddModelComment(
      id: id,
      email: email,
      comment: comment,
      name: name,
      website: website,
    );
    var response = await http.post(
        Uri.parse("$wordpressUrl/wp-json/wp/v2/comments"),
        body: getU.toJson()
        //     , body: {
        //   "author_email": email.trim().toLowerCase(),
        //   "author_name": name,
        //   "author_website": website,
        //   "content": comment,
        //   "post": id.toString()
        // }
        );
    print(response);

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  } catch (e) {
    throw Exception('Failed to post comment');
  }
}

class AddComment extends StatefulWidget {
  final int commentId;

  const AddComment(this.commentId, {Key? key}) : super(key: key);
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _email = "";
  String _website = "";
  String _comment = "";

  @override
  Widget build(BuildContext context) {
    int commentId = widget.commentId;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Add Comment',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Poppins')),
          elevation: 5,
          backgroundColor: Colors.white,
        ),
        body: Builder(builder: (BuildContext context) {
          return SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 36, 24, 36),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Name *',
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name.';
                              }
                              return null;
                            },
                            onSaved: (String? val) {
                              _name = val.toString();
                            }),
                        TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email *',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email.';
                              }
                              return null;
                            },
                            onSaved: (String? val) {
                              _email = val.toString();
                            }),
                        TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Website',
                            ),
                            onSaved: (String? val) {
                              _website = val.toString();
                            }),
                        TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Comment *',
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Write some comment.';
                              }
                              return null;
                            },
                            onSaved: (String? val) {
                              _comment = val.toString();
                            }),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 36.0),
                          height: 120,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                postComment(commentId, _name, _email, _website,
                                        _comment)
                                    .then((back) {
                                  if (back) {
                                    Navigator.of(context).pop();
                                  } else {
                                    const snackBar = SnackBar(
                                        content: Text(
                                            'Error while posting comment. Try again.'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                });
                              }
                            },
                            label: const Text(
                              'Send Comment',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const Text(
                          "Note: Your posted comment will appear in comments section once admin approve it.",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ) // Build this out in the next steps.
                    ),
              ),
            ),
          );
        }));
  }
}
