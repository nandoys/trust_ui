import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/home//ui/page/page.dart';
import 'package:trust_app/home/data/repository/server_repository.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

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
                  int? port = route.uri.queryParameters['port'] as int?;
                  String? protocol = route.uri.queryParameters['protocol'];

                  return NoTransitionPage(child: ServerPage(host: host, port: port, protocol: protocol,));
                }
          ),
            GoRoute(
                path: 'organisation/sign-up',
                name: 'signUp',
                pageBuilder: (context, route) {
                  String? host = route.uri.queryParameters['host'];
                  int? port = int.tryParse(route.uri.queryParameters['port']!);
                  String? protocol = route.uri.queryParameters['protocol'];

                  return NoTransitionPage(child: SignUpPage(protocol: protocol, host: host, port: port,));
                }
          ),
          ]
      ),
      GoRoute(path: '/organisation/create-user-admin',
        name: 'createAdmin',
        pageBuilder: (context, route) {
          return const NoTransitionPage(child: CreateUserAdminPage());
        }
      )
    ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ServerRepository(),
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ConnectivityStatusCubit(
                    serverRepository: context.read<ServerRepository>()
                ),
            ),
            BlocProvider<ActiveServerCubit>(
              create: (context) => ActiveServerCubit(
                  serverRepository: context.read<ServerRepository>(),
                  statusCubit: context.read<ConnectivityStatusCubit>()
              )..get(),
            ),
            BlocProvider(
              create: (context) => ServerContextMenuCubit(
                  initial: [
                    MenuItem(title: 'Nouveau (Http)', action: 'create http'),
                    MenuItem(title: 'Nouveau (Https)', action: 'create https')
                  ],
                  serverRepository: context.read<ServerRepository>(),
                  activeServer: context.read<ActiveServerCubit>()
              ),
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
          )
      ),
    );
  }
}