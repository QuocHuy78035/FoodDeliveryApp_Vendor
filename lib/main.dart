import 'package:ddnangcao_project/api_services.dart';
import 'package:ddnangcao_project/providers/add_food_provider.dart';
import 'package:ddnangcao_project/providers/category_provider.dart';
import 'package:ddnangcao_project/providers/menu_provider.dart';
import 'package:ddnangcao_project/providers/order_provider.dart';
import 'package:ddnangcao_project/providers/restaurant_provider.dart';
import 'package:ddnangcao_project/providers/statistic_provider.dart';
import 'package:ddnangcao_project/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/views/merchant_auth/login_screen.dart';
import 'features/main/views/navbar_custom.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => OrderProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CategoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AddFoodProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => RestaurantProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => MenuProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => StatisticProvider(),
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
  String accessToken = '';

  getUserData() async{
    final ApiServiceImpl apiServiceImpl = ApiServiceImpl();
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await apiServiceImpl.getNewToken();
    setState(() {
      accessToken = sharedPreferences.getString("accessToken") ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NWViZjk1MGJlNzBmOGQ2MzQxMzZjNmYiLCJlbWFpbCI6ImJ1aWR1Y2xvbmc5MTFAZ21haWwuY29tIiwicm9sZSI6InZlbmRvciIsImlhdCI6MTcxNTA2MjI4OCwiZXhwIjoxNzIyMjYyMjg4fQ.idt7mDNIPnEzPmE1gWAsGOn2Cx4-vVxXh2TgQ5_rINI";
    });
  }

  @override
  void initState(){
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(accessToken);
    return accessToken != '' ? MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
        home: JwtDecoder.isExpired(accessToken) == false  ? const CustomerHomeScreen() : const LoginScreen() ,
      //home: RegisterStoreScreen(email: '',),
    ) : MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Waiting"),
        ),
      ),
    );
  }
}


