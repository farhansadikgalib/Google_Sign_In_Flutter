import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_firebase/Push%20Notification/pushNotification.dart';
import 'package:first_firebase/provider/google_sign_in.dart';
import 'package:first_firebase/widget/logged_in_widget.dart';
import 'package:first_firebase/widget/sign_up_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {





  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseNotifcation? firebase;
  handleAsync() async {
    await firebase!.initialize();
    String? token = await firebase!.getToken();
    print("Firebase token : $token");
  }

  @override
  void initState() {
    super.initState();
    firebase = FirebaseNotifcation();
    handleAsync();
  }


  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);

              if (provider.isSigningIn) {
                return buildLoading();
              } else if (snapshot.hasData) {
                return LoggedInWidget();
              } else {
                return SignUpWidget();
              }
            },
          ),
        ),
      );

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      );


}
