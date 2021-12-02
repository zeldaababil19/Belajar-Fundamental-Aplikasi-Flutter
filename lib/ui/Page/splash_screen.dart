part of 'page.dart';

class SplashScreenPage extends StatelessWidget {
  static const routeName = '/splashScreen';

  @override
  Widget build(BuildContext context) {
    return SplashScreen.timer(
      seconds: 4,
      navigateAfterSeconds: MainScreen.routeName,
      title: Text(
        "Restaurant App",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.asset("assets/splash.png"),
      loadingTextPadding: EdgeInsets.all(0),
      loadingText: Text(""),
      photoSize: 100.0,
      backgroundColor: Color(0xFF98bd8f),
      styleTextUnderTheLoader: TextStyle(),
      loaderColor: Colors.green,
    );
  }
}
