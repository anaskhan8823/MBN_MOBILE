import 'dart:developer';
import 'dart:io';
import 'package:dalil_2020_app/features/main/home/nav_productive_families_view.dart';
import 'package:dalil_2020_app/features/main/home/nav_shop_owner_view.dart';
import 'package:dalil_2020_app/features/main/home/nav_user_view.dart';
import 'package:dalil_2020_app/models/comments_model.dart';
import 'package:dalil_2020_app/models/product_model.dart';
import 'package:dalil_2020_app/models/store_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/dio_helper.dart';
import '../../../../core/end_points.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/helper/app_toast.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  List<ProductModel> products = [];
  Future<void> downloadProductImages(List<ProductModel> productList) async {
    for (var product in productList) {
      if (product.images != null && product.images!.isNotEmpty) {
        product.imageFiles = [];
        for (var image in product.images!) {
          final imageUrl = image.url ?? ''; // Make sure to get URL
          if (imageUrl.isEmpty) continue;

          final appDocDir = await getApplicationDocumentsDirectory();
          final fileName = basename(imageUrl);
          final filePath = join(appDocDir.path, fileName);
          final file = File(filePath);

          if (file.existsSync()) {
            product.imageFiles!.add(file);
            continue;
          }

          try {
            final response = await Dio().get(
              imageUrl,
              options: Options(responseType: ResponseType.bytes),
            );
            if (response.statusCode == 200) {
              await file.writeAsBytes(response.data);
              product.imageFiles!.add(file);
            }
          } catch (e) {
            log("Failed to download image: ${e.toString()}");
          }
        }
      }
    }
  }

  List<ProductModel> allProducts = []; // stores all fetched products
  List<ProductModel> filteredProducts = [];
  void searchProductsLocally(String query) {
    if (query.isEmpty) {
      filteredProducts = List.from(allProducts); // reset to all
    } else {
      filteredProducts = allProducts.where((p) {
        final nameEn = p.productName?.en ?? '';
        final nameAr = p.productName?.ar ?? '';
        return nameEn.toLowerCase().contains(query.toLowerCase()) ||
            nameAr.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    emit(GetProductsSuccess(filteredProducts));
  }

  Future<void> getAllProducts() async {
    try {
      emit(ProductLoading());
      final queryParams = <String, dynamic>{};

      if (search != null && search!.isNotEmpty) {
        queryParams['search'] = search;
      }
      final response = await DioHelper.get(
        ALL_PRODUCTS,
        parameter: queryParams.isNotEmpty ? queryParams : null,
      );
      if (isClosed) return;
      if (response.isSuccess) {
        final List<ProductModel> list = List<ProductModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => ProductModel.fromJson(e)));
        products.clear();
        products.addAll(list);
        downloadProductImages(list);
        allProducts = list; // store all products
        filteredProducts = list;
        emit(GetProductsSuccess(list));
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(ProductInitial());
    }
  }

  List<CommentsModel> comments = [];
  Future<void> getAllCommentsForProduct(int productId) async {
    try {
      emit(ProductLoading());
      final response = await DioHelper.get("rating/product-rating/$productId");
      if (isClosed) return;
      if (response.isSuccess) {
        final List<CommentsModel> list = List<CommentsModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => CommentsModel.fromJson(e)));
        comments.clear();
        comments.addAll(list);
        emit(GetProductsCommentsSuccess(list));
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(ProductInitial());
    }
  }

  int currentPage = 1;
  bool hasMore = true;
  String? search = "";

  Future<void> getAllProductsForShop({
    int page = 1,
    bool isRefresh = false,
  }) async {
    if (!hasMore && !isRefresh) return; // stop if no more data

    try {
      if (isRefresh) {
        if (isClosed) return;
        emit(ProductLoading());
        currentPage = 1;
        hasMore = true;
        //  search = "";
        products.clear();
      }

      final response =
          await DioHelper.get("$ALL_PRODUCTS_FOR_SHOP?search=$search");

      if (response.isSuccess) {
        final List<ProductModel> list = List<ProductModel>.from(
          (response.data?['data'] ?? []).map((e) => ProductModel.fromJson(e)),
        );

        if (list.isEmpty) {
          hasMore = false; // no more pages
        } else {
          // Prevent duplicates by checking IDs
          final existingIds = products.map((e) => e.id).toSet();
          final uniqueProducts = list.where((e) => !existingIds.contains(e.id));

          products.addAll(uniqueProducts);
          currentPage = page;

          // Await image download
          await downloadProductImages(list);
        }

        if (isClosed) return;
        emit(GetProductsSuccess(List.from(products)));
      }
    } catch (e) {
      if (!isClosed) {
        AppToast.error("The error caused: ${e.toString()}");
        emit(ProductInitial());
      }
    }
  }

  Future<void> getAllProductsForShopForUser(int productId) async {
    try {
      emit(ProductLoading());
      final response = await DioHelper.get("user/product-for-shops/$productId");
      if (response.isSuccess) {
        final List<ProductModel> list = List<ProductModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => ProductModel.fromJson(e)));
        products.clear();
        products.addAll(list);
        emit(GetProductsSuccess(list));
        if (isClosed) return;
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(ProductInitial());
    }
  }

  Future<void> getAllProductsForUser() async {
    try {
      emit(ProductLoading());
      final response = await DioHelper.get(ALL_PRODUCTS_FOR_USER);
      // if (isClosed) return;
      if (response.isSuccess) {
        final List<ProductModel> list = List<ProductModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => ProductModel.fromJson(e)));
        products.clear();
        products.addAll(list);
        downloadProductImages(list);
        emit(GetProductsSuccess(list));
        if (isClosed) return;
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(ProductInitial());
    }
  }

  Future<void> getAllProductsProductiveForUser() async {
    try {
      emit(ProductLoading());
      final response = await DioHelper.get(ALL_PRODUCTS_FOR_USER);
      // if (isClosed) return;
      if (response.isSuccess) {
        final List<ProductModel> list = List<ProductModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => ProductModel.fromJson(e)));
        products.clear();
        products.addAll(list);
        downloadProductImages(list);
        emit(GetProductsSuccess(list));
        if (isClosed) return;
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(ProductInitial());
    }
  }

  Future<void> getProductDetailsForProductive(productId) async {
    try {
      emit(ProductLoading());
      final response =
          await DioHelper.get("productivefamilies/product-details/$productId");
      if (isClosed) return;
      if (response.isSuccess) {
        final data = response.data?['data'];

        final List<ProductModel> list = (data is List)
            ? data.map((e) => ProductModel.fromJson(e)).toList()
            : [];

        // products.clear();
        // products.addAll(list);
        emit(GetProductsSuccess(list));
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(ProductInitial());
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      emit(ProductLoading());
      final response = await DioHelper.delete(
          "productivefamilies/delete-product/$productId");
      if (response.isSuccess) {
        AppToast.success("toasts.deleteSuccessPro");
        emit(ProductInitial());
        AppNavigator.replace(const NavProductiveView());
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(ProductInitial());
      AppNavigator.replace(const NavProductiveView());
    }
  }

  Future<void> deleteProductForShopOwner(int productId) async {
    try {
      emit(ProductLoading());
      final response =
          await DioHelper.delete("shopowner/delete-product/$productId");
      if (response.isSuccess) {
        AppToast.success("toasts.deleteSuccessPro");
        emit(ProductInitial());
        AppNavigator.replace(const NavShopOwnerView());
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(ProductInitial());
      AppNavigator.replace(const NavProductiveView());
    }
  }

  Future<void> deleteProductForUser(int productId) async {
    try {
      emit(ProductLoading());
      final response = await DioHelper.delete("user/delete-product/$productId");
      if (response.isSuccess) {
        AppToast.success("toasts.deleteSuccessPro");
        emit(ProductInitial());
        AppNavigator.replace(const NavUserView());
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(ProductInitial());
      AppNavigator.replace(const NavProductiveView());
    }
  }
}
