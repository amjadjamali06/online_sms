import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:online_sms/services/user_service.dart';
import 'package:sms_advanced/sms_advanced.dart';
import '../app_theme.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key, required this.user, required this.listOfMessage}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
  final User user;
  final List<SmsMessage> listOfMessage;
}

class _ChatRoomState extends State<ChatRoom> {

  TextEditingController messageTypeController=TextEditingController();
  SmsMessage? replyToMessage;

  Future<void> onSend(String? addressed) async{
    if(addressed!=''){
     dynamic response=await UserService().sendSMSService(phoneNumber: (replyToMessage!.body??'').split('\n\t\nFrom: ').last,message: messageTypeController.text);
     print('========================>>$response');
     messageTypeController.clear();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: false,
        backgroundColor: MyTheme.kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'assets/images/user_icon.png',
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name!=''?widget.user.name:widget.user.phoneNUm,
                    style: MyTheme.chatSenderName,
                  ),
                  Text(
                    // 'online',
                    widget.user.phoneNUm,
                    style: MyTheme.bodyText1.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.videocam_outlined,
                size: 28,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.call,
                size: 28,
              ),
              onPressed: () {})
        ],
        elevation: 0,
      ),
      backgroundColor: MyTheme.kPrimaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: conversation(),
                ),
              ),
            ),
            buildChatComposer()
          ],
        ),
      ),
    );
  }

  Widget conversation(){
    return ListView.builder(
        reverse: true,
        itemCount: widget.listOfMessage.length,
        itemBuilder: (context, int index) {
          final message = widget.listOfMessage[index];
          List<String> msgBodies = (message.body??'').split('\n\t\nFrom: ');
          bool hasNumber=msgBodies.length>1;
          //bool isMe = user.id == currentUser.id;
          bool isMe = message.kind==SmsMessageKind.Sent;
          return Container(
            margin: const EdgeInsets.only(top: 10),
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
                            topLeft: Radius.circular(isMe ? 12 : 0),
                            topRight: const Radius.circular(12),
                            bottomLeft: const Radius.circular(12),
                            bottomRight: Radius.circular(isMe ? 0 : 12),
                          )),
                      child: Text.rich(TextSpan(
                        children: [
                          if(msgBodies.length>1)
                          TextSpan(
                              text:"${msgBodies.last}\n",
                            style: MyTheme.heading2.copyWith(fontSize: 14)
                          ),
                          TextSpan(
                              text:msgBodies.first,
                          ),
                        ],
                        style: MyTheme.bodyTextMessage.copyWith(
                            color: isMe ? Colors.white : Colors.grey[800]),
                      ))
                      /*Text(
                        (replyToMessage!.body??'').split('\n\t\nFrom: ').first,
                        style: MyTheme.bodyTextMessage.copyWith(
                            color: isMe ? Colors.white : Colors.grey[800]),
                      )*/,

                    ),
                    if(!isMe && msgBodies.length>1)
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            replyToMessage = message;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(Icons.reply),
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
                        const SizedBox(width: 40),
                      Icon(
                        Icons.done,
                        size: 20,
                        color: MyTheme.bodyTextTime.color,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        message.date.toString(),
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

  Container buildChatComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      color: Colors.white,
      // height: 70,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              // height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(replyToMessage!=null)
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Text.rich(TextSpan(
                          children: [
                              TextSpan(
                                  text:"${(replyToMessage!.body??'').split('\n\t\nFrom: ').last}\n",
                                  style: MyTheme.heading2.copyWith(fontSize: 12)
                              ),
                            TextSpan(
                              text:(replyToMessage!.body??'').split('From:').first,
                                style: MyTheme.bodyTextMessage.copyWith(
                                    color: Colors.grey[500], fontSize: 10)
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        ),

                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                            onTap: (){
                              setState(() {
                                replyToMessage = null;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(CupertinoIcons.xmark, color: Colors.grey, size: 15,),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: messageTypeController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type your message ...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.attach_file,
                        color: Colors.grey[500],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          CircleAvatar(
            backgroundColor: MyTheme.kPrimaryColorVariant,
            child: GestureDetector(
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              onTap: (){
                print(messageTypeController.text);
                onSend(widget.user.phoneNUm);
              },
            ),
          )
        ],
      ),
    );
  }
}
