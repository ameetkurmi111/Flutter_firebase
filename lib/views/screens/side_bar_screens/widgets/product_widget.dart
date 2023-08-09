import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ProductStream =
        FirebaseFirestore.instance.collection('products').snapshots();
     final Stream<QuerySnapshot> _categoriesStream =
        FirebaseFirestore.instance.collection('Categories').snapshots();
   
    final combinedStream =
        StreamGroup.merge([_ProductStream, _categoriesStream]). asBroadcastStream;

    return StreamBuilder<QuerySnapshot>(
      stream: combinedStream.call().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        return GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.size,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
          ),
          itemBuilder: (context, index) {
            final productData = snapshot.data!.docs[index];
            return Card(
              elevation: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(productData['image']),
                    ),
                  ),
                  Column(
                    children: [
                      Text(productData['productName']),
                      SizedBox(height: 10,),
                      Text(productData['price']),
                      //  Text(productData['quantity']),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(productData['categoryName']),
            
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 6, // Number of shimmer placeholders
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ClipRect(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.white,
                ),
                Container(
                  height: 16,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
