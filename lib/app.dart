import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/organisation//ui/page/login.dart';
import 'package:trust_app/organisation/data/repository/server_repository.dart';
import 'package:trust_app/organisation//ui/page/server.dart';
import 'package:trust_app/organisation/logic/cubit/server/connectivity/connectivity_status_cubit.dart';
import 'package:trust_app/organisation/ui/page/sign_up.dart';
import 'organisation/logic/cubit/server/context_menu/context_menu_cubit.dart';
import 'organisation/logic/cubit/server/context_server/context_server_cubit.dart';

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
                  String? protocol = route.uri.queryParameters['protocol'];

                  return NoTransitionPage(child: ServerPage(host: host, port: port, protocol: protocol as String,));
                }
          ),
            GoRoute(
                path: 'organisation/sign-up',
                name: 'organisation.signUp',
                pageBuilder: (context, route) {

                  return const NoTransitionPage(child: SignUpPage());
                }
          ),
          ]
      ),
    ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => ServerRepository())
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ConnectivityStatusCubit>(create: (context) => ConnectivityStatusCubit(
                serverRepository: context.read<ServerRepository>())
            ),
            BlocProvider<ContextServerCubit>(create: (context) => ContextServerCubit(
                serverRepository: context.read<ServerRepository>(),
                statusCubit: context.read<ConnectivityStatusCubit>())..getContextServer()
            ),
            BlocProvider(create: (context) => ServerContextMenuCubit(
              initial: [
                MenuItem(title: 'Nouveau (Http)', action: 'create http'),
                MenuItem(title: 'Nouveau (Https)', action: 'create https')
              ],
              serverRepository: context.read<ServerRepository>(),
              contextServer: context.read<ContextServerCubit>()),
            )
          ],
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
                snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating)
            ),
          ),
        )
    );
  }
}