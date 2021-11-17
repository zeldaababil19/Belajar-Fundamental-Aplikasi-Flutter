import 'dart:async';
import 'package:flutter/material.dart';
import 'package:subs_pertama/main.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  void initState() {
    super.initState();
    splashScreen();
  }

  splashScreen() {
    var duration = const Duration(seconds: 3);

    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, ListPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF98bd8f),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/splash.png", width: 100),
            SizedBox(height: 24.0),
            Text(
              "RestaurantApp",
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}


// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   static const routeName = '/splash_screen';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: 100),
//             child: Image.network(
//               'https://i.pinimg.com/736x/10/ea/7e/10ea7e424f74b985f8d4d16d25760071.jpg',
//             ),
//           ),
//           Text(
//             "Best Restaurant",
//             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//           ),
//           RaisedButton(
//               color: Color(0xFF6B38FA),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()));
//               },
//               child: Text(
//                 "Next",
//                 style: TextStyle(color: Colors.white),
//               ))
//         ],
//       ),
//     );
//   }
// }
