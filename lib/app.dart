import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:server_api/server_api.dart';
import 'route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                  repository: context.read<ServerRepository>(),
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
            routerConfig: route,
            theme: ThemeData(
                useMaterial3: true,
                snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
                fontFamily: 'Roboto',
                primaryColor: Colors.blue
            ),
          )
      ),
    );
  }
}