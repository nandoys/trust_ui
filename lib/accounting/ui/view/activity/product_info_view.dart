import 'package:accounting_api/accounting_api.dart';
import 'package:activity_api/activity_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_api/user_api.dart';
import 'package:trust_app/accounting/ui/widget/accounting_widget.dart';

class ProductInfoView extends StatefulWidget {
  const ProductInfoView({super.key, this.product, required this.user, required this.formKey});

  final GlobalKey<FormState> formKey;
  final Product? product;
  final User user;

  @override
  State<ProductInfoView> createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends State<ProductInfoView> {
  final scrollController = ScrollController();
  final nameController = TextEditingController();
  final referenceController = TextEditingController();
  final barCodeController = TextEditingController();
  final buyingPriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  final sellInPromoPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final product = context.read<EditingProduct>().state;

    // reset the UI by removing sell, buy fields at the start
    if (product?.id == null) {
      context.read<ProductCategoryConfigCubit>().selectModule([]);
    } else {
      nameController.text = (product?.name ?? product?.name)!;
      referenceController.text = product?.reference == null ? '' : product?.reference.toString() as String;
      barCodeController.text = product?.barCode == null ? '' : product?.barCode.toString() as String;
      buyingPriceController.text = product?.buyPrice == null ? '' : product?.buyPrice.toString() as String;
      sellingPriceController.text = product?.sellPrice == null ? '' : product?.sellPrice.toString() as String;
      sellInPromoPriceController.text = product?.sellPromoPrice == null ? '' :
      product?.sellPromoPrice.toString() as String;
    }

    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      Container(
                        width: constraints.maxWidth * 0.965,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.black26)
                        ),
                        margin: const EdgeInsets.only(bottom: 25.0, left: 15.0),
                      ),
                      Center(
                          child: SizedBox(
                              width: 150,
                              height: 150,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue.shade700,
                                child: const Text(
                                  'P',
                                  style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.w600, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              )
                          )
                      ),
                      const Positioned(
                        bottom: 1,
                        top: 85,
                        left: 450,
                        child: Center(
                            child: CircleAvatar(backgroundColor: Colors.black26,)
                        ),
                      ),
                    ],
                  );
                }
            ),
            const SizedBox(height: 10,),
            Expanded(
                flex: 1,
                child: BlocBuilder<ProductCategoryConfigCubit, List<Module>>(
                    builder: (_, modules) {
                      widget.formKey.currentWidget;
                      return Scrollbar(
                          controller: scrollController,
                          trackVisibility: true,
                          thumbVisibility: true,
                          thickness: 4.0,
                          child: GridView.count(
                            controller: scrollController,
                            physics: const BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            shrinkWrap: true,
                            childAspectRatio: 6.5,
                            children: [
                              ProductNameField(controller: nameController,),
                              ProductCategoryField(user: widget.user,),
                              ProductReferenceField(user: widget.user, controller: referenceController,),
                              ProductCodebarField(controller: barCodeController,),
                              const ProductCurrencyField(),
                              ...List.generate(modules.length, (index) {
                                if (modules[index].name == 'achat') {
                                  return ProductBuyPriceField(modules: modules, controller: buyingPriceController,);
                                }
                                else if (modules[index].name == 'vente') {
                                  return Padding(
                                    padding: modules.any((module) => module.name == 'achat') ?
                                    const EdgeInsets.only(left: 15.0) : const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: ProductSellPriceField(modules: modules, controller: sellingPriceController,),
                                  );
                                }
                                return const Text("Aucune configuration trouvée");
                              }),
                              if (modules.any((module) => module.name == 'vente'))
                                Padding(
                                  padding: modules.any((module) => module.name == 'achat') ?
                                  const EdgeInsets.symmetric(horizontal: 15.0) : const EdgeInsets.only(left: 15.0),
                                  child: ProductSellPromoField(modules: modules, controller: sellInPromoPriceController,),
                                ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ProductPerishSwitch(user: widget.user,),
                                  const Text('Périssable'),
                                  const SizedBox(width: 20.0,),
                                  if (modules.any((module) => module.name == 'vente'))
                                    const ProductPromoSwitch(),
                                  if (modules.any((module) => module.name == 'vente'))
                                    const Text('En promotion'),
                                ],
                              )
                            ],
                          )
                      );
                    }
                )
            )
          ],
        )
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    nameController.dispose();
    referenceController.dispose();
    barCodeController.dispose();
    buyingPriceController.dispose();
    sellingPriceController.dispose();
    sellInPromoPriceController.dispose();
    super.dispose();
  }
}


