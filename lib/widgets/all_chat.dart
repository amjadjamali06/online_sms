import '../models/message_model.dart';
import '../screens/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';


Widget allChat({required List<Message> listOfMessages}){
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Text(
              'All Chats',
              style: MyTheme.heading2,
            ),
          ],
        ),
      ),
      ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: listOfMessages.length,
          itemBuilder: (context, int index) {
            final allChat = listOfMessages[index];
            return Container(
                margin: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                          return ChatRoom(user: listOfMessages[index].sender,listOfMessage:listOfMessages[index].messages);
                        }));
                  },
                  child: Row(
                    children: [
                      listOfMessages[index].thumbnail==null ?
                      const CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage('assets/images/user_icon.png'),
                      ):
                      CircleAvatar(
                          radius: 28,
                          backgroundImage: MemoryImage(listOfMessages[index].thumbnail!)),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              listOfMessages[index].sender.name,
                              style: MyTheme.heading2.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              listOfMessages[index].text,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: MyTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          listOfMessages[index].unreadCount == 0
                              ? Icon(
                            Icons.done_all,
                            color: MyTheme.bodyTextTime.color,
                          )
                              : CircleAvatar(
                            radius: 8,
                            backgroundColor: MyTheme.kUnreadChatBG,
                            child: Text(
                              listOfMessages[index].unreadCount.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            listOfMessages[index].time,
                            style: MyTheme.bodyTextTime,
                          )
                        ],
                      ),
                    ],
                  ),
                ));
          })
    ],
  );
}
