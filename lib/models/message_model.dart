import './user_model.dart';

class Message {
  final User sender;
  String avatar='';
  final String time;
  final int unreadCount;
  final bool isRead;
  final String text;

  Message({
    required this.sender,
    required this.time,
    this.unreadCount=0,
    required this.text,
    this.isRead=false,
  }){
    this.avatar = sender.avatar;
  }
}

final List<Message> recentChats = [
  Message(
    sender: addison,
    time: '01:25',
    text: "typing...",
    unreadCount: 1,
    isRead: false,
  ),
  Message(
    sender: jason,
    time: '12:46',
    text: "Will I be in it?",
    unreadCount: 1,
    isRead: false,
  ),
  Message(
    sender: deanna,
    time: '05:26',
    text: "That's so cute.",
    unreadCount: 3,
    isRead: false,
  ),
  Message(
      sender: nathan,
      time: '12:45',
      text: "Let me see what I can do.",
      unreadCount: 2,
    isRead: false,
  ),
];

final List<Message> allChats = [
  Message(
    sender: virgil,
    time: '12:59',
    text: "No! I just wanted",
    unreadCount: 0,
    isRead: true,
  ),
  Message(
    sender: stanley,
    time: '10:41',
    text: "You did what?",
    unreadCount: 1,
    isRead: false,
  ),
  Message(
    sender: leslie,
    time: '05:51',
    unreadCount: 0,
    isRead: true,
    text: "just signed up for a tutor",
  ),
  Message(
    sender: judd,
    time: '10:16',
    text: "May I ask you something?",
    unreadCount: 2,
    isRead: false,
  ),
];

final List<Message> messages = [
  Message(
    sender: addison,
    time: '12:09 AM',
    text: "...",
    isRead: false, unreadCount: 0,

  ),
  Message(
    sender: currentUser,
    time: '12:05 AM',
    isRead: true,
    text: "I’m going home.",
  ),
  Message(
    sender: currentUser,
    time: '12:05 AM',
    isRead: true,
    text: "See, I was right, this doesn’t interest me.",
  ),
  Message(
    sender: addison,
    time: '11:58 PM',
    text: "I sign your paychecks.",
  ),
  Message(
    sender: addison,
    time: '11:58 PM',
    text: "You think we have nothing to talk about?",
  ),
  Message(
    sender: currentUser,
    time: '11:45 PM',
    isRead: true,
    text:
        "Well, because I had no intention of being in your office. 20 minutes ago",
  ),
  Message(
    sender: addison,
    time: '11:30 PM',
    text: "I was expecting you in my office 20 minutes ago.",
  ),
];
