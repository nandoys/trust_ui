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

  void getCategories() async {
    try {
        apiStatus.changeStatus(ApiStatus.requesting);
        List<ProductCategory> response = await productCategoryRepository.getProductCategories();

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
  ProductCategoryConfigCubit({
    required this.moduleRepository,
    required this.connectivityStatus,
    required this.apiStatus
}) : super([]);

  final ModuleRepository moduleRepository;
  final ConnectivityStatusCubit connectivityStatus;
  final ProductCategoryConfigApiStatusCubit apiStatus;

  void getConfig(String id) async {
    try {
      apiStatus.changeStatus(ApiStatus.requesting);
      List<Module> response = await moduleRepository.getModulesBy(id);

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
