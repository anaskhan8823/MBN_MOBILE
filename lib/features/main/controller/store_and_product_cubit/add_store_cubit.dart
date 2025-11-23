import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/features/main/home/nav_shop_owner_view.dart';
import 'package:dalil_2020_app/features/main/home/nav_user_view.dart';
import 'package:dalil_2020_app/models/categoty_model.dart';
import 'package:dalil_2020_app/models/comments_model.dart';
import 'package:dalil_2020_app/models/country_and_code_model.dart';
import 'package:dalil_2020_app/models/discount_model.dart';
import 'package:dalil_2020_app/models/store_model.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/dio_helper.dart';
import '../../../../core/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/helper/app_toast.dart';
import '../../../../core/utils.dart';
import '../../home/nav_productive_families_view.dart';
import 'package:flutter/material.dart';
part 'add_store_state.dart';

class StoreAndProductCubit extends Cubit<StoreAndProductState> {
  StoreAndProductCubit() : super(AddStoreInitial());
  final TextEditingController arabicName = TextEditingController();
  final TextEditingController englishName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController arabicDisc = TextEditingController();
  final TextEditingController englishDisc = TextEditingController();
  final TextEditingController priceBeforeDisc = TextEditingController();
  final TextEditingController priceAfterDisc = TextEditingController();
  final TextEditingController discVal = TextEditingController();

  final TextEditingController searchController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  final Map<String, bool> dayStates = {
    'Saturday': false,
    'Sunday': false,
    'Monday': false,
    'Tuesday': true,
    'Wednesday': false,
    'Thursday': true,
    'Friday': false,
  };
  // void initializeDayStatess(List<WorkingTime> workingTimes) {
  //   for (var day in workingTimes) {
  //     dayStates[day.dayOfWeek.toString()!] = day.isWorkingDay ?? false;
  //   }
  // }

  final Map<String, String> startTimes = {
    'Saturday': 'Start time',
    'Sunday': 'Start time',
    'Monday': 'Start time',
    'Tuesday': 'Start time',
    'Wednesday': 'Start time',
    'Thursday': 'Start time',
    'Friday': 'Start time',
  };
  final Map<String, String?> serverStartTimes = {};
  final Map<String, String?> serverEndTimes = {};
  final Map<String, String> endTimes = {
    'Saturday': 'End time',
    'Sunday': 'End time',
    'Monday': 'End time',
    'Tuesday': 'End time',
    'Wednesday': 'End time',
    'Thursday': 'End time',
    'Friday': 'End time',
  };
  List<CategoryModel> categoryModel = [];
  List<CountryModel> countryModel = [];
  List<Children> subModel = [];

  int? selectedCategoryId;
  int? selectedSubCat;

  int? selectedContouryId;

  int? selectedCityId;
  int? duscountID;

  String? selectedSubCategory;

  String? selectedContoury;
  String? selectedCity;
  String? selectedCategory;
  List<String> filters = [];
  String? selectedDate;
  int? rate;
  List<int> selectedSubCategoryIds = [];
  List<StoreModel> stores = [];
  String? saleType;
  String? disType;
  List<CommentsModel> comments = [];
  List<String> days = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  List<DiscountCardModel> cards = [];

  Future<void> getDiscountCards() async {
    try {
      emit(DiscountCardLoading());
      final response = await DioHelper.get("discount-cards");

      if (response.isSuccess) {
        final List<DiscountCardModel> list = List<DiscountCardModel>.from(
          (response.data?['data'] ?? [])
              .map((e) => DiscountCardModel.fromJson(e)),
        );

        cards
          ..clear()
          ..addAll(list);

        emit(DiscountCardSuccess(cards));
      } else {
        emit(DiscountCardError("Failed to load discount cards"));
      }
    } catch (e) {
      AppToast.error("Error: ${e.toString()}");
      emit(DiscountCardError(e.toString()));
    }
  }

  void changeWorkAndHoliday(day, value) {
    dayStates[day] = value;
    emit(ChangeValue());
  }

  void changeDiscountType(String? value) {
    disType = value ?? 'fixed';
    calculatePriceAfterDisc();
    emit(ChangeValue());
  }

  void submitSelectedCategory(int? id) {
    selectedCategoryId = id;
    emit(ChangeValue()); // ek naya state emit karo
  }

  void calculatePriceAfterDisc() {
    double price = double.tryParse(priceBeforeDisc.text) ?? 0;
    double disc = double.tryParse(discVal.text) ?? 0;

    if (disType == 'fixed') {
      priceAfterDisc.text =
          (price - disc).clamp(0, double.infinity).toStringAsFixed(2);
    } else if (disType == 'percent') {
      priceAfterDisc.text = (price - (price * disc / 100))
          .clamp(0, double.infinity)
          .toStringAsFixed(2);
    }
  }

