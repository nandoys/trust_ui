import 'package:accounting_api/accounting_api.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:activity_api/activity_api.dart';
import 'package:server_api/server_api.dart';
import 'package:utils/utils.dart';


class ProductCategoryCubit extends Cubit<List<ProductCategory>> {
  ProductCategoryCubit({
    required this.productCategoryRepository,
    required this.connectivityStatus,
    required this.apiStatus
  }) : super([]);

  final ProductCategoryRepository productCategoryRepository;
  final ConnectivityStatusCubit connectivityStatus;
  final ProductCategoryApiStatusCubit apiStatus;

  void getCategories(String token) async {
    try {
        apiStatus.changeStatus(ApiStatus.requesting);
        List<ProductCategory> response = await productCategoryRepository.getProductCategories(token);

        emit(response);

        if (connectivityStatus.state == ConnectivityStatus.disconnected){
          connectivityStatus.changeStatus(ConnectivityStatus.connected);
        }
      }
      on http.ClientException {
        connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
      }
      catch (e) {
        apiStatus.changeStatus(ApiStatus.failed);
      }
    }

}

class ProductCategoryConfigCubit extends Cubit<List<Module>> {
  ProductCategoryConfigCubit() : super([]);

  void selectModule(List<Module> modules) {
    emit(modules);
  }

}

class EditingProductCubit extends Cubit<Product?> {
  EditingProductCubit({required this.repository, required this.connectivityStatus, required this.apiStatus}) : super(null);

  final ProductRepository repository;
  final ConnectivityStatusCubit connectivityStatus;
  final ProductApiStatusCubit apiStatus;

  void createProduct({required Product product, required String token, required ProductsCubit productsCubit}) async {
    try {
      apiStatus.isUpdating = false;
      apiStatus.changeStatus(ApiStatus.requesting);
      Product? response = await repository.add(product, token);
      emit(response);
      if (response?.id != null) {
        apiStatus.changeStatus(ApiStatus.succeeded);
        productsCubit.addProduct(response!);
      }

      if (connectivityStatus.state == ConnectivityStatus.disconnected){
        connectivityStatus.changeStatus(ConnectivityStatus.connected);
      }
    }
    on http.ClientException {
      connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
    }
    catch (e) {
      apiStatus.changeStatus(ApiStatus.failed);
    }
  }

  void updateByField(Product product, String field, dynamic value, String token) async {
    try {
      apiStatus.isUpdating = true;
      apiStatus.changeStatus(ApiStatus.requesting);
      Product? response = await repository.updateByField(product, field, value, token);
      emit(response);
      if (response.id != null) apiStatus.changeStatus(ApiStatus.succeeded);

      if (connectivityStatus.state == ConnectivityStatus.disconnected){
        connectivityStatus.changeStatus(ConnectivityStatus.connected);
      }
    }
    on http.ClientException {
      connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
    }
    catch (e) {
      apiStatus.changeStatus(ApiStatus.failed);
    }
  }

  void edit(Product? product) {
    emit(product);
  }
}


class ProductsCubit extends Cubit<List<Product>> {
  ProductsCubit({required this.repository, required this.connectivityStatus, required this.apiStatus}) : super([]);

  final ProductRepository repository;
  final ConnectivityStatusCubit connectivityStatus;
  final ProductApiStatusCubit apiStatus;

  void getProducts({String? filters, required String token}) async {
    try {
      apiStatus.isUpdating = null;
      apiStatus.changeStatus(ApiStatus.requesting);
      List<Product> response = await repository.get(filters, token);
      emit(response);

      apiStatus.changeStatus(ApiStatus.succeeded);

      if (connectivityStatus.state == ConnectivityStatus.disconnected){
        connectivityStatus.changeStatus(ConnectivityStatus.connected);
      }
    }
    on http.ClientException {
      connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
    }
    catch (e) {
      apiStatus.changeStatus(ApiStatus.failed);
    }
  }

  void addProduct(Product product) {
    state.add(product);
    emit(state);
  }
}