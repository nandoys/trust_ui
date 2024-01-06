import 'package:accounting_api/accounting_api.dart';
import 'package:bloc/bloc.dart';
import 'package:user_api/user_api.dart';
import 'package:utils/utils.dart';
import 'package:activity_api/activity_api.dart';

class FilterProductTypeCubit extends Cubit<Set<ProductType>> {
  FilterProductTypeCubit() : super({ProductType.bien, ProductType.service, ProductType.mixte});

  void onSelectionChanged(Set<ProductType> selected){
    emit(selected);
  }
}

class ActivityViewModeCubit extends Cubit<ViewMode> {
  ActivityViewModeCubit() : super(ViewMode.list);

  void changeView(ViewMode mode) {
    emit(mode);
  }
}

class ProductBottomNavigationCubit extends Cubit<int> {

  ProductBottomNavigationCubit() : super(0);

  void navigate(int index) {
    emit(index);
  }

}

class SwitchPerishableCubit extends Cubit<bool> {
  SwitchPerishableCubit(): super(false);

  void change(bool state) {
    emit(state);
  }
}

class SwitchInPromoCubit extends Cubit<bool> {
  SwitchInPromoCubit(): super(false);

  void change(bool state) {
    emit(state);
  }
}

class SaveProductFormCubit extends Cubit<Map<String, dynamic>> {
  SaveProductFormCubit({required this.user}) : super({
    'id': null,
    'organization': user.organization,
    'name': null,
    'product_category': null,
    'reference': null,
    'barcode': null,
    'currency': null,
    'buying_price': null,
    'selling_price': null,
    'sell_in_promo': null,
    'can_perish': false,
    'in_promo': false,
    'accounts': null,
    'taxes': null
  });

  final User user;

  void setValue(String fieldName, value, [List<Module>? modules]) {

    state[fieldName] = value;

    if (modules != null) {
      if (!modules.any((module) => module.name == 'achat')) {
        state['buy_price'] = null;
      }

      if (!modules.any((module) => module.name == 'vente')) {
        state['sell_price'] = null;
        state['sell_in_promo'] = null;
        state['in_promo'] = false;
      }
    }

    emit(state);
  }
}

class OnchangeProductCategoryCubit extends Cubit<ProductCategory?> {
  OnchangeProductCategoryCubit() : super(null);

  void change(ProductCategory? productCategory) {
    emit(productCategory);
  }

}

class OnchangeProductCategoryAccountCubit extends Cubit<Account?> {
  OnchangeProductCategoryAccountCubit() : super(null);

  void change(Account? productCategoryAccount) {
    emit(productCategoryAccount);
  }

}