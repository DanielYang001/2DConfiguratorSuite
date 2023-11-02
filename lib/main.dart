// import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rt_10055_2D_configurator_suite/mockup_content/images_names_mapping.dart';
import 'package:rt_10055_2D_configurator_suite/stores/ConfigStore.dart';
import 'package:rt_10055_2D_configurator_suite/stores/HotspotsStore.dart';
import 'package:rt_10055_2D_configurator_suite/utils/router.dart';
import 'firebase_options.dart';
// import 'package:rt_10055_2D_configurator_suite/utils/agora_configs.dart'
//     as agora_config;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await RtcEngine.create(
  //   agora_config.appId,
  // );
  await Future.delayed(Duration(milliseconds: 500));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  Future initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ConfigStore(imagesMapping),
        child: ChangeNotifierProvider(
            create: (context) => HotspotsStore(70),
            child: MaterialApp.router(
              routerConfig: routerg,
              title: 'Flutter Demo',
              theme: ThemeData(
                // This is the theme of your application.
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
            )));
  }

  Widget scaffold(Widget page, BuildContext context) {
    bool isHomePage = (ModalRoute.of(context)?.settings.name == '/');
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   titleSpacing: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: page,
    );
  }
}
