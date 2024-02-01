import 'dart:async';
import 'dart:convert';

import '../../../constants.dart';
import '/models/Chat.dart';
import 'package:flutter/material.dart';
import 'body_chat.dart';
import 'package:http/http.dart' as http;

class ChatCard extends StatefulWidget {
  ChatCard({
    Key? key,
    required this.chat,
    required this.press,
  }) : super(key: key);

  final Chat chat;
  final VoidCallback press;

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  int _unreadCount = 0;


  @override
  void initState() {
    super.initState();
    _fetchData(widget.chat.id);
    if(userId !=0){
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        _fetchData(widget.chat.id);
      });
    }
  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  Future<void> _fetchData(int doctorId) async {
    print("aaa33333333333");
    final url = '$localhost/api/rec_msg/$userId/$doctorId';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final newUnreadCount = data['unread_count'];
    if (newUnreadCount != _unreadCount) {
      setState(() {
        _unreadCount = newUnreadCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = Color.fromRGBO(231, 18, 18, 0.0);
    if (_unreadCount > 0) {
      cardColor = Colors.grey[200]!;
    }
    return Container(
      color: cardColor,
      child: InkWell(
        onTap: widget.press,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding * 0.75,
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(widget.chat.image),
                  ),
                  if (widget.chat.isActive)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chat.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Opacity(
                        opacity: 0.64,
                        child: Text(
                          widget.chat.specialization,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _unreadCount > 0,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimaryColor,
                  ),
                  child: Center(
                    child: Text(
                      '$_unreadCount',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
