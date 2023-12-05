import 'package:activity_api/activity_api.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductAccountingView extends StatefulWidget {
  ProductAccountingView({super.key});

  @override
  State<ProductAccountingView> createState() => _ProductAccountingViewState();
}

class _ProductAccountingViewState extends State<ProductAccountingView> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditingProduct, Product?>(
      builder: (context, editProduct) {
        return Column(
          children: [
            Flexible(
              child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade700,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        clipBehavior: Clip.antiAlias,
                        width: constraints.maxWidth,
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Compte comptable',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0
                              ),
                            ),
                            if (editProduct?.name != null) Text(
                              editProduct!.name,
                              style: const TextStyle(
                                  color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
            const Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Text('Nouveau compte', textAlign: TextAlign.start,)
                    ],
                  ),
                )
            ),
            Flexible(
                child: Form(
                    child: Row(
                      children: [
                        Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 7.5),
                              child: DropdownSearch(
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      filled: true,
                                      labelText: 'Compte*',
                                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0)
                                    ),
                                ),
                                dropdownButtonProps: const DropdownButtonProps(),
                              ),
                            )
                        ),
                        Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  label: const Text("Numéro de compte*"),
                                  suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.send),
                                    tooltip: "Ajouter",
                                  )
                                ),
                              ),
                            )
                        ),
                      ],
                    )
                )
            ),
            Flexible(
              flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      trackVisibility: true,
                      thickness: 4.0,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: DataTable(
                            border: const TableBorder(
                                horizontalInside: BorderSide()
                            ),
                            columns: const [
                              DataColumn(label: Text("Comptes"))
                            ],
                            rows: List.generate(100, (index) => const DataRow(cells: [
                              DataCell(Text('data'))
                            ]))
                        ),
                      )
                  ),
                )
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
