import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/planning/ui/page/dashboard.dart';
import 'package:trust_app/tax/ui/page/dashboard.dart';
import 'package:user_api/user_api.dart';

import 'accounting/ui/page/accounting.dart';
import 'asset_management/ui/page/dashboard.dart';
import 'employee/ui/page/dashboard.dart';
import 'home/ui/page/page.dart';
import 'logistic/ui/page/dashboard.dart';

final route = GoRouter(
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
                  int? port;

                  if (route.uri.queryParameters['port'] != null) {
                    port = int.tryParse(route.uri.queryParameters['port'] as String);
                  }

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

                  Map<String, dynamic> extra = route.extra as Map<String, dynamic>;
                  final OrganisationContextMenuCubit organisationContextMenuCubit =
                  extra['organisationContextMenuCubit'] as OrganisationContextMenuCubit;
                  ActiveOrganisationCubit activeOrganisation = extra['activeOrganisationCubit'] as ActiveOrganisationCubit;

                  return NoTransitionPage(
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: organisationContextMenuCubit,
                          ),
                          BlocProvider.value(
                            value: activeOrganisation,
                          )
                        ],
                        child: SignUpPage(protocol: protocol, host: host, port: port,),
                      )
                  );
                }
            ),
          ]
      ),
      GoRoute(path: '/organisation/create-admin-user',
          name: 'createAdmin',
          pageBuilder: (context, route) {
            Map<String, dynamic> extra = route.extra as Map<String, dynamic>;
            final Organisation organisation = extra['organisation'] as Organisation;
            final OrganisationContextMenuCubit organisationContextMenuCubit =
            extra['organisationContextMenuCubit'] as OrganisationContextMenuCubit;
            final ActiveOrganisationCubit activeOrganisation = extra['activeOrganisationCubit'] as ActiveOrganisationCubit;

            return NoTransitionPage(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: organisationContextMenuCubit,
                    ),
                    BlocProvider.value(
                      value: activeOrganisation,
                    )
                  ],
                  child: CreateUserAdminPage(organisation: organisation,),
                )
            );
          }
      ),
      GoRoute(path: '/start',
          name: 'start',
          pageBuilder: (context, route) {
            final Map<String, dynamic> extra = route.extra as Map<String, dynamic>;
            final User user = extra['user'] as User;
            final OrganisationContextMenuCubit organisationContextMenuCubit =
            extra['organisationContextMenuCubit'] as OrganisationContextMenuCubit;

            return NoTransitionPage(
                child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: organisationContextMenuCubit)
                    ],
                    child: HomePage(user: user,)
                )
            );
          }
      ),
      GoRoute(path: '/asset',
          name: 'asset',
          pageBuilder: (context, route) {
            final User user = route.extra as User;
            return NoTransitionPage(child: AssetDashboard(user: user,));
          }
      ),
      GoRoute(path: '/accounting',
          name: 'accounting',
          pageBuilder: (context, route) {
            final Map<String, dynamic> extra = route.extra as Map<String, dynamic>;
            final User user = extra['user'] as User;
            final OrganisationContextMenuCubit organisationContextMenuCubit =
            extra['organisationContextMenuCubit'] as OrganisationContextMenuCubit;

            return NoTransitionPage(child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: organisationContextMenuCubit)
                ],
                child: Accounting(user: user,)
            ));
          }
      ),
      GoRoute(path: '/employee',
          name: 'employee',
          pageBuilder: (context, route) {
            final User user = route.extra as User;
            return NoTransitionPage(child: EmployeeDashboard(user: user,));
          }
      ),
      GoRoute(path: '/logistic',
          name: 'logistic',
          pageBuilder: (context, route) {
            final User user = route.extra as User;
            return NoTransitionPage(child: LogisticDashboard(user: user,));
          }
      ),
      GoRoute(path: '/planning',
          name: 'planning',
          pageBuilder: (context, route) {
            final User user = route.extra as User;
            return NoTransitionPage(child: PlanningDashboard(user: user,));
          }
      ),
      GoRoute(path: '/tax',
          name: 'tax',
          pageBuilder: (context, route) {
            final User user = route.extra as User;
            return NoTransitionPage(child: TaxDashboard(user: user,));
          }
      )
    ]
);
