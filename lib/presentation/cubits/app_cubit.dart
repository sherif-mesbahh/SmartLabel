import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_dio.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_endpoints.dart';
import 'package:smart_label_software_engineering/models/banners_model/banners_model.dart';
import 'package:smart_label_software_engineering/models/category_model/category_model.dart';
import 'package:smart_label_software_engineering/models/category_products_model/category_products_model.dart';
import 'package:smart_label_software_engineering/models/category_search_model/category_search_model.dart';
import 'package:smart_label_software_engineering/models/fav_model/fav_model.dart';
import 'package:smart_label_software_engineering/models/fav_search_model/fav_search_model.dart';
import 'package:smart_label_software_engineering/models/product_details_model/product_details_model.dart';
import 'package:smart_label_software_engineering/models/product_model/prodcut_model.dart';
import 'package:smart_label_software_engineering/models/product_search_model/product_search_model.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/pages/categories_page.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/pages/fav_page.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/pages/products_page.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/pages/profile_page.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    ProductsPage(),
    CategoriesPage(),
    FavPage(),
    ProfilePage(),
  ];
  int navBarCurrentIndex = 0;
  void changeNavBarCurrentIndex({
    required int index,
  }) {
    navBarCurrentIndex = index;
    emit(ChangeNavBarCurrentIndexState());

    if (index == 1) getCategories();
    if (index == 2) getFav();
  }

  ProdcutModel? productModel;
  Future<void> getProducts() async {
    emit(GetProductsLoadingState());

    try {
      final response = await ApiService().get(ApiEndpoints.product);

      if (response.statusCode == 200) {
        productModel = ProdcutModel.fromJson(response.data);
        emit(GetProductsSuccessState());
      } else {
        emit(GetProductsErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetProductsErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  CategoryModel? categoryModel;
  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());

    try {
      final response = await ApiService().get(ApiEndpoints.category);

      if (response.statusCode == 200) {
        categoryModel = CategoryModel.fromJson(response.data);
        emit(GetCategoriesSuccessState());
      } else {
        emit(GetCategoriesErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetCategoriesErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  BannersModel? bannersModel;
  Future<void> getBanners() async {
    emit(GetBannersLoadingState());

    try {
      final response = await ApiService().get(ApiEndpoints.banner);
      if (response.statusCode == 200) {
        bannersModel = BannersModel.fromJson(response.data);
        emit(GetBannersSuccessState());
      } else {
        emit(
            GetBannersErrorState('Failed with status: ${response.statusCode}'));
      }
    } catch (e) {
      emit(GetBannersErrorState(e.toString()));
    }
  }

  FavModel? favModel;
  Future<void> getFav() async {
    emit(GetFavProductsLoadingState());

    try {
      final response = await ApiService().get(ApiEndpoints.favProduct);
      if (response.statusCode == 200) {
        favModel = FavModel.fromJson(response.data);
        emit(GetFavProductsSuccessState());
      } else {
        emit(GetFavProductsErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetFavProductsErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  CategoryProductsModel? categoryProductsModel;
  Future<void> getCategoryProducts({required int id}) async {
    emit(GetCategoryProductsLoadingState());

    try {
      final response = await ApiService().get(ApiEndpoints.categoryById(id));
      if (response.statusCode == 200) {
        categoryProductsModel = CategoryProductsModel.fromJson(response.data);
        emit(GetCategoryProductsSuccessState());
      } else {
        emit(GetCategoryProductsErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetCategoryProductsErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  ProductDetailsModel? productDetailsModel;
  Future<void> getProductDetails({required int id}) async {
    emit(GetProductDetailsLoadingState());

    try {
      final response = await ApiService().get(ApiEndpoints.productById(id));
      if (response.statusCode == 200) {
        productDetailsModel = ProductDetailsModel.fromJson(response.data);
        emit(GetProductDetailsSuccessState());
      } else {
        emit(GetProductDetailsErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetProductDetailsErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  ProductSearchModel? productSearchModel;
  Future<void> getProductSearch({required String name}) async {
    emit(GetProductSearchLoadingState());

    try {
      final response = await ApiService()
          .get(ApiEndpoints.productSearch, queryParams: {'Search': name});
      if (response.statusCode == 200) {
        productSearchModel = ProductSearchModel.fromJson(response.data);
        emit(GetProductSearchSuccessState());
      } else {
        emit(GetProductSearchErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetProductSearchErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  CategorySearchModel? categorySearchModel;
  Future<void> getCategorySearch({required String name}) async {
    emit(GetCategorySearchLoadingState());

    try {
      final response = await ApiService()
          .get(ApiEndpoints.categorySearch, queryParams: {'Search': name});
      if (response.statusCode == 200) {
        categorySearchModel = CategorySearchModel.fromJson(response.data);
        emit(GetCategorySearchSuccessState());
      } else {
        emit(GetCategorySearchErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetCategorySearchErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  FavSearchModel? favSearchModel;
  Future<void> getFavSearch({required String name}) async {
    emit(GetFavSearchLoadingState());

    try {
      final response = await ApiService()
          .get(ApiEndpoints.favSearch, queryParams: {'Search': name});
      if (response.statusCode == 200) {
        favSearchModel = FavSearchModel.fromJson(response.data);
        emit(GetFavSearchSuccessState());
      } else {
        emit(GetFavSearchErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetFavSearchErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }
}
