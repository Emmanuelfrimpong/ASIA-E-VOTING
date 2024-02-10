import 'package:frontend/config/routes/router_info.dart';
import 'package:frontend/features/auth/login/view/login.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: RouterInfo.rootRoute.path,
  routes: [
    GoRoute(
      path: RouterInfo.rootRoute.path,
      name: RouterInfo.rootRoute.name,
      builder: (context, state) => const LoginPage(),
    ),
    
   
  ]
);
