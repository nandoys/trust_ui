import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:trust_app/organisation//ui/page/login.dart';

import 'package:trust_app/organisation//bloc/server/server_bloc.dart';
import 'package:trust_app/organisation//ui/page/server.dart';

final _route = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          name: 'login',
          pageBuilder: (context, route) {
            return const NoTransitionPage(child: LoginPage());
          },
          routes: [
            GoRoute(
                path: 'server',
                name: 'server',
                pageBuilder: (context, route) {
                  String? host = route.uri.queryParameters['host'];
                  String? port = route.uri.queryParameters['port'];

                  return NoTransitionPage(child: ServerPage(host: host, port: port,));
                }
          )
          ]
      ),
    ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServerBloc>(
        create: (context) => ServerBloc()..add(const AppStartedEvent()),
        child: MaterialApp.router(
          title: 'Trust Compta',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fr'),
          ],
          routerConfig: _route,
          theme: ThemeData(
            useMaterial3: true,
          ),
        ),
    );
  }

}