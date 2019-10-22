import 'dart:async';
import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/UpdateFirebaseRoom.dart';
import 'package:flutter_firebase_login/chat_room3/bloc/bloc.dart';
import 'package:flutter_firebase_login/main.dart';
import 'package:flutter_firebase_login/oneonone/contoh_soal.dart';
import 'package:flutter_firebase_login/oneonone/oneononescreen.dart';
import 'package:flutter_firebase_login/user_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const3.dart';
import 'fullPhoto3.dart';

class Chat3 extends StatefulWidget {
  final String peerId;
  final String peerAvatar;
  final String email;
  final String bab;
  final String roomEmail;
  final UserRepository userRepository;

  final String matpel;
  final String soal;
  final String tipe;
  final String namaRoom;
  final int user;
  Chat3(
      {Key key,
      @required this.peerId,
      @required this.peerAvatar,
      @required this.userRepository,
      @required this.user,
      this.email,
      @required this.roomEmail,
      this.bab,
      this.matpel,
      this.namaRoom,
      this.tipe,
      this.soal})
      : super(key: key);

  @override
  State createState() => new ChatState(
      roomEmail: roomEmail,
      user: user,
      peerId: peerId,
      peerAvatar: peerAvatar,
      bab: bab,
      userRepository: userRepository,
      namaRoom: namaRoom,
      email: email,
      matpel: matpel,
      tipe: tipe,
      soal: soal);
}

