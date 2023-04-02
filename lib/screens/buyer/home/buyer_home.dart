import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoping_app/screens/buyer/detail/detail_screen.dart';

import '../../../utilties/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BuyerHome extends StatefulWidget {
  const BuyerHome({Key? key}) : super(key: key);

  @override
  State<BuyerHome> createState() => _BuyerHomeState();
}

class _BuyerHomeState extends State<BuyerHome> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(' Hi , Addam', style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600


              ),),
              SizedBox(height: 20,),

              Text('Welcome Back', style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600


              ),),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search Here',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  suffixIcon: CircleAvatar(
                    radius: 27,
                    backgroundColor: KprimaryColor,



                  )
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'New Items',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
          StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return Expanded(
                child: AlignedGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data=snapshot.data!.docs[index];

                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>ProductDetail(productId: data.id)


                        ));


                      },
                      child: Column(
                        children: [
                          Container(
                            height: 160,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      data['image']

                                        )),
                                color: ksecondaryColor,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          SizedBox(
                            height: 10,

                          ),

                           Text(
                      data['title']

                            ,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5,

                          ),
                          // $$ first $ for dolar and second for integer value
                           Text(
                            '\$${data['price']}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey
                            ),
                          ),





                        ],
                      ),
                    );
                  },
                ),
              );
            },
          )




            ],
          ),
        ),
      ),
    );
  }
}
