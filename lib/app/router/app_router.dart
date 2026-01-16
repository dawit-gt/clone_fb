import 'package:bluefeed/core/auth_gate.dart';
import 'package:bluefeed/main.dart';
import 'package:bluefeed/screens/login.dart';
import 'package:bluefeed/screens/profile.dart';
import 'package:bluefeed/screens/signup.dart';
import 'package:bluefeed/screens/explore.dart';
import 'package:bluefeed/screens/messages.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/auth_gate',
  routes: [
    GoRoute(
      path: '/auth_gate',
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const BlueFeedApp(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const Signup(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const Profile(),
    ),
    GoRoute(
      path: '/explore',
      builder: (context, state) => const Explore(),
    ),
    GoRoute(
      path: '/messages',
      builder: (context, state) => const Messages(),
    ),
  ],
);
