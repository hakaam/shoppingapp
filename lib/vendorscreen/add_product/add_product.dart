import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoping_app/utilties/colors.dart';
import 'package:get_storage/get_storage.dart';

import '../../main.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  XFile? singleImage;
  pickImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  final _formKey = GlobalKey<FormState>();

  var title = TextEditingController();
  var disc = TextEditingController();
  var price = TextEditingController();

  String getImageName(XFile image) {
    return image.path.split('/').last;
  }

  saveToDb() async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    Reference db =
        FirebaseStorage.instance.ref("Image/${getImageName(singleImage!)}");

    await db.putFile(File(singleImage!.path));
    return await db.getDownloadURL().then((value) {
      return products
          .add({
            'image':value,
            'title': title.text,
            'description': disc.text,
            'price': price.text,
            'vendorid':box.read('uid'),

          })
          .whenComplete(() {
            EasyLoading.showSuccess('Save SuccessFully');
          })
          .then((value) => print("User Added"))
          .catchError((error) {
            EasyLoading.showError('Failed to add product]: $error');
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhiteColor,
        centerTitle: true,
        elevation: 1,
        title: Text(
          'Add Product',
          style: TextStyle(
            color: KprimaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      singleImage = await pickImage();
                      if (singleImage != null && singleImage!.path.isNotEmpty) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: KprimaryColor)),
                      child: Center(
                        child: singleImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  File(singleImage!.path),
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Add Image',
                                    style: TextStyle(color: KprimaryColor),
                                  )
                                ],
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: KprimaryColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            color: KprimaryColor,
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: KprimaryColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: disc,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Desc',
                          labelStyle: TextStyle(
                            color: KprimaryColor,
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: KprimaryColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: price,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Price',
                          labelStyle: TextStyle(
                            color: KprimaryColor,
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    color: KprimaryColor,
                    height: 50,
                    minWidth: double.maxFinite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (singleImage != null &&
                            singleImage!.path.isNotEmpty) {
                          EasyLoading.show();

                          setState(() {});
                        }
                        saveToDb();
                      } else {
                        EasyLoading.showToast("Please select Image");


                      }
                    },
                    child: Text(
                      'Save Products',
                      style: TextStyle(color: kwhiteColor, fontSize: 16),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
