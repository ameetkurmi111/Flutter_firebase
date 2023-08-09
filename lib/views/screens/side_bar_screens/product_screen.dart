// import 'package:flutter/material.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_web_admin/views/screens/side_bar_screens/widgets/product_widget.dart';

// class ProductScreen extends StatefulWidget {
//   static const String routeName = '\ProductScreen';

//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   dynamic _image;

//   String? fileName;
// //  String? categoryName;
//   String? productName;
//   late double price;
//   late int quantity;

//   _pickImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: false,
//       type: FileType.image,
//     );
//     if (result != null) {
//       setState(() {
//         _image = result.files.first.bytes;
//         fileName = result.files.first.name;
//       });
//     }
//   }

//   _uploadProductBannerToStorage(dynamic image) async {
//     Reference ref = _storage.ref().child('ProductImages').child(fileName!);

//     UploadTask uploadTask = ref.putData(image);
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
//   uploadProducts()async{
//   if(_formKey.currentState!.validate()) {
//     String imageUrl =await _uploadProductBannerToStorage(_image);
//     await _firestore.collection('products').doc(fileName).set({
//       'image' : imageUrl,
//       'productName' :productName,
//       'price': price,
//        'quantity':quantity
//     });
//   }else {
//     print('OH Bad Guy');
//   }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             Container(
//               alignment: Alignment.topLeft,
//               child: Text(
//                 'Products',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 36,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Divider(
//                 color: Colors.grey,
//               ),
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 140,
//                         width: 140,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade500,
//                           border: Border.all(color: Colors.grey.shade800),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: _image != null
//                             ? Image.memory(
//                                 _image,
//                                 fit: BoxFit.cover,
//                               )
//                             : Center(
//                                 child: Text('Product'),
//                               ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.yellow.shade900),
//                           onPressed: () {
//                             _pickImage();
//                           },
//                           child: Text('Upload Image'))
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Flexible(
//                       child: SizedBox(
//                         width: 170,
//                         child:
//                         TextFormField(
//                           onChanged: (value) {
//                             productName = value;
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please product Name must not be empty';
//                             } else {
//                               return null;
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Enter Product Name',
//                             hintText: 'Enter Product Name',
//                           ),
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       child: SizedBox(
//                         width: 170,
//                         child: TextFormField(
//                           onChanged: (value) {
//                             price = value as double;
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please price  must not be empty';
//                             } else {
//                               return null;
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Enter Price',
//                             hintText: 'Enter Price',
//                           ),
//                         ),
//                       ),
//                     ),
//                      Flexible(
//                       child: SizedBox(
//                         width: 170,
//                         child: TextFormField(
//                           onChanged: (value) {
//                             quantity = value as int;
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please quantity must not be empty';
//                             } else {
//                               return null;
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Enter quantity',
//                             hintText: 'Enter quantity',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.yellow.shade900),
//                   onPressed: () {
//                    uploadProducts();
//                   },
//                   child: Text(
//                     'Save',
//                   ),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Divider(
//                 color: Colors.grey,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Products',
//                   style: TextStyle(fontWeight: FontWeight.w800, fontSize: 36),
//                 ),
//               ),
//             ),
//             ProductWidget(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_web_admin/views/screens/side_bar_screens/widgets/product_widget.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  static const String routeName = '\ProductScreen';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; 

   dynamic _image;

  String? fileName;
  late String categoryName;
  late String productName;
  late String price;
  // late String quantity;

  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  _uploadProductBannerToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('ProductImages').child(fileName!);

    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
  uploadProducts()async{
  if(_formKey.currentState!.validate()) {
    String imageUrl =await _uploadProductBannerToStorage(_image);
    await _firestore.collection('products').doc(fileName).set({
      'image' : imageUrl,
      'productName' :productName,
      'price': price,
      'categoryName': categoryName,
      // 'quantity':quantity
    }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _image = null;
          _formKey.currentState!.reset();
        });
      });
    } else {
      print('OH Bay Guy');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: Column(
        children: [
           Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Products',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            border: Border.all(color: Colors.grey.shade800),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _image!=null ? Image.memory(_image, fit: BoxFit.cover,):
                           Center( 
                            child: Text('Product'),
                                ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow.shade900),
                            onPressed: () {
                              _pickImage();
                            },
                            child: Text('Upload Image'))
                      ],
                    ),
                  ),
               
                  Flexible(
                    child: SizedBox(
                      width: 170,
                      child: TextFormField(
                        onChanged: (value){
                          productName =value;
                        },
                        validator: (value) {
                          if(value!.isEmpty ){
                            return 'Please Product Name must not be empty' ;
                          }else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter Product Name',
                          hintText: 'Enter Product Name',
                        ),
                        
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                   Flexible(
                child: SizedBox(
                  width: 170,
                  child: TextFormField(
                    onChanged: (value) {
                      price = value ;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Price must not be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter price',
                      hintText: 'Enter price',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
                
              ),
               Flexible(
                child: SizedBox(
                  width: 170,
                  child: TextFormField(
                    onChanged: (value) {
                      categoryName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Category Name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Category name',
                      hintText: 'Enter Category name',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
            
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade900),
                    onPressed: () {
                     uploadProducts() ;
                    },
                    child: Text(
                      'Save',
                    ),
                  ),
                ],
              ),
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(color: Colors.grey,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text('Products',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 36),),
                ),
              ),
              ProductWidget(),
            ],
            
      
        ),
    );
      }
      }