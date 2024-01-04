import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:server_api/server_api.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
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
              SfGlobalLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('fr'),
            ],
            locale: const Locale('fr'),
            routerConfig: route,
            theme: ThemeData(
                useMaterial3: true,
                snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
                buttonTheme: const ButtonThemeData(
                  hoverColor: Colors.blue
                ),
                textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
                    overlayColor: MaterialStateProperty.resolveWith((states) => Colors.blue.withOpacity(0.2))
                  )
                ),
                inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    fillColor: Colors.blue.shade900.withOpacity(0.08),
                    focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue.shade900
                    )
                  )
                ),
                chipTheme: ChipThemeData(
                  selectedColor: Colors.blue.shade700.withOpacity(0.12)
                ),
                navigationRailTheme: const NavigationRailThemeData(
                  indicatorColor: Colors.blue,
                  selectedIconTheme: IconThemeData(
                    color: Colors.white
                  )
                ),
                fontFamily: 'Roboto',
                primaryColor: Colors.blue
            ),
          )
      ),
    );
  }
}