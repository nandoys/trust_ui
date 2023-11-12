import 'package:flutter/material.dart';
import 'package:meta/dart2js.dart';
import 'package:user_api/user_api.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.user});

  final User user;

  final List<Map<String, dynamic>> apps = [
    {'name': 'Comptabilité', 'image': 'assets/home/accounting.png'},
    {'name': 'Fiscalité', 'image': 'assets/home/tax.png'},
    {'name': 'Immobilisation', 'image': 'assets/home/fixed-asset.png'},
    {'name': 'Logistique', 'image': 'assets/home/logistic.png'},
    {'name': 'Personnel', 'image': 'assets/home/human-resource.png'},
    {'name': 'Planning', 'image': 'assets/home/planning.png'},
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
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                      mainAxisExtent: 100, //
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () { print(index);},
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: Card(
                                                    elevation: 5,
                                                    color: Colors.white,
                                                    child: Image.asset(
                                                      apps[index]['image'],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                              ),
                                              Text(
                                                apps[index]['name'],
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      // return Column(
                                      //   children: [
                                      //     Container(
                                      //       decoration: const BoxDecoration(
                                      //           image: DecorationImage(image: AssetImage('assets/home/accounting.png'))
                                      //       ),
                                      //       child: ,
                                      //     )
                                      //   ],
                                      // );
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
                              child: Text('Configurations', textAlign: TextAlign.start,)
                          ),
                          Flexible(
                              flex: 2,
                              child: LayoutBuilder(builder: (context, constraints) {
                                return GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 100,
                                    mainAxisExtent: 100,
                                  ),
                                  itemBuilder: (context, index) {
                                    return const Card(child: Text('data'),);
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
