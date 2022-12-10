import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/common/app/app_snack_bar.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<UserCredential?> signUpUser(
      BuildContext context, String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        AppSnackBar.showSnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        AppSnackBar.showSnackBar(context, 'The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
      AppSnackBar.showSnackBar(context, e.toString());
    }
    return null;
  }

  static Future<UserCredential?> signInUser(
      BuildContext context, String emailAddress, String password) async {
    try {
      debugPrint('emailAddress $emailAddress');
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      debugPrint('No credential $credential');
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        AppSnackBar.showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        AppSnackBar.showSnackBar(context, 'Wrong password provided for that user.');
      }
    } catch (e) {
      debugPrint(e.toString());
      AppSnackBar.showSnackBar(context, e.toString());
    }
    return null;
  }

  static Future<void> signOutUser() async{
    await FirebaseAuth.instance.signOut();
  }

  static Future<String?> uploadImage(File file,String fileName) async {
    try{
      final storageRef = FirebaseStorage.instance.ref();
      String fName = fileName + DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storageRef.child("recipe_images/$fName");
      UploadTask uploadTask = ref.putFile(file);
      var downloadUrl = await (await uploadTask).ref.getDownloadURL();
      String url = downloadUrl.toString();
      return url;
    }catch(e){
      print('error while uploading file $e');
      return null;
    }
  }

  static Future<void> addRecipe(RecipeModel recipeModel) async {
    try {
      CollectionReference recipes =
          FirebaseFirestore.instance.collection('recipes');
      await recipes.add(recipeModel.toJson());
    } catch (e) {
      print('failed to add recipe $e');
    }
  }

  static Future<List<RecipeModel>> getRecipes() async {
    CollectionReference recipes =
        FirebaseFirestore.instance.collection('recipes');
    List<RecipeModel> recipeList = [];
    try{
      QuerySnapshot querySnapshot = await recipes.get();
      for (var element in querySnapshot.docs) {
        final Map<String, dynamic> map = element.data() as Map<String, dynamic>;
        print('map -> $map');
        RecipeModel recipe = RecipeModel.fromJson(map);
        recipeList.add(recipe);
        print('recipeList length -> ${recipeList.length}');
      }
    }catch(e){
      print('failed to get recipes $e');
    }
    return recipeList;
  }
}
