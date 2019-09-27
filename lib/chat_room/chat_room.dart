import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/chat_room/bloc/bloc.dart';
import 'package:flutter_firebase_login/chat_room/bloc/chatroom_bloc.dart';
import 'package:flutter_firebase_login/chat_room/bloc/chatroom_event.dart';
import 'package:flutter_firebase_login/main.dart';
import 'package:flutter_firebase_login/makearoom/bloc/bloc.dart';
import 'package:flutter_firebase_login/play_roomoneonone/play_roomone.dart';
import 'package:flutter_firebase_login/play_roomoneonone/play_roomonescreen.dart';
import 'package:flutter_firebase_login/user_repository.dart';

class ChatRoom extends StatefulWidget {
  UserRepository _userRepository;
  ChatRoom({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  UserRepository get _userRepository => widget._userRepository;

  String text;
  TextEditingController _controller;
  final List<String> avatars = [
    "assets/image/logo_utama.png",
    "assets/image/logo_utama.png",
  ];
  final List<Message> messages = [Message(0, "Oke "), Message(1, "Masuk ya..")];
  final rand = Random();
  ChatroomBloc _chatroomBloc;
  @override
  void initState() {
    super.initState();
    _chatroomBloc = BlocProvider.of<ChatroomBloc>(context);

    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatroomBloc, ChatroomState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Chat Room"),
          backgroundColor: Colors.grey.shade800,
          leading: IconButton(
            onPressed: () {
              _chatroomBloc.dispatch(ExitChat());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => App(
                            userRepository: _userRepository,
                          )));
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayRoomoneScreen(
                                userRepository: _userRepository,
                              )));
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('Ready')),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            BelumAdaPemain(),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10.0);
                },
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  Message m = messages[index];
                  if (m.user == 0) return _buildMessageRow(m, current: true);
                  return _buildMessageRow(m, current: false);
                },
              ),
            ),
            _buildBottomBar(context),
          ],
        ),
      );
    });
  }

  Container _buildBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: _controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: "Type..."),
              onEditingComplete: _save,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.grey.shade800,
            onPressed: _save,
          )
        ],
      ),
    );
  }

  _save() async {
    if (_controller.text.isEmpty) return;
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      messages.insert(0, Message(rand.nextInt(2), _controller.text));
      _controller.clear();
    });
  }

  Row _buildMessageRow(Message message, {bool current}) {
    return Row(
      mainAxisAlignment:
          current ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
          current ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: current ? 30.0 : 20.0),
        if (!current) ...[
          CircleAvatar(
            backgroundImage: AssetImage(
              current ? avatars[0] : avatars[1],
            ),
            radius: 20.0,
          ),
          const SizedBox(width: 5.0),
        ],
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          decoration: BoxDecoration(
              color: current ? Colors.grey.shade800 : Colors.white,
              borderRadius: BorderRadius.circular(10.0)),
          child: Text(
            message.description,
            style: TextStyle(
                color: current ? Colors.white : Colors.black, fontSize: 18.0),
          ),
        ),
        if (current) ...[
          const SizedBox(width: 5.0),
          CircleAvatar(
            backgroundImage: AssetImage(
              current ? avatars[0] : avatars[1],
            ),
            radius: 10.0,
          ),
        ],
        SizedBox(width: current ? 20.0 : 30.0),
      ],
    );
  }
}

class BelumAdaPemain extends StatelessWidget {
  const BelumAdaPemain({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Belum ada pemain lain yang memasuki room ",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class Message {
  final int user;
  final String description;

  Message(this.user, this.description);
}
