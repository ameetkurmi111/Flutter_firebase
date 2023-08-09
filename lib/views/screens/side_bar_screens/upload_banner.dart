import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_web_admin/views/screens/side_bar_screens/widgets/banner_widgets.dart';

class UploadBanner extends StatefulWidget {
  static const String routeName = '\UploadBanner';

  @override
  State<UploadBanner> createState() => _UploadBannerState();
}

class _UploadBannerState extends State<UploadBanner> {

  final FirebaseStorage _storage =FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 dynamic _image;

 String? fileName ;
 
 PickImage()async{
   FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false,
   type: FileType.image,
   ); 
   if (result!=null){
    setState(() {
      _image =result.files.first.bytes;
      fileName = result.files.first.name;
    });
   }
  }

  _uploadBannersToStorage ( dynamic image) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);
    UploadTask uploadTask = ref.putData(image);
   TaskSnapshot snapshot = await uploadTask;
  String  downloadUrl   =await snapshot.ref.getDownloadURL();
  return downloadUrl;
   
  }

  _uploadToFirestore()async{
    EasyLoading.show();
    if(_image!=null){
     String imageUrl= await  _uploadBannersToStorage(_image);
     await  _firestore.collection('Banners').doc(fileName).set({
      'image' :imageUrl,
     }).whenComplete(() {
      EasyLoading.dismiss();
      setState(() {
        _image =null;
      });
     });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Banners',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
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
                      child:_image!=null ? Image.memory(_image, fit: BoxFit.cover,): Center(child: 
                      Text('Banners'),
                      ),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade900),
                      onPressed: (){
                         PickImage();
                      }, child: Text('Upload Image'))
                  ],
                ),
              ),
              SizedBox(width: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade900),
                onPressed: (){
                  _uploadToFirestore();
                }, 
                child: Text('Save',
              ),
              )
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
            child: Text('Banners',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
        ),
        BannerWidget(),
        ],
      ),
    );
  }
}
