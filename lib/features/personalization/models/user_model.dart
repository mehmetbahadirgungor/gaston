import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gaston/utils/constants/enums.dart';
import '../../../utils/formatters/formatter.dart';
import 'address_model.dart';

/// Model class represents user data
class UserModel {

  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;
  List<AddressModel> addresses;
  UserType userType;
  bool isThereActiveOrder;

  /// Constructor for UserModel,
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.addresses,
    required this.userType,
    required this.isThereActiveOrder,
  });

  /// Helper functions to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper functions to get the phone number.
  String get formatPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model
  static UserModel empty() => UserModel(id: '', firstName: '', lastName: '', username: '', email: '', phoneNumber: '', profilePicture: '', addresses: [], userType: UserType.member, isThereActiveOrder: false);

  /// Convert model to JSON structure staring data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName' : firstName,
      'LastName' : lastName,
      'Username' : username,
      'Email' : email,
      'PhoneNumber' : phoneNumber,
      'ProfilePicture' : profilePicture,
      'Addresses': addresses.map((address) => address.toJson()).toList(),
      'UserType' : userType.toString(),
      'isThereActiveOrder' : isThereActiveOrder,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['UserName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        addresses: (data['Addresses'] as List<dynamic>?)?.map((address) => AddressModel.fromMap(address)).toList() ?? [],
        userType: UserType.values.firstWhere((e) => e.toString() == data['UserType']) ,
        isThereActiveOrder: data["isThereActiveOrder"] ?? false,
      );
    }else {
      return UserModel.empty();
    }
  }
}
