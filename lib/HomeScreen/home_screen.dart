import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_care/LoginScreen/login_screen.dart';

class PatientHomeScreen extends StatelessWidget {
  static String routeName = 'homeScreen';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xffD9D9D99),
      appBar: AppBar(
        title: Text(
          'TechCare',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Capriola',
            fontSize: 30,
          ),
        ),
          shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(70),
          ),
        ),
        backgroundColor: Color(0xff01595B),
        actions: <Widget>[
          //SizedBox(height: 10,),
          IconButton(
            icon: Image.asset(
              'assets/images/search.png',
              width: 30,
              height: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          //SizedBox(height: 10,),
          IconButton(
            icon: Image.asset(
              'assets/images/chat_bubble.png',
              width: 30,
              height: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
              'assets/images/profile.png',
              width: 30,
              height: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          ),

          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Container(
                      height: 300,
                      width: 500,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "assets/images/person.png",
                                  height: 30,
                                  width: 30,
                                ),
                                Container(
                                  width: 10,
                                ),
                                Text(
                                  "Dr/Loren",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff01595B),
                                    //height: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Image.asset("assets/person.png",
                                //   height: 30,
                                //   width: 30,),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Color(0xff666666),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "221 Baker street ,London",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff666666),
                                    //height: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Image.asset("assets/person.png",
                                //   height: 30,
                                //   width: 30,),
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Color(0xff666666),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "12th Feb 2024",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff666666),
                                    //height: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            // إضافة الخط هنا
                            color: Color(0xff666666),
                            thickness: 1, // يمكنك تعديل سماكة الخط حسب الحاجة
                            indent: 20, //
                            endIndent: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "summary about prescription , report,\nmedicine, medical analysis, x-ray,\netc....\n",
                                  style: TextStyle(
                                    color: Color(0xff01595B),
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            color: Color(0xff01595B),
                            height: 36,
                            minWidth: 173,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              "View details",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            }),
          ),

      
         // SizedBox(height: 10,),
          Stack(
            alignment: Alignment.center,
            children: [
              Container( height: 60,
                width: 400,
                color: Colors.white,
              ),
              Container(
                child: MaterialButton(
                  onPressed: () {},
                  color: Color(0xff023535),
                  height: 47,
                  minWidth: 280,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  //shape: const ShapeBorder(

                  //),
                  child: Text(
                    "Add new examination",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],

          )
        ],
      ),
    );
  }
}
