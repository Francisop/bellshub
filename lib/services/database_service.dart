import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  getUserByUsername(String username) async {
    return await _firestore
        .collection('users')
        .where("fullname", isEqualTo: username)
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

  getUnreadConversations(chatRoomId, myMatric) {
    try {
      return _firestore
          .collection("ChatRoom")
          .doc(chatRoomId)
          .collection('chats')
          .where('read', isEqualTo: false)
          // .where('sendby', isNotEqualTo: myMatric)
          .snapshots();
    } catch (e) {
      print(e);
    }
  }

  setReadConversation(chatRoomId) {
    return _firestore
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chat')
        .doc()
        .update({'read': true});
  }

  getLastMessageSent(chatRoomId) {
    try {
      return _firestore
          .collection("ChatRoom")
          .doc(chatRoomId)
          .collection('chats')
          .orderBy('time', descending: true)
          .limit(1)
          .snapshots();
    } catch (e) {
      print('last message sent error $e');
    }
  }

//////////////////GROUPS////////////////////
  getPermanentGroups() {
    try {
      return _firestore
          .collection('users')
          .doc('q8gt6W4J7FOnihhE4bU7')
          .collection('groups')
          .snapshots();
    } catch (e) {
      print('getpermentgroups error $e');
    }
  }

  addGroupConversationMessages(String groupRoomId, messageMap) {
    _firestore
        .collection('users')
        .doc('q8gt6W4J7FOnihhE4bU7')
        .collection('groups')
        .doc(groupRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print("getConversationMessages error $e");
    });
  }

  getGroupConversationMessages(String groupRoomId) async {
    return _firestore
        .collection('users')
        .doc('q8gt6W4J7FOnihhE4bU7')
        .collection('groups')
        .doc(groupRoomId)
        .collection('chats')
        .orderBy('time')
        .snapshots();
  }
}
