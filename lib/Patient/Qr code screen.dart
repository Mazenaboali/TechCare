import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class QrCodeScreen extends StatefulWidget {
  var user=FirebaseAuth.instance.currentUser;
  static String routeName="QrCodeScreen";
  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xffD9D9D99),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                        child: Icon(Icons.arrow_back,
                        )),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Text('Scan the QR code to connect to patient’s medical file',
                        style: TextStyle(
                          fontFamily: 'Capriola',
                            fontSize: 25,
                            color: Color(0xff01595B)
                        ),),
                    ),
                  ),
                  Divider(
                    color: Color(0xff666666),
                    thickness: 1, //
                    indent: 18, //
                    endIndent: 18,
                  ),
                  SizedBox(height: 70,),
                  Center(
                    child: QrImageView(data: widget.user?.email??"",
                      version: QrVersions.auto,
                      size: 300,),
                  ),
                ]
            ),
          ),
        )
    );
  }
}