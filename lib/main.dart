import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memotask/Screens/Authentication/login/view_models/login_view_model.dart';
import 'package:memotask/Screens/Authentication/login/views/login_view.dart';
import 'package:memotask/Screens/Authentication/signup/view_models/signup_view_model.dart';
import 'package:memotask/Screens/Home/main_navigator.dart';
import 'package:memotask/Screens/Home/mcq_list/view_models/mcq_screen_view_model.dart';
import 'package:memotask/Utils/app_theme.dart';
import 'package:memotask/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => LoginViewModel()),
        ChangeNotifierProvider(
            create: (BuildContext context) => SignUpViewModel()),
        ChangeNotifierProvider(
            create: (BuildContext context) => MCQViewModel()),
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        theme: AppTheme.greenCustomLight,
        darkTheme: AppTheme.greenCustomDark,
        themeMode: ThemeMode.system,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return const MainNavigator();
            }
            return const LoginView();
          },
        ),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
