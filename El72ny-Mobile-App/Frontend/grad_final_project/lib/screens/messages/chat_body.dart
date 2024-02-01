import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grad_final_project/constants.dart';
import 'package:grad_final_project/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String image;
  final int id, widid;

  const ChatPage({
    Key? key,
    required this.name,
    required this.image,
    required this.id,
    required this.widid
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  List<dynamic> _messages = [];
  late bool isLoading;

  TextEditingController _textController = TextEditingController();

  Future<void> getMessages(int doctorId) async {
    final url = '$localhost/api/rec_msg/$userId/$doctorId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      setState(() {
        _messages = List<String>.from(responseBody);
      });
    } else {
      print('Error getting messages: ${response.statusCode}');
    }
  }

  Future<void> getallMessages(int doctorId) async {
    final url = '$localhost/api/detail/$userId/$doctorId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      setState(() {
        _messages = responseBody.reversed.toList();
        print(_messages);
      });
    } else {
      print('Error getting messages: ${response.statusCode}');
    }
  }

  Future<void> sendMessage(
      int doctorId, String message, PlatformFile? file) async {
    final url = '$localhost/api/sendd/$doctorId';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'msg': message,
      'user_id': userId.toString(),
      'profile_id': profileId.toString(),
    });
    if (file != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'pic',
          file.bytes!,
          filename: file.name,
        ),
      );
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final messageBody = jsonDecode(responseBody)['body'];
      print(messageBody);

      // Add the sent message to the list
      setState(() {
        _messages.add({
          'model': 'mychatapp.chatmessage',
          'pk': _messages.length + 1, // Generate a new unique ID
          'fields': {
            'body': message,
            'msg_sender': profileId,
            'msg_receiver': doctorId,
            'seen': false,
            'pic': file?.name,
          },
        });
        if (file != null) {
          _messages.add({
            'model': 'mychatapp.chatmessage',
            'pk': _messages.length + 1, // Generate a new unique ID
            'fields': {
              'body': '',
              'msg_sender': profileId,
              'msg_receiver': doctorId,
              'seen': false,
              'pic': file.name,
            },
          });
        }
      });
    } else {
      print('Error sending message: ${response.statusCode}');
    }
  }

  Future<void> markAllMessagesAsSeen(int doctorId) async {
    final response = await http
        .post(Uri.parse('$localhost/api/seen/$userId/$doctorId'));
    if (response.statusCode == 200) {
      setState(() {
        unreadCount = 0;
      });
      print('All messages marked as seen.');
    } else {
      print('Error marking messages as seen: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    getallMessages(widget.id);
    if (userId != 0) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        getallMessages(widget.id);
        markAllMessagesAsSeen(widget.id);
      });
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff566CA6),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                if(widget.widid != 1){
                  Navigator.pop(
                    context,
                  );
                }
                else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ),
                  );
                }

              }
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.image),
            ),
            const SizedBox(width: 20.0 * 0.4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSender = message['fields']['msg_sender'] == profileId;
                final color = isSender ? Color(0xff566CA6) : Colors.black38;
                final alignment =
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start;
                print(
                    'msg_sender: ${message['fields']['msg_sender']}, profile_id:$profileId');
                final borderRadius = isSender
                    ? BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
                    : BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                );

                // return Row(
                //   mainAxisAlignment: alignment,
                //   children: [
                //     if (message['fields']['body'].isNotEmpty)
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         padding: const EdgeInsets.all(16),
                //         decoration: BoxDecoration(
                //           color: color.withOpacity(0.2),
                //           borderRadius: borderRadius,
                //         ),
                //         child: Text(
                //           message['fields']['body'],
                //           style: TextStyle(color: color),
                //         ),
                //       ),
                //     if (message['fields']['pic'] != null)
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         child: Image.network(
                //           'http://127.0.0.1:8000/media/' +
                //               message['fields']['pic'],
                //           height: 100,
                //           width: 100,
                //         ),
                //       ),
                //   ],
                // );
                return Row(
                  mainAxisAlignment: alignment,
                  children: [
                    if (message['fields']['body'].isNotEmpty)
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: borderRadius,
                        ),
                        child: Text(
                          message['fields']['body'],
                          style: TextStyle(color: color),
                        ),
                      ),
                    if (message['fields']['pic'] != null &&
                        message['fields']['body'].isEmpty)
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Image.network(
                          '$localhost/media/' +
                              message['fields']['pic'],
                          height: 200,
                          width: 200,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type your message',
                      fillColor: Colors.black12,
                      filled: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () async {
                    FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                    if (result != null) {
                      PlatformFile file = result.files.first;
                      sendMessage(widget.id, '',
                          file); // Pass the selected file to `sendMessage`
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final message = _textController.text;
                    if (message.isNotEmpty) {
                      sendMessage(widget.id, message, null);
                      _textController.clear();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}