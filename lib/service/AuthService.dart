import 'dart:ffi';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_face_api/flutter_face_api.dart' as regula;
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Query Firestore for a document with matching email
      QuerySnapshot query =
          await students.where('Email', isEqualTo: email).get();

      if (query.docs.isEmpty) {
        return {'isAuth': false, 'name': ''};
      }

      // Assuming email is unique, take the first matching document
      DocumentSnapshot doc = query.docs.first;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Check if password matches
      if (data['Password'] == password) {
        return {
          'isAuth': true,
          'name': data['FirstName'] + ' ' + data['LastName'],
          'level': data['Level'],
          'class': data['Class']
        };
      }
    } catch (e) {
      print('Error during login: $e');
      return {'isAuth': false, 'name': ''};
    }

    return {'isAuth': false, 'name': ''};
  }

  var faceSdk = regula.FaceSDK.instance;

  Future<Map<String, dynamic>> compareFaces(
      String email, XFile loginImage) async {
    // Query Firestore for a document with matching email
    QuerySnapshot query = await students.where('Email', isEqualTo: email).get();

    if (query.docs.isEmpty) {
      return {'isAuth': false, 'name': ''};
    }

    // Assuming email is unique, take the first matching document
    DocumentSnapshot doc = query.docs.first;
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // final storedImageBytes = (await rootBundle.load('assets/images/my_face.jpg')).buffer.asUint8List();
    final storedImageBytes = base64Decode(data['auth_photo']);

    // assets/images/my_face.jpg
    final capturedImageBytes = await loginImage.readAsBytes();

    // final storedImageBase64 = base64Encode(storedImageBytes);
    // final capturedImageBase64 = base64Encode(capturedImageBytes);

    // Create MatchFacesImage objects
    final firstImage =
        regula.MatchFacesImage(storedImageBytes, regula.ImageType.PRINTED);
    final secondImage =
        regula.MatchFacesImage(capturedImageBytes, regula.ImageType.PRINTED);
    // final secondImage = regula.MatchFacesImage()
    //   ..imageType = regula.ImageType.LIVE
    //   ..bitmap = capturedImageBase64;

    // Create MatchFacesRequest
    final request = regula.MatchFacesRequest([firstImage, secondImage]);

    try {
      // Perform face comparison
      final response = await faceSdk.matchFaces(request);

      final split = await faceSdk.splitComparedFaces(response.results, 0.75);

      // Check similarity
      final similarity = split!.matchedFaces.isNotEmpty
          ? split.matchedFaces[0]!.similarity! * 100
          : 0.0;

      // Show result
      if (similarity > 75) {
        print('Faces match! Similarity: ${similarity.toStringAsFixed(2)}%');
        return {
          'isAuth': true,
          'name': data['FirstName'] + ' ' + data['LastName']
        };
      } else {
        print(
            'Faces do not match. Similarity: ${similarity.toStringAsFixed(2)}%');
        return {'isAuth': false, 'name': ''};
      }
    } catch (e) {
      print("ex {e}");
      return {'isAuth': false, 'name': ''};
    }
  }
}
