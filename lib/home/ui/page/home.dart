import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/dart2js.dart';
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

    return Scaffold(
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
                                              child: InkWell(
                                                onTap: () {
                                                  context.goNamed(apps[index]['route'], extra: user);
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
    );
  }
}