class ChatState extends State<Chat3> {
  ChatState(
      {@required this.email,
      @required this.bab,
      @required this.matpel,
      @required this.soal,
      @required this.namaRoom,
      @required this.userRepository,
      @required this.tipe,
      @required this.roomEmail,
      @required this.user,
      Key key,
      @required this.peerId,
      @required this.peerAvatar});
  String email;
  String bab;
  int user;
  String matpel;
  UserRepository userRepository;
  String tipe;
  String soal;
  String namaRoom;
  String peerId;
  String peerAvatar;
  String roomEmail;
  var listMessage;
  String groupChatId;
  SharedPreferences prefs;
  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();
  ChatroomBloc3 _chatroomBloc;
  @override
  void initState() {
    groupChatId = '';
    _chatroomBloc = BlocProvider.of<ChatroomBloc3>(context);

    readLocal();

    super.initState();
    focusNode.addListener(onFocusChange);
    isLoading = false;
    isShowSticker = false;
    imageUrl = '';
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    if (email.hashCode <= peerId.hashCode) {
      groupChatId = '$namaRoom-$roomEmail';
    } else {
      groupChatId = '$namaRoom-$roomEmail';
    }

    setState(() {});
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String picurl = prefs.getString('picurl');
        await transaction.set(
          documentReference,
          {
            'idFrom': email,
            'idTo': groupChatId,
            'picurl': picurl,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document['idFrom'] == email) {
      // Right (my message)
      return Row(
        children: <Widget>[
          document['type'] == 0
              // Text
              ? Container(
                  child: Text(
                    document['content'],
                    style: TextStyle(color: primaryColor),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: greyColor2,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(
                      bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                      right: 10.0),
                )
              : document['type'] == 1
                  // Image
                  ? Container(
                      child: FlatButton(
                        child: Material(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(themeColor),
                              ),
                              width: 200.0,
                              height: 200.0,
                              padding: EdgeInsets.all(70.0),
                              decoration: BoxDecoration(
                                color: greyColor2,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                'images/img_not_available.jpeg',
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: document['content'],
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FullPhoto(url: document['content'])));
                        },
                        padding: EdgeInsets.all(0),
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    )
                  // Sticker
                  : Container(
                      child: new Image.asset(
                        'images/${document['content']}.gif',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Material(
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(themeColor),
                            ),
                            width: 35.0,
                            height: 35.0,
                            padding: EdgeInsets.all(10.0),
                          ),
                          imageUrl: document['picurl'],
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(width: 35.0),
                document['type'] == 0
                    ? Container(
                        child: Text(
                          document['content'],
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(left: 10.0),
                      )
                    : document['type'] == 1
                        ? Container(
                            child: FlatButton(
                              child: Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          themeColor),
                                    ),
                                    width: 200.0,
                                    height: 200.0,
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: greyColor2,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Material(
                                    child: Image.asset(
                                      'images/img_not_available.jpeg',
                                      width: 200.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: document['content'],
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullPhoto(
                                            url: document['content'])));
                              },
                              padding: EdgeInsets.all(0),
                            ),
                            margin: EdgeInsets.only(left: 10.0),
                          )
                        : Container(
                            child: new Image.asset(
                              'images/${document['content']}.gif',
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                            margin: EdgeInsets.only(
                                bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                                right: 10.0),
                          ),
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document['timestamp']))),
                      style: TextStyle(
                          color: greyColor,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] == email) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] != email) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Firestore.instance
          .collection('user')
          .document(email)
          .updateData({'playwith': "null"});
      Navigator.pop(context);
      UpdateFirebaseRoom.exitRoom(
          tipe: tipe, email: email, namaRoom: namaRoom, roomEmail: roomEmail);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure..?'),
              content: new Text('Do you want to exit the room?  '),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () {
                    UpdateFirebaseRoom.exitRoom(
                        tipe: tipe,
                        email: email,
                        namaRoom: namaRoom,
                        roomEmail: roomEmail);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => App(
                                  userRepository: userRepository,
                                )));
                  },
                  child: new Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    var style2 = TextStyle(
        color: Colors.grey[600], fontFamily: "MonsterratBold", fontSize: 12.0);
    return BlocBuilder<ChatroomBloc3, ChatroomState3>(
        bloc: _chatroomBloc,
        builder: (context, state) {
          if (state.isPlay) {
            return OneScreen(
              email: email,
              namaRoom: namaRoom,
              pertanyaan: listModelPertanyaan,
              roomEmail: roomEmail,
              tipe: tipe,
              userRepository: userRepository,
            );
          } else {
            {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Scaffold(
                      appBar: buildAppBar(state, _onWillPop),
                      body: buildWillPopScope(style2)),
                  state.isReady
                      ? buildMaterialWait("Wait for opponent ready..")
                      : Container(),
                ],
              );
            }
          }
        });
  }

  StreamBuilder buildMaterialWait(String text) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('$tipe')
            .document('$roomEmail $namaRoom')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Material(
              color: Colors.black87,
              child: new InkWell(
                onTap: () {},
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                    new Container(
                        child: Text(
                      "Check your internet connection..",
                      style: TextStyle(
                          fontFamily: "MonsterratBold", color: Colors.white),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: RaisedButton(
                        color: Colors.white,
                        child: Text("Cancel"),
                        onPressed: () {
                          _chatroomBloc.dispatch(CancelClicked(
                              email: email,
                              namaRoom: namaRoom,
                              roomEmail: roomEmail,
                              tipe: tipe));
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            var userDocument = snapshot.data;
            var _results = userDocument['isi_room'];
            int x = 0;
            for (var entry in _results.entries) {
              x += entry.value;
            }
            if (tipe == "One On One" && x == 4) {
              print(x);
              print("asu");
              _chatroomBloc.dispatch(PlayOneOnOne(
                  email: email,
                  namaRoom: namaRoom,
                  roomEmail: roomEmail,
                  tipe: tipe));
            }
            return Material(
              color: Colors.black87,
              child: new InkWell(
                onTap: () {},
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                    new Container(
                        child: Text(
                      text,
                      style: TextStyle(
                          fontFamily: "MonsterratBold", color: Colors.white),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: RaisedButton(
                        color: Colors.white,
                        child: Text("Cancel"),
                        onPressed: () {
                          _chatroomBloc.dispatch(CancelClicked(
                              email: email,
                              namaRoom: namaRoom,
                              roomEmail: roomEmail,
                              tipe: tipe));
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }

  WillPopScope buildWillPopScope(TextStyle style2) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              Container(
                color: Colors.teal[200],
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                FontAwesomeIcons.userCircle,
                                color: Colors.white,
                              ),
                            ),
                            StreamBuilder(
                                stream: Firestore.instance
                                    .collection('room')
                                    .document('$roomEmail $namaRoom')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return new Text("0 Online");
                                  }
                                  var userDocument = snapshot.data;
                                  if (userDocument["user"] >= 2) {
                                    _chatroomBloc.dispatch(RoomFull());
                                  } else {
                                    _chatroomBloc.dispatch(RoomNotFull());
                                  }

                                  return new Text(
                                    "${userDocument["user"]} Online",
                                    style: style2,
                                  );
                                }),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Icon(
                                FontAwesomeIcons.gamepad,
                                color: Colors.white,
                              ),
                            ),
                            Text("$tipe", style: style2),
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                FontAwesomeIcons.chalkboard,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "$matpel",
                              style: style2,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                FontAwesomeIcons.book,
                                color: Colors.white,
                              ),
                            ),
                            Text("$bab ($soal)", style: style2),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              buildListMessage(),

              // Sticker
              (isShowSticker ? buildSticker() : Container()),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  AppBar buildAppBar(ChatroomState3 state, Future<bool> _onWillPop()) {
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: RaisedButton(
            color: Colors.teal[300],
            onPressed: () {
              if (state.isFull) {
                print("ready!");
                _chatroomBloc.dispatch(ReadyClicked(
                    email: email,
                    namaRoom: namaRoom,
                    roomEmail: roomEmail,
                    tipe: tipe));
              } else {
                Fluttertoast.showToast(
                    msg: "Wait for other player before start the game.");
              }
            },
            child: state.isFull
                ? SizedBox(
                    width: 100.0,
                    child: Center(
                      child: Text(
                        "Ready",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "MonsterratBold",
                            color: Colors.white),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 100.0,
                    child: Center(
                      child: FadeAnimatedTextKit(
                          text: ["Wait", "For", "Other", "Player"],
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                          alignment: AlignmentDirectional
                              .topStart // or Alignment.topLeft
                          ),
                    )),

            // : Text(
            //     "Wait Other Player",
            //     style: TextStyle(
            //         fontFamily: "MonsterratBold",
            //         color: Colors.white),
            //   ),
          ),
        )
      ],
      title: Text(
        "$namaRoom",
        style: TextStyle(color: Colors.black, fontFamily: "MonsterratBold"),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.exit_to_app,
          color: Colors.black,
        ),
        onPressed: _onWillPop,
      ),
    );
  }

  Widget buildSticker() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi1', 2),
                child: new Image.asset(
                  'images/mimi1.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi2', 2),
                child: new Image.asset(
                  'images/mimi2.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi3', 2),
                child: new Image.asset(
                  'images/mimi3.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi4', 2),
                child: new Image.asset(
                  'images/mimi4.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi5', 2),
                child: new Image.asset(
                  'images/mimi5.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi6', 2),
                child: new Image.asset(
                  'images/mimi6.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi7', 2),
                child: new Image.asset(
                  'images/mimi7.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi8', 2),
                child: new Image.asset(
                  'images/mimi8.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi9', 2),
                child: new Image.asset(
                  'images/mimi9.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.face),
                onPressed: getSticker,
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: greyColor),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
          : StreamBuilder(
              stream: Firestore.instance
                  .collection('messages')
                  .document(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .limit(20)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(themeColor)));
                } else {
                  listMessage = snapshot.data.documents;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(index, snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }
}
