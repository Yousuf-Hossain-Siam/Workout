import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/bindings/controller_binder.dart';
import 'package:luna_3/core/utils/context/app_context.dart';
import 'package:luna_3/routes/app_routes.dart';

import 'core/utils/theme/theme.dart';

class Luna3 extends StatelessWidget {
  const Luna3({super.key});

  @override
  Widget build(BuildContext context) {
    AppContext.init(context);
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: ControllerBinder(),
          initialRoute: AppRoute.getSplashScreen(),
          getPages: AppRoute.routes,
          theme: AppTheme.lightTheme,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