  void clearCountrySelection() {
    country.text = "";
    emit(FiltersUpdated());
  }

  void clearCategorySelections() {
    selectedCategory = null;
    selectedCategoryId = null;
    emit(FiltersUpdated());
  }

  void pickDate(dynamic value) {
    if (selectedDate != null) {
      selectedDate = value;
    }
    emit(ChangeValue());
  }

  void resetSubCategory() {
    selectedSubCat = null;
    selectedSubCategory = null; // reset the name too
    emit(ChangeValue()); // trigger rebuild
  }

  void initializeDayStates(List<WorkingTime> workingTimes) {
    for (var day in workingTimes) {
      // convert dayOfWeek int to actual day name using cubit.days list
      final dayName = days[day.dayOfWeek ?? 0]; // int? -> String
      dayStates[dayName] = day.isWorkingDay ?? false;
      startTimes[dayName] = day.openingTime ?? '';
      endTimes[dayName] = day.closingTime ?? '';
    }
  }

  void setWorkingTimesFromServer(List<dynamic> workingTimes) {
    for (var day in workingTimes) {
      final dayName = days[day['day_of_week']];
      serverStartTimes[dayName] = day['opening_time'];
      serverEndTimes[dayName] = day['closing_time'];
    }
    emit(AddStoreInitial());
  }

  void pickStartTime(String day, String startValue) {
    if (serverStartTimes.isNotEmpty) {
      startTimes[day] = serverStartTimes[day] = startValue;
    } else {
      startTimes[day] = startValue;
    }
    emit(ChangeValue());
  }

  void pickEndTime(String day, String endValue) {
    endTimes[day] = endValue;
    emit(ChangeValue());
  }

  void clearCategorySelection() {
    selectedCategoryId = null;
    selectedSubCat = null;
    categoryModel.clear();
    selectedSubCategory = null;
    subModel.clear();
    emit(AddStoreInitial());
  }

  // void changeCategory(
  //   int? id,
  // ) async {
  //   selectedCategoryId = id;
  //   if (id != null) {
  //     final selectedCategory = categoryModel.firstWhere(
  //       (category) => category.id == id,
  //       orElse: () => CategoryModel(),
  //     );
  //     subModel = selectedCategory.children ?? [];
  //   } else {
  //     subModel.clear();
  //   }
  //   emit(AddStoreInitial());
  // }

  void changeCategory(
    int? id,
  ) async {
    selectedCategoryId = id;
    if (id != null) {
      final selectedCategory = categoryModel.firstWhere(
        (category) => category.id == id,
        orElse: () => CategoryModel(),
      );
      subModel = selectedCategory.children ?? [];
    } else {
      subModel.clear();
    }
    emit(AddStoreInitial());
  }

  void changeSubCategory(String? value, int subCategoryId) {
    selectedSubCategory = value;
    if (!selectedSubCategoryIds.contains(subCategoryId)) {
      selectedSubCat = subCategoryId;
      selectedSubCategoryIds.add(subCategoryId);
      emit(AddStoreInitial());
    }
    emit(AddStoreInitial());
  }

  void changeSellType(
    String? type,
  ) async {
    saleType = type;
    emit(AddStoreInitial());
  }

  // void changeDiscountType(
  //   String? disctype,
  // ) async {
  //   disType = disctype;
  //   emit(AddStoreInitial());
  // }

  void changeRate(
    int? value,
  ) async {
    rate = value;
    emit(AddStoreInitial());
  }

