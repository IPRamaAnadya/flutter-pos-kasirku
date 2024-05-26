import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pos/presentations/commons/styles/color.dart';
import 'package:pos/presentations/commons/styles/images.dart';
import 'package:pos/presentations/commons/styles/text.dart';
import 'package:pos/presentations/features/authentication/login_provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late LoginProvider _loginProvider;

  @override
  void initState() {
    _loginProvider = LoginProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColor.primary700,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Container(
                    color: Colors.white,
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Masuk ke",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                ),
                                Text("Kasirku",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 32,
                                    color: AppColor.primary700
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0,5),
                          child: Image.asset(AppImages.login),
                        )
                      ],
                    ),
                  )
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: ()async{
                        await _loginProvider.signInWithGoogle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.google, width: 24, height: 24,),
                          SizedBox(width: 10,),
                          Text("Login dengan Google")
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);

    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(
      firstControlPoint.dx, firstControlPoint.dy,
      firstEndPoint.dx, firstEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}