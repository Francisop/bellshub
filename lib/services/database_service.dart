import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  FirebaseStorage storage = FirebaseStorage.instance;

  getUserBySearch(String searchQuery) async {
    return await _firestore
        .collection('users')
        .where("search_index", arrayContains: searchQuery)
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

  updateUserInfo(userId, userMap) {
    try {
      return _firestore.collection('users').doc(userId).update(userMap);
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
    try {
      return _firestore
          .collection("ChatRoom")
          .where("users", arrayContains: userMatric)
          .snapshots();
    } catch (e) {
      print('getChatRooms error $e');
    }
  }

  getUnreadConversations(chatRoomId, myMatric) async {
    try {
      return _firestore
          .collection("ChatRoom")
          .doc(chatRoomId)
          .collection('chats')
          .where('read', isEqualTo: false)
          .where('sendby', isNotEqualTo: myMatric)
          .snapshots();
    } catch (e) {
      print(e);
    }
  }

  setReadConversation(chatRoomId, chatId) {
    return _firestore
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chat')
        .doc(chatId)
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

///////////////////////////////////////////
  ///GROUPS
//////////////////////////////////////////

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

  getLastGroupMessageSent(groupRoomId) {
    try {
      return _firestore
          .collection('users')
          .doc('q8gt6W4J7FOnihhE4bU7')
          .collection('groups')
          .doc(groupRoomId)
          .collection('chats')
          .orderBy('time', descending: true)
          .limit(1)
          .snapshots();
    } catch (e) {
      print('last message sent error $e');
    }
  }

  getUnreadGroupConversations(groupRoomId, myMatric) {
    try {
      return _firestore
          .collection('users')
          .doc('q8gt6W4J7FOnihhE4bU7')
          .collection('groups')
          .doc(groupRoomId)
          .collection('chats')
          .where('read', isEqualTo: false)
          .where('sendby', isNotEqualTo: myMatric)
          .snapshots();
    } catch (e) {
      print(e);
    }
  }

  createGroup(groupMap) {
    try {
      _firestore.collection('users').doc().collection('groups').add(groupMap);
    } catch (e) {
      print('uploaduserinfo exception $e');
    }
  }

  setGroupReadConversation(groupRoomId, groupChatid) {
    return _firestore
        .collection('users')
        .doc('q8gt6W4J7FOnihhE4bU7')
        .collection('groups')
        .doc(groupRoomId)
        .collection('chats')
        .doc(groupChatid)
        .update({'read': true});
  }

  //////////////////////////////////
  ///image upload

  uploadIdCard(File file) {
    try {
      Reference ref = storage.ref().child("image1" + DateTime.now().toString());
      UploadTask uploadTask =  ref.putFile(file);
      return uploadTask;
      // uploadTask.then((res) {
      //   print('hereeeeee');
      //   print(res.ref.getDownloadURL());
      //   return res.ref.getDownloadURL();
      // });
      // return storage.ref().child('imageFolder/').putFile(file).snapshot;

    } catch (e) {
      print('uploadIdCard Error $e');
    }
  }

  // updateIdCardUrl(id, downloadUrl) {
  //   try {
  //     return _firestore
  //         .collection('users')
  //         .doc(id)
  //         .update({'studentidimageurl': downloadUrl});
  //   } catch (e) {
  //     print('updateIdCardUrl error $e');
  //   }
  // }

  ///////////////////////////////////////////
  ///Qrcodes
//////////////////////////////////////////

  createQrcode(userId, qrcodeMap) {
    return _firestore
        .collection("users")
        .doc(userId)
        .collection('qrcode')
        .add(qrcodeMap)
        .catchError((e) {
      print("createQrcode error $e");
    });
  }

  getCreatedQrcode(userId) {
    try {
      return _firestore
          .collection("users")
          .doc(userId)
          .collection('qrcode')
          .where('type', isEqualTo: 'created')
          .snapshots();
    } catch (e) {
      print("getCreatedQrcode error $e");
    }
  }

  getReceivedQrcode(userId) {
    try {
      return _firestore
          .collection("users")
          .doc(userId)
          .collection('qrcode')
          .where('type', isEqualTo: 'received')
          .snapshots();
    } catch (e) {
      print("getCreatedQrcode error $e");
    }
  }

  checkScanned(userId, qrCode) {
    try {
      return _firestore
          .collection("users")
          .doc(userId)
          .collection('qrcode')
          .where('qrcode_code', isEqualTo: qrCode)
          .get();
    } catch (e) {
      print("getCreatedQrcode error $e");
    }
  }

  updateScanned(userId, qrcodeId) {
    try {
      return _firestore
          .collection("users")
          .doc(userId)
          .collection('qrcode')
          .doc(qrcodeId)
          .update({'scanned': true});
    } catch (e) {
      print("getCreatedQrcode error $e");
    }
  }
}
///////////////////////////////////////////////
