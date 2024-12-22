
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gaston/utils/constants/enums.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/order_model.dart';
import '../authentication/authentication_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /* ------------------  FUNCTIONS ------------------*/
  
  Stream<List<OrderModel>> fetchProcessingOrderAsStream() {
  try {
    final userId = AuthenticationRepository.instance.authUser.uid;
    if (userId.isEmpty) throw 'Unable to find user information. Try again in minutes.';

    final result = _db.collectionGroup('Orders').where('isActive', isEqualTo: true).where('staffId', isEqualTo: userId).snapshots();

    // Listening Stream from Firestore
    return result.map((querySnapshot) =>
            querySnapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
  } catch (e) {
    print("Hata: $e");
    throw 'Something went wrong while fetching Order Information. Try again later';
  }
}
    
  Stream<List<OrderModel>> fetchPendingOrderAsStream() {
  try {
    final userId = AuthenticationRepository.instance.authUser.uid;
    if (userId.isEmpty) throw 'Unable to find user information. Try again in minutes.';


    final result = _db.collection('Users').doc(userId).collection('Orders').where('isActive', isEqualTo: true).snapshots();

    // Listening Stream from Firestore
    return result.map((querySnapshot) =>
            querySnapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
  } catch (e) {
    print("Hata: $e");
    throw 'Something went wrong while fetching Order Information. Try again later';
  }
}
  
  /// Get all order related to all Users
  Future<List<OrderModel>> fetchPendingOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) throw 'Unable to find user information. Try again in minutes.';

      final result = await _db.collection('Users').doc(userId).collection('Orders').where('isActive', isEqualTo: true).get();

      print("Datamız: $result");

      return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();
    } catch (e) {
      print("Hata bumu: $e");
      throw 'Something went wrong while fetching Order Information. Try again later';
    }
  }


  /// Get all order related to all Users
  Future<List<OrderModel>> fetchUsersOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) throw 'Unable to find user information. Try again in minutes.';

      final result = await _db.collectionGroup('Orders').where('status', isEqualTo: OrderStatus.pending.toString()).where('userId', isNotEqualTo: userId).get();

      print("Datamız: $result");

      return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();
    } catch (e) {
      print("Hata bumu: $e");
      throw 'Something went wrong while fetching Order Information. Try again later';
    }
  }

  /// Get all order related to current User
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) throw 'Unable to find user information. Try again in minutes.';

      final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();
    } catch (e) {
      print(e);
      throw 'Something went wrong while fetching Order Information. Try again later';
    }
  }

  /// Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving Order Information. Try again later';
    }
  }

  /// Update user order
  Future<void> updateOrder(OrderModel order, String userId) async {
    try {
      final result = await _db.collection('Users').doc(userId).collection('Orders').where('id', isEqualTo: order.id).get();
      await result.docs[0].reference.update(order.toJson());
    } catch (e) {
      throw 'Something went wrong while updating Order Information. Try again later';
    }
  }
}