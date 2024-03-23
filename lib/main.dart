import 'package:ddnangcao_project/features/auth/controllers/auth_controller.dart';
import 'package:ddnangcao_project/features/auth/views/store_auth/register_store_screen.dart';
import 'package:ddnangcao_project/providers/order_provider.dart';
import 'package:ddnangcao_project/providers/user_provider.dart';
import 'package:ddnangcao_project/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/views/merchant_auth/forgot_pass_screen.dart';
import 'features/auth/views/merchant_auth/splash_screen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrderProvider(),
          ),
        ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AuthController authController = AuthController();

  @override
  void initState(){
    super.initState();
    authController.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: Provider.of<UserProvider>(context).user.accessToken != ""  ? CustomerHomeScreen() : LoginScreen(),
      home: MyHomePage(),
    );
  }
}


