import 'package:accounting_api/accounting_api.dart';
import 'package:activity_api/activity_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:organization_api/organization_api.dart';
import 'package:trust_app/planning/ui/page/dashboard.dart';
import 'package:trust_app/tax/ui/page/dashboard.dart';
import 'package:user_api/user_api.dart';

import 'accounting/logic/cubit/activity/activity_cubit.dart';
import 'accounting/ui/page/accounting_page.dart';
import 'accounting/ui/view/activity/edit_product_view.dart';
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
                path: 'organization/sign-up',
                name: 'signUp',
                pageBuilder: (context, route) {
                  String? host = route.uri.queryParameters['host'];
                  int? port = int.tryParse(route.uri.queryParameters['port']!);
                  String? protocol = route.uri.queryParameters['protocol'];

                  Map<String, dynamic> extra = route.extra as Map<String, dynamic>;
                  final OrganizationContextMenuCubit organizationContextMenuCubit =
                  extra['organizationContextMenuCubit'] as OrganizationContextMenuCubit;
                  ActiveOrganizationCubit activeOrganization = extra['activeOrganizationCubit'] as ActiveOrganizationCubit;

                  return NoTransitionPage(
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: organizationContextMenuCubit,
                          ),
                          BlocProvider.value(
                            value: activeOrganization,
                          )
                        ],
                        child: SignUpPage(protocol: protocol, host: host, port: port,),
                      )
                  );
                }
            ),
          ]
      ),
      GoRoute(path: '/organization/create-admin-user',
          name: 'createAdmin',
          pageBuilder: (context, route) {
            Map<String, dynamic> extra = route.extra as Map<String, dynamic>;
            final Organization organization = extra['organization'] as Organization;
            final OrganizationContextMenuCubit organizationContextMenuCubit =
            extra['organizationContextMenuCubit'] as OrganizationContextMenuCubit;
            final ActiveOrganizationCubit activeOrganization = extra['activeOrganizationCubit'] as ActiveOrganizationCubit;

            return NoTransitionPage(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: organizationContextMenuCubit,
                    ),
                    BlocProvider.value(
                      value: activeOrganization,
                    )
                  ],
                  child: CreateUserAdminPage(organization: organization,),
                )
            );
          }
      ),
      GoRoute(path: '/app',
          name: 'start',
          pageBuilder: (context, route) {
            final Map<String, dynamic> extra = route.extra as Map<String, dynamic>;
            final User user = extra['user'] as User;
            final OrganizationContextMenuCubit organizationContextMenuCubit =
            extra['organizationContextMenuCubit'] as OrganizationContextMenuCubit;

            return NoTransitionPage(
                child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: organizationContextMenuCubit)
                    ],
                    child: HomePage(user: user,)
                )
            );
          },
          routes: [
            GoRoute(path: 'accounting',
              name: 'accounting',
              routes: [
                GoRoute(
                    path: 'product/edit',
                    name: 'productEdit',
                    pageBuilder: (context, route) {
                    final Map<String, dynamic> extra = route.extra as Map<String, dynamic>;
                    final User user = extra['user'] as User;
                    final ProductRepository productRepository = extra['productRepository'] as ProductRepository;
                    final AccountRepository accountRepository = extra['accountRepository'] as AccountRepository;
                    final EditingProductCubit editingProductCubit = extra['editingProductCubit'] as EditingProductCubit;
                    final ProductApiStatusCubit productApiStatusCubit = extra['productApiStatusCubit'] as ProductApiStatusCubit;
                    final CurrencyCubit currencyCubit = extra['currencyCubit'] as CurrencyCubit;
                    final ProductCategoryCubit productCategoryCubit = extra['productCategoryCubit'] as ProductCategoryCubit;
                    final ProductsCubit productsCubit = extra['productsCubit'] as ProductsCubit;
                    final ProductCategoryConfigCubit productCategoryConfigCubit = extra['productCategoryConfigCubit']
                    as ProductCategoryConfigCubit;
                    final ProductCategoryApiStatusCubit productCategoryApiStatusCubit = extra['productCategoryApiStatusCubit']
                    as ProductCategoryApiStatusCubit;
                    final OrganizationCurrencyCubit organizationCurrencyCubit = extra['organizationCurrencyCubit']
                    as OrganizationCurrencyCubit;
                    final ProductBottomNavigationCubit productBottomNavigationCubit = extra['productBottomNavigationCubit']
                    as ProductBottomNavigationCubit;

                      return NoTransitionPage(
                          child: EditProductView(
                            user: user,
                            repository: productRepository,
                            accountRepository: accountRepository,
                            editingProductCubit: editingProductCubit,
                            productApiStatusCubit: productApiStatusCubit,
                            currencyCubit: currencyCubit,
                            organizationCurrencyCubit: organizationCurrencyCubit,
                            productCategoryCubit: productCategoryCubit,
                            productsCubit: productsCubit,
                            productCategoryConfigCubit: productCategoryConfigCubit,
                            productCategoryApiStatusCubit: productCategoryApiStatusCubit,
                            productBottomNavigationCubit: productBottomNavigationCubit,
                          )
                      );
                  }
                )
              ],
              pageBuilder: (context, route) {
                final Map<String, dynamic> extra = route.extra as Map<String, dynamic>;
                final User user = extra['user'] as User;
                final OrganizationContextMenuCubit organizationContextMenuCubit =
                extra['organizationContextMenuCubit'] as OrganizationContextMenuCubit;
                final CurrencyCubit currencyCubit = extra['currencyCubit'] as CurrencyCubit;
                final OrganizationCurrencyCubit organizationCurrencyCubit =
                extra['organizationCurrencyCubit'] as OrganizationCurrencyCubit;

                return NoTransitionPage(child: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: organizationContextMenuCubit),
                      BlocProvider.value(value: organizationCurrencyCubit),
                      BlocProvider.value(value: currencyCubit),
                    ],
                    child: Accounting(user: user,)
                ));
              }
          ),
            GoRoute(path: 'asset',
                name: 'asset',
                pageBuilder: (context, route) {
                  final User user = route.extra as User;
                  return NoTransitionPage(child: AssetDashboard(user: user,));
                }
            ),
            GoRoute(path: 'employee',
                name: 'employee',
                pageBuilder: (context, route) {
                  final User user = route.extra as User;
                  return NoTransitionPage(child: EmployeeDashboard(user: user,));
                }
            ),
            GoRoute(path: 'logistic',
                name: 'logistic',
                pageBuilder: (context, route) {
                  final User user = route.extra as User;
                  return NoTransitionPage(child: LogisticDashboard(user: user,));
                }
            ),
            GoRoute(path: 'planning',
                name: 'planning',
                pageBuilder: (context, route) {
                  final User user = route.extra as User;
                  return NoTransitionPage(child: PlanningDashboard(user: user,));
                }
            ),
            GoRoute(path: 'tax',
                name: 'tax',
                pageBuilder: (context, route) {
                  final User user = route.extra as User;
                  return NoTransitionPage(child: TaxDashboard(user: user,));
                }
            )
          ]
      ),
    ]
);
