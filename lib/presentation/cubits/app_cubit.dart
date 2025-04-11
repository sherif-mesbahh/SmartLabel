import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_dio.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_endpoints.dart';
import 'package:smart_label_software_engineering/models/banners_model/banners_model.dart';
import 'package:smart_label_software_engineering/models/category_model/category_model.dart';
import 'package:smart_label_software_engineering/models/category_products_model/category_products_model.dart';
import 'package:smart_label_software_engineering/models/fav_model/fav_model.dart';
import 'package:smart_label_software_engineering/models/product_model/prodcut_model.dart';
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
}