  Future<void> addProduct(images, id) async {
    print("---------------------AddProducr---------------------");
    if (images == null || images.isEmpty) {
      AppToast.error("toasts.fillImages");
      return;
    }
    List<MultipartFile> multiImages = images.map<MultipartFile>((i) {
      return MultipartFile.fromFileSync(i.path);
    }).toList();
    try {
      emit(AddStoreLoading());
      final response = await DioHelper.send(ADD_PRODUCT, data: {
        "name[en]": englishName.text,
        "name[ar]": arabicName.text,
        "description[en]": englishDisc.text,
        "description[ar]": arabicDisc.text,
        "price": priceBeforeDisc.text,
        "discount_value": priceAfterDisc.text,
        "sale_type": saleType,
        "sale_value": discVal,
        "calculation_type": disType,
        "images[]": multiImages,
        "category_id[]": [selectedCategoryId, selectedSubCat],
        "family_id": id
      });
      if (response.isSuccess) {
        AppToast.success("toasts.addSuccess");
        emit(AddStoreInitial());
        AppNavigator.replace(const NavProductiveView());
      } else {
        final error = ServerFailure.fromResponse(response);
        AppToast.error(response.msg);
        if (error.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if ([
          'general',
          'category_id',
          'description',
          'price',
          'sale_type',
          'calculation_type',
          'name'
        ].contains(error.error[0].field)) {
          AppToast.error(error.error[0].message ?? "");
        } else if ([
          'category_id.0',
          'category_id.1',
        ].contains(error.error[0].field)) {
          AppToast.error("toasts.fillCateg");
        } else {
          AppToast.error(error.error[0].message ?? "");
        }
        emit(AddStoreInitial());
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(AddStoreInitial());
    }
  }

  Future<void> editProductForProductive(productId, images) async {
    List<MultipartFile> multiImages = images.map<MultipartFile>((i) {
      return MultipartFile.fromFileSync(i.path);
    }).toList();
    try {
      emit(EditProductLoading());
      final response = await DioHelper.send(
          "productivefamilies/update-product/$productId?_method=put",
          data: {
            if (englishName.text.isNotEmpty) "name[en]": englishName.text,
            if (arabicName.text.isNotEmpty) "name[ar]": arabicName.text,
            if (englishDisc.text.isNotEmpty)
              "description[en]": englishDisc.text,
            if (arabicDisc.text.isNotEmpty) "description[ar]": arabicDisc.text,
            if (priceBeforeDisc.text.isNotEmpty) "price": priceBeforeDisc.text,
            if (priceAfterDisc.text.isNotEmpty)
              "discount_value": priceAfterDisc.text,
            if (saleType != null) "sale_type": saleType,
            if (disType != null) "calculation_type": disType,
            if (images != null) "image[]": multiImages,
            if (selectedCategoryId != null && selectedSubCategory != null)
              "category_id[]": [selectedCategoryId, selectedSubCat],
            "store_id": ''
          });
      if (response.isSuccess) {
        AppToast.success("toasts.editSuccessProduct");
        emit(AddStoreInitial());
        AppNavigator.replace(const NavProductiveView());
      } else {
        final error = ServerFailure.fromResponse(response);
        if (error.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if ([
          'general',
          'category_id',
          'description',
          'price',
          'sale_type',
          'calculation_type',
          'name'
        ].contains(error.error[0].field)) {
          AppToast.error(error.error[0].message ?? "");
        }
        emit(AddStoreInitial());
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(AddStoreInitial());
    }
  }

  Future<void> editProductForUser(productId, images) async {
    List<MultipartFile> multiImages = images.map<MultipartFile>((i) {
      return MultipartFile.fromFileSync(i.path);
    }).toList();
    try {
      emit(EditProductLoading());
      final response = await DioHelper.send(
          "user/update-product/$productId?_method=put",
          data: {
            if (englishName.text.isNotEmpty) "name[en]": englishName.text,
            if (arabicName.text.isNotEmpty) "name[ar]": arabicName.text,
            if (englishDisc.text.isNotEmpty)
              "description[en]": englishDisc.text,
            if (arabicDisc.text.isNotEmpty) "description[ar]": arabicDisc.text,
            if (priceBeforeDisc.text.isNotEmpty) "price": priceBeforeDisc.text,
            if (priceAfterDisc.text.isNotEmpty)
              "discount_value": priceAfterDisc.text,
            if (saleType != null) "sale_type": saleType,
            if (disType != null) "calculation_type": disType,
            if (images != null) "image[]": multiImages,
            if (selectedCategoryId != null && selectedSubCategory != null)
              "category_id[]": [selectedCategoryId, selectedSubCat],
            "store_id": ''
          });
      if (response.isSuccess) {
        AppToast.success("toasts.editSuccessProduct");
        emit(AddStoreInitial());
        AppNavigator.replace(const NavUserView());
      } else {
        final error = ServerFailure.fromResponse(response);
        if (error.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if ([
          'general',
          'category_id',
          'description',
          'price',
          'sale_type',
          'calculation_type'
        ].contains(error.error[0].field)) {
          AppToast.error(error.error[0].message ?? "");
        }
        emit(AddStoreInitial());
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(AddStoreInitial());
    }
  }

  Future<void> editProductForShopOwner(
      int productId, List<File> images, int storeId) async {
    if (images.isEmpty) {
      AppToast.error("toasts.fillImages");
      return;
    }

    List<MultipartFile> multiImages = images.map<MultipartFile>((i) {
      return MultipartFile.fromFileSync(i.path);
    }).toList();

    final dataMap = {
      if (englishName.text.isNotEmpty) "name[en]": englishName.text,
      if (arabicName.text.isNotEmpty) "name[ar]": arabicName.text,
      if (englishDisc.text.isNotEmpty) "description[en]": englishDisc.text,
      if (arabicDisc.text.isNotEmpty) "description[ar]": arabicDisc.text,
      if (priceBeforeDisc.text.isNotEmpty) "price": priceBeforeDisc.text,
      if (priceAfterDisc.text.isNotEmpty) "discount_value": priceAfterDisc.text,
      if (saleType != null) "sale_type": saleType,
      if (discVal.text.isNotEmpty) "sale_value": discVal.text,
      if (disType != null) "calculation_type": disType,
      if (images.isNotEmpty) "image[]": multiImages,
      if (selectedCategoryId != null && selectedSubCategory != null)
        "category_id[]": [selectedCategoryId, selectedSubCat],
      "store_id": storeId,
      // 👈 Laravel update ke liye zaroori
    };

    print("Edit Payload: $dataMap"); // Debugging

    try {
      emit(EditProductLoading());

      final response = await DioHelper.put(
        "shopowner/update-product/$productId?_method=put",
        formData: FormData.fromMap(dataMap),
      );

      if (response.isSuccess) {
        AppToast.success("toasts.editSuccessProduct");
        emit(AddStoreInitial());
        AppNavigator.replace(const NavShopOwnerView());
      } else {
        final error = ServerFailure.fromResponse(response);
        if (error.error.isEmpty) {
          AppToast.error("failure.unexpected_error".tr());
        } else {
          AppToast.error(error.error[0].message ?? "");
        }
        emit(AddStoreInitial());
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(AddStoreInitial());
    }
  }

  Future<void> getAllCommentsForProduct(int productId) async {
    try {
      emit(AddStoreLoading());
      final response = await DioHelper.get("rating/product-rating/$productId");
      if (isClosed) return;
      if (response.isSuccess) {
        final List<CommentsModel> comment = List<CommentsModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => CommentsModel.fromJson(e)));
        comments.clear();
        comments.addAll(comment);
        emit(GetProductsStoreCommentsSuccess(comment));
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(AddStoreInitial());
    }
  }

  Future<void> addProductForShopOwner(images, storeId) async {
    print("---------------------addProductForShopOwner---------------------");

    if (images == null || images.isEmpty) {
      AppToast.error("toasts.fillImages");
      return;
    }
    List<MultipartFile> multiImages = images.map<MultipartFile>((i) {
      return MultipartFile.fromFileSync(i.path);
    }).toList();
    try {
      emit(AddStoreLoading());
      final response = await DioHelper.send(ADD_PRODUCT_FOR_SHOP, data: {
        "name[en]": englishName.text,
        "name[ar]": arabicName.text,
        "description[en]": englishDisc.text,
        "description[ar]": arabicDisc.text,
        "price": priceBeforeDisc.text,
        "discount_value": priceAfterDisc.text,
        "sale_type": saleType,
        "sale_value": discVal,
        "calculation_type": disType,
        "images[]": multiImages,
        "category_id[]": [selectedCategoryId, selectedSubCat],
        "store_id": storeId
      });
      print({
        "name[en]": englishName.text,
        "name[ar]": arabicName.text,
        "description[en]": englishDisc.text,
        "description[ar]": arabicDisc.text,
        "price": priceBeforeDisc.text,
        "discount_value": priceAfterDisc.text,
        "sale_type": saleType,
        "calculation_type": disType,
        "images[]": multiImages,
        "category_id[]": [selectedCategoryId, selectedSubCat],
        "store_id": storeId
      });
      if (response.isSuccess) {
        AppToast.success("toasts.addSuccess");
        emit(AddStoreInitial());
        AppNavigator.replace(const NavShopOwnerView());
      } else {
        final error = ServerFailure.fromResponse(response);
        if (error.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if ([
          'general',
          'description',
          'price',
          'sale_type',
          'calculation_type',
          'name'
        ].contains(error.error[0].field)) {
          AppToast.error(error.error[0].message ?? "");
        } else if ([
          'category_id.0',
          'category_id.1',
        ].contains(error.error[0].field)) {
          AppToast.error("toasts.fillCateg");
        } else {
          AppToast.error(error.error[0].message ?? "");
        }
        emit(AddStoreInitial());
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(AddStoreInitial());
    }
  }

  Future<void> addProductForUser(images, userid) async {
    print("---------------------addProductForUser---------------------");

    if (images == null || images.isEmpty) {
      AppToast.error("toasts.fillImages");
      return;
    }
    List<MultipartFile> multiImages = images.map<MultipartFile>((i) {
      return MultipartFile.fromFileSync(i.path);
    }).toList();
    try {
      emit(AddStoreLoading());
      final response = await DioHelper.send(ADD_PRODUCT_FOR_USER, data: {
        "user_id": userid,
        "name[en]": englishName.text,
        "name[ar]": arabicName.text,
        "description[en]": englishDisc.text,
        "description[ar]": arabicDisc.text,
        "price": priceBeforeDisc.text,
        "discount_value": priceAfterDisc.text,
        "sale_type": saleType,
        "calculation_type": disType,
        "images[]": multiImages,
        "category_id[]": [selectedCategoryId, selectedSubCat],
      });
      if (response.isSuccess) {
        AppToast.success("toasts.addSuccess");
        emit(AddStoreInitial());
        AppNavigator.replace(Utils.getUser);
      } else {
        final error = ServerFailure.fromResponse(response);
        if (error.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if ([
          'general',
          'description',
          'price',
          'sale_type',
          'calculation_type',
          'name'
        ].contains(error.error[0].field)) {
          AppToast.error(error.error[0].message ?? "");
        } else if ([
          'category_id.0',
          'category_id.1',
        ].contains(error.error[0].field)) {
          AppToast.error("toasts.fillCateg");
        } else {
          AppToast.error(error.error[0].message ?? "");
        }
        emit(AddStoreInitial());
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(AddStoreInitial());
    }
  }

  Future<void> addComment(int? productId, int? storeId) async {
    // try {
    emit(AddStoreLoading());
    final response = await DioHelper.send(ADD_RATING, data: {
      "comment": commentController.text,
      if (productId != null) "product_id": productId,
      'ratings': rate ?? 0,
      if (storeId != null) 'store_id': storeId
    });
    if (response.isSuccess) {
      AppToast.success("Comment added successfully");
      productId != null
          ? getAllCommentsForProduct(productId)
          : getAllCommentsForStore(storeId!);
      emit(AddStoreInitial());
      AppNavigator.pop();
      // AppNavigator.push(Utils.getUser);
    } else {
      final error = ServerFailure.fromResponse(response);
      if (error.error.isEmpty) {
        String errMsg = "failure.unexpected_error".tr();
        AppToast.error(errMsg);
      } else if ([
        "general",
        'comment',
        'ratings',
      ].contains(error.error[0].field)) {
        AppToast.error(error.error[0].message ?? "");
      }
      productId != null
          ? getAllCommentsForProduct(productId)
          : getAllCommentsForStore(storeId!);
      AppNavigator.pop();

      emit(AddStoreInitial());
    }
    // } catch (e) {
    //   AppToast.error("the error cause ${e.toString()}");
    //   emit(AddStoreInitial());
    // }
  }

  Future<void> searchStores(String searchQuery) async {
    if (searchQuery.isEmpty) {
      emit(AddStoreInitial());
      return;
    }

    emit(AddStoreLoading());

    try {
      final response =
          await DioHelper.get('user/stores/search=&country_id=$searchQuery');

      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final stores = data['data'] ?? [];
        if (stores.isEmpty) {
          emit(AddStoreInitial());
        } else {
          emit(SearchLoaded(stores));
        }
      } else {
        emit(AddStoreInitial());
      }
    } catch (e) {
      AppToast.error(e.toString());
      emit(AddStoreInitial());
    }
  }

  // Future<void> getCategories() async {
  //   try {
  //     emit(AddStoreLoading());
  //     final response = await DioHelper.get(CATEGORIES);
  //     if (response.isSuccess) {
  //       final List<CategoryModel> list = List<CategoryModel>.from(
  //           (response.data?['data'] ?? [])
  //               .map((e) => CategoryModel.fromJson(e)));
  //       categoryModel.clear();
  //       categoryModel.addAll(list);
  //       emit(AddStoreSuccess());
  //     }
  //   } catch (e) {
  //     AppToast.error("the error cause ${e.toString()}");
  //     emit(AddStoreFailure("the error cause ${e.toString()}"));
  //   }
  // }
  Future<void> getCategoriesFilters() async {
    try {
      final response = await DioHelper.get(CATEGORIES);
      if (response.isSuccess) {
        final List<CategoryModel> list = List<CategoryModel>.from(
          (response.data?['data'] ?? []).map((e) => CategoryModel.fromJson(e)),
        );
        categoryModel
          ..clear()
          ..addAll(list);

        // 👇 koi emit mat karo
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
    }
  }

  void changeCategoryFilter(
    int? id,
  ) async {
    selectedCategoryId = id;
    if (id != null) {
      final selectedCategory = categoryModel.firstWhere(
        (category) => category.id == id,
        orElse: () => CategoryModel(),
      );
      subModel = selectedCategory.children ?? [];
    } else {
      subModel.clear();
    }
  }

  Future<void> getCategories() async {
    try {
      emit(AddStoreLoading());
      final response = await DioHelper.get(CATEGORIES);
      if (response.isSuccess) {
        final List<CategoryModel> list = List<CategoryModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => CategoryModel.fromJson(e)));
        categoryModel.clear();
        categoryModel.addAll(list);
        emit(AddStoreSuccess());
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(AddStoreFailure("the error cause ${e.toString()}"));
    }
  }

  Future<void> getCountry() async {
    try {
      emit(AddStoreLoading());
      final response = await DioHelper.get(COUNTRY_AND_CODE);
      if (response.isSuccess) {
        final List<CountryModel> list = List<CountryModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => CountryModel.fromJson(e)));
        countryModel.clear();
        countryModel.addAll(list);
        emit(AddStoreSuccess());
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(AddStoreFailure("the error cause ${e.toString()}"));
    }
  }

  void clearStores() {
    stores.clear();
    currentPage = 1;
    totalPages = 1;
    search = "";
    emit(AddStoreInitial()); // ya koi default state
  }

  int currentPage = 1;
  int totalPages = 1;
  bool isLoadingMore = false;
  String? search = "";

  Future<void> getAllStores({
    bool isRefresh = false,
    Function()? actionFromScreen,
  }) async {
    if (isLoadingMore) return;

    if (isRefresh) {
      currentPage = 1;
      stores.clear();
      emit(AddStoreLoading());
      print("🔄 Refreshing stores list...");
    }

    try {
      isLoadingMore = true;
      actionFromScreen?.call();

      print("📡 Fetching stores... page=$currentPage, search=$search");

      final response = await DioHelper.get('$ALL_STORES?search=$search');

      if (isClosed) return;

      if (response.isSuccess) {
        print("✅ API call success");

        // Safely handle List response
        final responseData = response.data['data'] as List<dynamic>? ?? [];
        final fetchedStores =
            responseData.map((e) => StoreModel.fromJson(e)).toList();

        print("📦 Fetched stores count: ${fetchedStores.length}");

        if (currentPage == 1) {
          stores = fetchedStores;
          print("🔁 Replaced stores list with new data");
        } else {
          stores.addAll(fetchedStores);
          print("➕ Added more stores. Total now: ${stores.length}");
        }

        emit(GetStoresSuccess(stores));
        print("🚀 Emitted GetStoresSuccess with ${stores.length} stores");

        currentPage++;
      } else {
        print("❌ API call failed: ${response.data}");
        emit(AddStoreFailure("API call failed"));
      }
    } catch (e) {
      if (isClosed) return;
      print("💥 Error in getAllStores: $e");
      AppToast.error("Error: ${e.toString()}");
      emit(AddStoreFailure(e.toString()));
    } finally {
      actionFromScreen?.call();
      isLoadingMore = false;
      print("✅ Finished getAllStores cycle");
    }
  }

  Future<void> getAllStoresForUser({int? id}) async {
    try {
      emit(AddStoreLoading());
      final response = await DioHelper.get('user/stores', parameter: {
        if (id != null) 'discount_card_id': id,
      });
      if (isClosed) return;
      if (response.isSuccess) {
        final List<StoreModel> fetchedStores = List<StoreModel>.from(
            (response.data?['data'] ?? []).map((e) => StoreModel.fromJson(e)));
        stores.clear();
        stores.addAll(fetchedStores);
        emit(GetStoresSuccess(stores));
      }
    } catch (e) {
      if (isClosed) return;
      log("the error cause ${e.toString()}");
      emit(AddStoreFailure("the error cause ${e.toString()}"));
    }
  }

  Future<void> getAllStoresForUserWithFilterSearch(searchText) async {
    try {
      emit(AddStoreLoading());
      final response = await DioHelper.get('user/stores?search=$searchText');
      // ?search=$searchText&city_id=${CachHelper.cityId}');
      if (isClosed) return;
      if (response.isSuccess) {
        final List<StoreModel> fetchedStores = List<StoreModel>.from(
            (response.data?['data'] ?? []).map((e) => StoreModel.fromJson(e)));
        stores.clear();
        stores.addAll(fetchedStores);
        emit(GetStoresSuccess(stores));
      }
    } catch (e) {
      if (isClosed) return;
      log("the error cause ${e.toString()}");
      emit(AddStoreFailure("the error cause ${e.toString()}"));
    }
  }

  Future<void> getAllStoresForUserWithFilterCategory(
      int? selectedCategoryId,
      int? subcategory_id,
      int? selectedCountryId,
      int? selectedCityId,
      String? search,
      int? duscountID) async {
    try {
      emit(AddStoreLoading());

      // Query parameters handle karna
      final queryParams = <String, dynamic>{};

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (selectedCategoryId != null) {
        queryParams['category_id'] = selectedCategoryId.toString();
      }
      if (subcategory_id != null) {
        queryParams['subcategory_id'] = subcategory_id.toString();
      }
      if (selectedCityId != null) {
        queryParams['city_id'] = selectedCityId.toString();
      }
      if (selectedCountryId != null) {
        queryParams['country_id'] = selectedCountryId.toString();
      }

      if (duscountID != null) {
        queryParams['discount_card_id'] = duscountID.toString();
      }

      final response = await DioHelper.get(
        "user/stores",
        parameter: queryParams.isNotEmpty ? queryParams : null,
      );

      if (isClosed) return;

      if (response.isSuccess) {
        final List<StoreModel> fetchedStores = List<StoreModel>.from(
            (response.data?['data'] ?? []).map((e) => StoreModel.fromJson(e)));

        stores
          ..clear()
          ..addAll(fetchedStores);

        emit(GetStoresSuccess(stores));
      }
    } catch (e) {
      if (isClosed) return;
      log("the error cause ${e.toString()}");
      emit(AddStoreFailure("the error cause ${e.toString()}"));
    }
  }

  Future<void> getStoreDetails(storeId) async {
    try {
      emit(AddStoreLoading());
      final response = await DioHelper.get("shopowner/store-details/$storeId");
      if (isClosed) return;
      if (response.isSuccess) {
        final responseData = response.data['data'];
        if (responseData is Map<String, dynamic>) {
          final workingTimes = responseData['working_times'];
          if (workingTimes is List) {
            setWorkingTimesFromServer(workingTimes);
          } else {
            log('Unexpected working_times format: \$workingTimes');
          }
        } else {
          log('Unexpected data format: \$responseData');
        }
        final List<StoreModel> fetchedStores = List<StoreModel>.from(
            (responseData['stores'] ?? [])
                .map((e) => StoreModel.fromJson(e as Map<String, dynamic>)));
        emit(GetStoresSuccess(fetchedStores));
      }
    } catch (e) {
      log("the error cause ${e.toString()}");
      emit(AddStoreFailure("the error cause ${e.toString()}"));
    }
  }

  Future<void> deleteStore(int storeId) async {
    emit(AddStoreLoading());
    final response = await DioHelper.delete("shopowner/delete-shop/$storeId");
    if (response.isSuccess) {
      AppToast.success("toasts.deleteSuccess");
      emit(AddStoreSuccess());
      AppNavigator.replace(const NavShopOwnerView());
    } else {
      AppToast.error("failure.unexpected_error".tr());
      emit(AddStoreInitial());
    }
  }

  Future<void> editStoreDetails(
    int? cityId,
    int? countryId,
    profileImage,
    String? selectedValue,
    int storeId,
  ) async {
    emit(AddStoreLoading());

    final data = {
      if (englishName.text.isNotEmpty) "name[en]": englishName.text,
      if (arabicName.text.isNotEmpty) "name[ar]": arabicName.text,
      if (englishDisc.text.isNotEmpty) "description[en]": englishDisc.text,
      if (arabicDisc.text.isNotEmpty) "description[ar]": arabicDisc.text,
      if (address.text.isNotEmpty) "address": address.text,
      if (phoneNumber.text.isNotEmpty) "phone": phoneNumber.text,
      "latitude": 24.7136,
      "longitude": 46.6753,
      if (selectedDate != null) "subscription_end_date": selectedDate,
      if (countryId != null) "country_id": countryId,
      if (cityId != null) "city_id": cityId,
      if (selectedCategoryId != null && selectedSubCategory != null)
        "category_id[]": [selectedCategoryId, selectedSubCat],
      if (profileImage != null)
        "image": MultipartFile.fromFileSync(profileImage!.path),
      if (selectedValue != null) 'dial_code': selectedValue,
      for (int i = 0; i < days.length; i++) ...{
        if (dayStates[days[i]]!) ...{
          'working_times[$i][is_working_day]': 1,
          'working_times[$i][opening_time]': startTimes[days[i]] == 'Start time'
              ? serverStartTimes[days[i]]
              : startTimes[days[i]],
          'working_times[$i][closing_time]': endTimes[days[i]] == 'End time'
              ? serverEndTimes[days[i]]
              : endTimes[days[i]],
        } else ...{
          "working_times[$i][is_working_day]": 0,
          "working_times[$i][opening_time]": "08:45",
          "working_times[$i][closing_time]": "19:20",
        }
      }
    };

    print("Sending data: $data");

    final response = await DioHelper.send(
      "shopowner/update-shop/$storeId?_method=put",
      data: data,
    );

    if (response.isSuccess) {
      AppToast.success("toasts.editSuccessStore");
      emit(AddStoreSuccess());
      AppNavigator.replace(const NavShopOwnerView());
    } else {
      final error = ServerFailure.fromResponse(response);
      print("Response Error: ${response.error}");
      if (error.error.isEmpty) {
        String errMsg = "failure.unexpected_error".tr();
        AppToast.error(errMsg);
      } else if ([
        'general',
        'phone',
        'dial_code',
        'latitude',
        'longitude',
        'subscription_end_date',
        'category_id',
        'country_id',
        'city_id'
      ].contains(error.error[0].field)) {
        AppToast.error(error.error[0].message ?? "");
      }
      emit(AddStoreInitial());
    }
  }

  List<String> listOfSubscriptionsDates = ['1-year', '2-year', '3-year'];
  Future<void> addStore(int cityId, int countryId, profileImage,
      String selectedValue, LatLng? location) async {
    emit(AddStoreLoading());
    print('ADD_SHOP:${ADD_SHOP}');
    final List<Map<String, dynamic>> workingTimesPayload = [];

    for (int i = 0; i < days.length; i++) {
      final day = days[i];
      final isWorking = dayStates[day] ?? false;

      workingTimesPayload.add({
        "day_of_week": i,
        "is_working_day": isWorking ? 1 : 0, // send 1 or 0 as API expects
        "opening_time": isWorking ? startTimes[day] ?? "" : "",
        "closing_time": isWorking ? endTimes[day] ?? "" : "",
      });
    }

    print("Final workingTimesPayload: $workingTimesPayload");

    print("Final workingTimesPayload: $workingTimesPayload");

    print("Final workingTimesPayload: $workingTimesPayload");

    final response = await DioHelper.send(ADD_SHOP, data: {
      "name[en]": englishName.text,
      "name[ar]": arabicName.text,
      "description[en]": englishDisc.text,
      "description[ar]": arabicDisc.text,
      "address": address.text,
      "phone": phoneNumber.text,
      "latitude": location?.latitude,
      "longitude": location?.longitude,
      "subscription_end_date": selectedDate,
      "country_id": countryId,
      "city_id": cityId,
      "category_id[]": [selectedCategoryId, selectedSubCat],
      "images[]": profileImage != null
          ? MultipartFile.fromFileSync(profileImage!.path)
          : null,
      "dial_code": selectedValue,
      "working_times": workingTimesPayload,
    });
    print("location this : $workingTimesPayload");
    if (response.isSuccess) {
      AppToast.success("toasts.addStoreSuccess");
      emit(AddStoreSuccess());
      AppNavigator.replace(const NavShopOwnerView());
    } else {
      final error = ServerFailure.fromResponse(response);

      if (error.error.isEmpty) {
        String errMsg = "failure.unexpected_error".tr();
        AppToast.error(errMsg);
      } else if ([
        'general',
        'phone',
        'images',
        'dial_code',
        'latitude',
        'longitude',
        'subscription_end_date',
        'category_id',
        'country_id',
        'city_id'
      ].any((field) => error.error[0].field?.startsWith(field) ?? false)) {
        AppToast.error(error.error[0].message ?? "");
      } else if ([
        "working_times.4.closing_time",
        "working_times.1.closing_time",
        "working_times.2.closing_time",
        "working_times.3.closing_time",
        "working_times.5.closing_time"
      ].contains(error.error[0].field)) {
        AppToast.error("يجب ان يكون مواعيد غلق المتجر بعد مواعيد فتح المتجر");
      } else {
        AppToast.error(error.error[0].message ?? "");
      }
      emit(AddStoreInitial());
    }
  }

  Future<void> getAllCommentsForStore(int storeId) async {
    try {
      emit(AddStoreLoading());
      // if(isClosed){return;}
      final response = await DioHelper.get("rating/store-rating/$storeId");
      if (response.isSuccess) {
        final List<CommentsModel> list = List<CommentsModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => CommentsModel.fromJson(e)));
        comments.clear();
        comments.addAll(list);
        emit(GetStoresCommentsSuccess(list));
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
      emit(AddStoreInitial());
    }
  }

  Future<void> getCategoriesFlter() async {
    try {
      final response = await DioHelper.get(CATEGORIES);
      if (response.isSuccess) {
        final List<CategoryModel> list = List<CategoryModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => CategoryModel.fromJson(e)));
        categoryModel.clear();
        categoryModel.addAll(list);
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
    }
  }

  void changeSubCategoryfilter(String? value, int subCategoryId) {
    selectedSubCategory = value;
    if (!selectedSubCategoryIds.contains(subCategoryId)) {
      selectedSubCat = subCategoryId;
      selectedSubCategoryIds.add(subCategoryId);
    }
  }

  void clearCategorySelectionfilter() {
    selectedCategoryId = null;
    selectedSubCat = null;
    categoryModel.clear();
    selectedSubCategory = null;
    subModel.clear();
  }

  void changeCategoryFilters(
    int? id,
  ) async {
    selectedCategoryId = id;
    if (id != null) {
      final selectedCategory = categoryModel.firstWhere(
        (category) => category.id == id,
        orElse: () => CategoryModel(),
      );
      subModel = selectedCategory.children ?? [];
    } else {
      subModel.clear();
    }
  }

  Future<void> getCategoriesfilter() async {
    try {
      final response = await DioHelper.get(CATEGORIES);
      if (response.isSuccess) {
        final List<CategoryModel> list = List<CategoryModel>.from(
            (response.data?['data'] ?? [])
                .map((e) => CategoryModel.fromJson(e)));
        categoryModel.clear();
        categoryModel.addAll(list);
      }
    } catch (e) {
      AppToast.error("the error cause ${e.toString()}");
    }
  }

  void clear() {
    arabicDisc.clear();
    arabicName.clear();
    englishDisc.clear();
    englishName.clear();
  }
}
