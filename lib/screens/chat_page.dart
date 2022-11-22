import '../models/message_model.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

Widget  chatPage({required List<Message> listOfMessages,}){
  return SingleChildScrollView(
    child: Column(
      children: [
        //RecentChats(),
       allChat(listOfMessages:  listOfMessages)
      ],
    ),
  );
  }


