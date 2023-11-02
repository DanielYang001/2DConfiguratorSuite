import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/pages/demo_page.dart';
import 'package:rt_10055_2D_configurator_suite/pages/home_page.dart';
import 'package:rt_10055_2D_configurator_suite/pages/hotspots_page.dart';
import 'package:rt_10055_2D_configurator_suite/pages/login_page.dart';
import 'package:rt_10055_2D_configurator_suite/pages/signup_page.dart';
import 'package:rt_10055_2D_configurator_suite/pages/try_widget.dart';
import 'package:rt_10055_2D_configurator_suite/pages/try_widget_dst.dart';
import 'package:rt_10055_2D_configurator_suite/pages/video_call_page.dart';

final routerg = GoRouter(
  routes: [
    GoRoute(
      path: '/demo',
      builder: (context, state) => ProviderScope(
        child: HomePage(
          queryParamConfig: queryParamToMap(state.queryParametersAll),
        ),
      ),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => ProviderScope(
        child: DemoPage(
          queryParamConfig: queryParamToMap(state.queryParametersAll),
        ),
      ),
    ),
    GoRoute(
      path: '/hotspots',
      builder: (context, state) => ProviderScope(
        child: HotspotsPage(
          queryParamConfig: queryParamToMap(state.queryParametersAll),
        ),
      ),
    ),
    GoRoute(
      path: LoginPage.name,
      builder: (context, state) => const ProviderScope(child: LoginPage()),
    ),
    GoRoute(
      path: TrySelectionBlockWidget.routeName,
      builder: (context, state) =>
          const ProviderScope(child: TrySelectionBlockWidget()),
    ),
    // GoRoute(
    //   path: VideoCallPage.name,
    //   builder: (context, state) => const ProviderScope(child: VideoCallPage()),
    // ),
    GoRoute(
      path: SignupPage.name,
      builder: (context, state) => const ProviderScope(child: SignupPage()),
    ),
    GoRoute(path: TryWidget.name, builder: (context, state) => TryWidget()),
    GoRoute(
      path: '/inviteUser',
      builder: (context, state) => Container(),
    ),
  ],
);

Map<String, int>? queryParamToMap(
    Map<String, List<String>>? queryParametersAll) {
  if (queryParametersAll == null) return null;

  Map<String, int> queryParamConfig = {};
  queryParametersAll.forEach((key, value) {
    queryParamConfig[key] = int.parse(value[0]);
  });
  return queryParamConfig;
}
