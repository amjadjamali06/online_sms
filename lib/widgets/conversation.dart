
import 'package:sms_advanced/sms_advanced.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';
import '../app_theme.dart';
import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  const Conversation({
    Key? key,
    required this.user, required this.listOfMessage,
  }) : super(key: key);

  final User user;
  final List<SmsMessage> listOfMessage;
    _Conversation createState() => _Conversation();

}
class _Conversation extends State<Conversation>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        itemCount: widget.listOfMessage.length,
        itemBuilder: (context, int index) {
          final message = widget.listOfMessage[index];
          //bool isMe = user.id == currentUser.id;
          bool isMe = message.kind==SmsMessageKind.Sent;
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isMe)
                      const CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage('assets/images/user_icon.png'),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6),
                      decoration: BoxDecoration(
                          color: isMe ? MyTheme.kAccentColor : Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(isMe ? 12 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 12),
                          )),
                      child: Text(
                        message.body??'',
                        style: MyTheme.bodyTextMessage.copyWith(
                            color: isMe ? Colors.white : Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe)
                        SizedBox(
                          width: 40,
                        ),
                      Icon(
                        Icons.done_all,
                        size: 20,
                        color: MyTheme.bodyTextTime.color,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        message.date.toString()??'',
                        style: MyTheme.bodyTextTime,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

