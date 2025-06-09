import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kongossa/config/app_color.dart';
import 'package:kongossa/config/app_size.dart';
import 'package:kongossa/config/app_string.dart';
import 'package:kongossa/firebase_options.dart';
import 'package:kongossa/translation/app_translation.dart';
import 'package:kongossa/views/splash/splash_view.dart';

import 'controller/translation_controller.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initTranslation();
  runApp(const MyApp());
}

Future<void> initTranslation() async {
  await Get.putAsync(() async => AppTranslations());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TranslationController translationController =
        Get.put(TranslationController());
    return GetMaterialApp(
      title: AppString.primeSocialMedia,
      translations: AppTranslations(),
      locale: Locale(translationController.locale),
      fallbackLocale: const Locale(AppString.enText),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
        useMaterial3: true,
        splashColor: AppColor.transparentColor,
        highlightColor: AppColor.transparentColor,
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: AppSize.appSize0,
          backgroundColor: AppColor.backgroundColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashView(),
      defaultTransition: Transition.fade,
      getPages: AppRoutes.pages,
      builder: (context, child) {
        return Container(
          color: AppColor.backgroundColor,
          child: Center(
            child: Container(
              color: AppColor.backgroundColor,
              width: kIsWeb ? AppSize.appSize800 : null,
              child: child,
            ),
          ),
        );
      },
    );
  }
}



// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kongossa/config/app_size.dart';
// import 'package:kongossa/config/app_string.dart';
// import 'package:kongossa/firebase_options.dart';
// import 'package:kongossa/translation/app_translation.dart';
// import 'package:kongossa/views/splash/splash_view.dart';
// import 'controller/translation_controller.dart';
// import 'routes/app_routes.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await initTranslation();
//   runApp(const MyApp());
// }

// Future<void> initTranslation() async {
//   await Get.putAsync(() async => AppTranslations());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TranslationController translationController =
//         Get.put(TranslationController());
//     return GetMaterialApp(
//       title: AppString.primeSocialMedia,
//       translations: AppTranslations(),
//       locale: Locale(translationController.locale),
//       fallbackLocale: const Locale(AppString.enText),
//       theme: ThemeData(
//         useMaterial3: true,
//         // Désactive les couleurs Material par défaut
//         colorScheme: const ColorScheme.light(
//           primary: Colors.black,  // Couleur principale (noir)
//           secondary: Colors.grey, // Couleur secondaire (gris)
//           surface: Colors.white,  // Fond des widgets (blanc)
//           background: Colors.white, // Fond général (blanc)
//           onPrimary: Colors.white, // Texte sur fond noir (blanc)
//           onSecondary: Colors.black, // Texte sur fond gris (noir)
//           onSurface: Colors.black, // Texte principal (noir)
//           onBackground: Colors.black, // Texte sur fond blanc (noir)
//         ),
//         // Applique le noir et blanc partout
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: const AppBarTheme(
//           scrolledUnderElevation: AppSize.appSize0,
//           backgroundColor: Colors.white, // Fond de l'AppBar (blanc)
//           titleTextStyle: TextStyle(
//             color: Colors.black, // Texte de l'AppBar (noir)
//             fontWeight: FontWeight.bold,
//           ),
//           iconTheme: IconThemeData(color: Colors.black), // Icônes (noir)
//         ),
//         textTheme: const TextTheme(
//           bodyLarge: TextStyle(color: Colors.black), // Texte par défaut (noir)
//         ),
//         iconTheme: const IconThemeData(color: Colors.black), // Icônes (noir)
//         dividerColor: Colors.grey[300], // Séparateurs (gris clair)
//         splashColor: Colors.transparent,
//         highlightColor: Colors.transparent,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: SplashView(),
//       defaultTransition: Transition.fade,
//       getPages: AppRoutes.pages,
//       builder: (context, child) {
//         return Container(
//           color: Colors.white, // Fond général (blanc)
//           child: Center(
//             child: Container(
//               color: Colors.white,
//               width: kIsWeb ? AppSize.appSize800 : null,
//               child: child,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
