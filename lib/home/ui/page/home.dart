import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:organization_api/organization_api.dart';
import 'package:server_api/server_api.dart';
import 'package:user_api/user_api.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.user});

  final User user;

  final List<Map<String, dynamic>> apps = [
    {'name': 'Comptabilité', 'image': 'assets/home/accounting.png', 'route': 'accounting'},
    {'name': 'Fiscalité', 'image': 'assets/home/tax.png', 'route': 'tax'},
    {'name': 'Immobilisation', 'image': 'assets/home/fixed-asset.png', 'route': 'asset'},
    {'name': 'Logistique', 'image': 'assets/home/logistic.png', 'route': 'logistic'},
    {'name': 'Personnel', 'image': 'assets/home/human-resource.png', 'route': 'employee'},
    {'name': 'Planning', 'image': 'assets/home/planning.png', 'route': 'planning'},
  ];

  final List<Map<String, dynamic>> configs = [
    {'name': 'Organisation', 'icon': Icons.business, 'color': Colors.blue.shade700},
    {'name': 'Compte', 'icon': Icons.manage_accounts, 'color': Colors.blue.shade700},
    {'name': 'Quitter', 'icon': Icons.exit_to_app, 'color': Colors.red.shade500}
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final activeServer = context.read<ActiveServerCubit>().state;

    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) => CurrencyRepository(
                  protocol: activeServer.protocol,
                  host: activeServer.host,
                  port: activeServer.port
              )
          )
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => CurrencyApiStatusCubit()
              ),
              BlocProvider(
                  create: (context) => CurrencyCubit(
                      repository: context.read<CurrencyRepository>(),
                      apiStatus: context.read<CurrencyApiStatusCubit>(),
                      connectivityStatus: context.read<ConnectivityStatusCubit>()
                  )..getCurrencies(user.accessToken as String),
              ),
              BlocProvider(
                  create: (context) => OrganizationCurrencyCubit(
                      repository: context.read<CurrencyRepository>(),
                      apiStatus: context.read<CurrencyApiStatusCubit>(),
                      connectivityStatus: context.read<ConnectivityStatusCubit>()
                  )
              )
            ],
            child: BlocListener<CurrencyCubit, List<Currency>?>(
              listener: (context, globalCurrency) {
                context.read<OrganizationCurrencyCubit>().getCurrencies(user.organization, user.accessToken as String);
              },
              child: Scaffold(
                  backgroundColor: Colors.white60.withOpacity(0.4),
                  body: Center(
                    child: SizedBox.fromSize(
                      size: Size(width * 0.60, height * 0.75),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Flexible(
                                flex: 0,
                                child: AppBar(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0)
                                  ),
                                  title: Text('Bienvenue ${user.username}'),
                                  centerTitle: true,
                                )
                            ),
                            Flexible(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Flexible(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 12),
                                          child: Text(
                                            'Applications',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        )
                                    ),
                                    Flexible(
                                        flex: 4,
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return GridView.builder(
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                crossAxisSpacing: 2,
                                                mainAxisSpacing: 5,
                                                mainAxisExtent: 90, //
                                              ),
                                              itemBuilder: (context, index) {

                                                return Column(
                                                  children: [
                                                    Expanded(
                                                        child: Hero(
                                                            tag: '${apps[index]['name']}-hero',
                                                            child: InkWell(
                                                              onTap: () {
                                                                context.goNamed(
                                                                    apps[index]['route'],
                                                                    extra: {
                                                                      'user': user,
                                                                      'organizationContextMenuCubit': context.read<OrganizationContextMenuCubit>(),
                                                                      'organizationCurrencyCubit': context.read<OrganizationCurrencyCubit>()
                                                                    }
                                                                );
                                                              },
                                                              child: Card(
                                                                elevation: 5,
                                                                color: Colors.white,
                                                                child: Image.asset(
                                                                  apps[index]['image'],
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                            )
                                                        )
                                                    ),
                                                    Text(
                                                      apps[index]['name'],
                                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                                    )
                                                  ],
                                                );
                                              },
                                              itemCount: 6,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth / 5),
                                            );
                                          },
                                        )
                                    ),
                                    const Flexible(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 18.0, bottom: 12.0),
                                          child: Text(
                                            'Configuration',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        )
                                    ),
                                    Flexible(
                                        flex: 2,
                                        child: LayoutBuilder(builder: (context, constraints) {
                                          return GridView.builder(
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              mainAxisExtent: 90,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () { print(index);},
                                                    child: Card(
                                                      elevation: 5,
                                                      color: Colors.white,
                                                      child: Icon(
                                                        configs[index]['icon'],
                                                        color: configs[index]['color'],
                                                        size: 60,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    configs[index]['name'],
                                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                                  )
                                                ],
                                              );
                                            },
                                            itemCount: 3,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth / 5),
                                          );
                                        })
                                    ),
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            )
        )
    );
  }
}
