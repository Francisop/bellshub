import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  getUserByUsername(String username) async {
    return await _firestore
        .collection('users')
        .where("fullname",isEqualTo:username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await _firestore
        .collection('users')
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    try {
      _firestore.collection('users').add(userMap);
    } catch (e) {
      print('uploaduserinfo exception $e');
    }
  }

  createChatRoom(chatRoomId, chatRoomMap) {
    _firestore
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print("createChatRoom Error ${e.toString()}");
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    _firestore
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print("getConversationMessages error $e");
    });
  }

  getConversationMessages(String chatRoomId) async {
    return _firestore
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time')
        .snapshots();
  }

  getChatRooms(String userMatric) async {
    return _firestore
        .collection("ChatRoom")
        .where("users", arrayContains: userMatric)
        .snapshots();
  }
}
