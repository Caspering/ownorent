import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ownorent/core/services/location_service.dart';
import 'package:ownorent/core/viewmodels/appointment_viewmodel.dart';
import 'package:ownorent/core/viewmodels/favorite_viewmodel.dart';
import 'package:ownorent/core/viewmodels/house_viewmodel.dart';
import 'package:ownorent/core/viewmodels/tailor_viewmodel.dart';
import 'package:ownorent/ui/shared/loader.dart';
import 'package:ownorent/ui/views/intro_view.dart';
import 'package:provider/provider.dart';

import 'core/services/authentication.dart';
import 'core/viewmodels/user_viewmodel.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

AuthenticationService _authenticationService = AuthenticationService();
UserViewmodel _userViewmodel = UserViewmodel();
LocationService _locationService = LocationService();
HouseViewmodel _houseViewmodel = HouseViewmodel();
FavoriteViewModel _favoriteViewModel = FavoriteViewModel();
AppointmentViewModel _appointmentViewModel = AppointmentViewModel();
TailorViewmodel _tailorViewmodel = TailorViewmodel();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return _authenticationService;
          }),
          ChangeNotifierProvider(create: (_) {
            return _tailorViewmodel;
          }),
          ChangeNotifierProvider(create: (_) {
            return _appointmentViewModel;
          }),
          ChangeNotifierProvider(create: (_) {
            return _favoriteViewModel;
          }),
          ChangeNotifierProvider(create: (_) {
            return _locationService;
          }),
          ChangeNotifierProvider(create: (_) {
            return _userViewmodel;
          }),
          ChangeNotifierProvider(create: (_) {
            return _houseViewmodel;
          })
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const IntroView(),
        ));
  }
}
