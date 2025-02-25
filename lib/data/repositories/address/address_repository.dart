import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../authentication/authentication_repository.dart';
import '../../../features/personalization/models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository  get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      if(userId.isEmpty) throw 'Unable to find user information. Try again in few minutes.';

      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      return result.docs.map((documentSnapshot) => AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();

    } catch (e) {
      throw 'Something went wrong while fetching Address information. Try again later';
    }
  }

  /// Clear the "selected" field for all addresses
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try{
      final userId = AuthenticationRepository.instance.authUser.uid;
      final result = await _db.collectionGroup('Adresses').where('id', isEqualTo: addressId).get();
      await result.docs[0].reference.update({'SelectedAddress': selected});
      // await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress': selected});
    } catch (e) {
      // TODO: throw 'Unable to update your address selection. Try again later';
    }
  }

  /// Store new user address
  Future<String> addAddress(AddressModel address) async {
    try{
      final userId = AuthenticationRepository.instance.authUser.uid;
      final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong wile saving Address Information. Try again later';
    }
  }

  Future<void> updateAddress(AddressModel address) async {
    try{
      final userId = AuthenticationRepository.instance.authUser.uid;
      await _db.collection('Users').doc(userId).collection('Addresses').doc(address.id).update(address.toJson());
    } catch (e) {
      throw 'Something went wrong wile saving Address Information. Try again later';
    }
  }
}