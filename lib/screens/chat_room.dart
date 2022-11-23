import 'package:online_sms/services/user_service.dart';
import 'package:sms_advanced/sms_advanced.dart';
import '../app_theme.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/widgets.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key, required this.user, required this.listOfMessage}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
  final User user;
  final List<SmsMessage> listOfMessage;
}

class _ChatRoomState extends State<ChatRoom> {

  TextEditingController messageTypeController=TextEditingController();
  Future<void> onSend(String? addressed,String? messages) async{
    if(addressed!='' && messages!=''){
     dynamic response=await UserService().sendSMSService(phoneNumber: addressed!,message: messages!);
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
                    'online',
                    style: MyTheme.bodyText1.copyWith(fontSize: 18),
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
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage('assets/images/Addison.jpg'),
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
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

  Container buildChatComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
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
            ),
          ),
          SizedBox(
            width: 16,
          ),
          CircleAvatar(
            backgroundColor: MyTheme.kAccentColor,
            child: GestureDetector(
              child: Icon(
                Icons.mic,
                color: Colors.white,
              ),
              onTap: (){
                print(messageTypeController.text);
                onSend(widget.user.phoneNUm,messageTypeController.text);
              },
            ),
          )
        ],
      ),
    );
  }
}
