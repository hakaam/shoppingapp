import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utilties/colors.dart';
class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.productId}) : super(key: key);

  final String productId;


  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  CollectionReference productDetail = FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kwhiteColor,
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(color: KprimaryColor),
          title: Text(
            'Product Detail',
            style: TextStyle(
              color: KprimaryColor,
            ),
          ),
        ),
      body: FutureBuilder<DocumentSnapshot>(
        future: productDetail.doc(widget.productId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(data['image'], height: 250,width: double.maxFinite,
                    fit: BoxFit.cover,),
                    SizedBox(height: 15,),
                    Text(data['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600


                      ),

                    ),
                    SizedBox(height: 15,),
                    Text('Description',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600


                      ),

                    ),
                    SizedBox(height: 15,),
                    Text(data['description'],
                      style: TextStyle(
                          fontSize: 18,


                      ),

                    ),
                    SizedBox(height: 100,),

                    MaterialButton(
                      color: KprimaryColor,
                      height: 50,
                      minWidth: double.maxFinite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {

                      },
                      child: Text(
                        'Buy Now',
                        style: TextStyle(color: kwhiteColor, fontSize: 16),
                      ),
                    ),




                  ],


                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(


            ),
          );
        },
      )


    );
  }
}
