import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_dio.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_endpoints.dart';
import 'package:smart_label_software_engineering/core/utils/secure_token_storage_helper.dart';
import 'package:smart_label_software_engineering/models/acitve_banners_model/acitve_banners_model.dart';
import 'package:smart_label_software_engineering/models/active_banner_details_model/active_banner_details_model.dart';
import 'package:smart_label_software_engineering/models/banner_details_model/banner_details_model.dart';
import 'package:smart_label_software_engineering/models/banners_model/banners_model.dart';
import 'package:smart_label_software_engineering/models/category_model/category_model.dart';
import 'package:smart_label_software_engineering/models/category_products_model/category_products_model.dart';
import 'package:smart_label_software_engineering/models/category_search_model/category_search_model.dart';
import 'package:smart_label_software_engineering/models/fav_model/fav_model.dart';
import 'package:smart_label_software_engineering/models/login_model/login_model.dart';
import 'package:smart_label_software_engineering/models/product_details_model/product_details_model.dart';
import 'package:smart_label_software_engineering/models/product_model/prodcut_model.dart';
import 'package:smart_label_software_engineering/models/product_search_model/product_search_model.dart';
import 'package:smart_label_software_engineering/models/register_model/register_model.dart';
import 'package:smart_label_software_engineering/models/user_info_model/user_info_model.dart';
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

    if (index == 0) {
      getProducts();
      getActiveBanners();
    }

    if (index == 1) getCategories();
    if (index == 2) {
      if (isLogin) {
        getFav();
      }
    }

    if (index == 3) {
      if (isLogin) {
        getUserInfo();
      }
    }
  }

  IconData signUpPasswordSuffix = Icons.visibility;
  bool signUpIsPasswordObscured = true;

  void changeSignUpPasswordVisibility() {
    signUpIsPasswordObscured = !signUpIsPasswordObscured;
    signUpPasswordSuffix =
        signUpIsPasswordObscured ? Icons.visibility : Icons.visibility_off;
    emit(ChangeSuffixEyeState());
  }

  IconData signUpConfirmPasswordSuffix = Icons.visibility;
  bool signUpIsConfirmPasswordObscured = true;
  void changeSignUpConfirmPasswordVisibility() {
    signUpIsConfirmPasswordObscured = !signUpIsConfirmPasswordObscured;
    signUpConfirmPasswordSuffix = signUpIsConfirmPasswordObscured
        ? Icons.visibility
        : Icons.visibility_off;
    emit(ChangeSuffixEyeState());
  }

  IconData loginPasswordSuffix = Icons.visibility;
  bool loginIsPasswordObscured = true;

  void changeLoginPasswordVisibility() {
    loginIsPasswordObscured = !loginIsPasswordObscured;
    loginPasswordSuffix =
        loginIsPasswordObscured ? Icons.visibility : Icons.visibility_off;
    emit(ChangeSuffixEyeState());
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

  AcitveBannersModel? activeBannersModel;
  Future<void> getActiveBanners() async {
    emit(GetActiveBannersLoadingState());

    try {
      final response = await ApiService().get(ApiEndpoints.activeBanners);
      if (response.statusCode == 200) {
        activeBannersModel = AcitveBannersModel.fromJson(response.data);
        emit(GetActiveBannersSuccessState());
      } else {
        emit(GetActiveBannersErrorState(
            'Failed with status: ${response.statusCode}'));
      }
    } catch (e) {
      emit(GetActiveBannersErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  ActiveBannerDetailsModel? activeBannerDetailsModel;
  Future<void> getActiveBannerDetails({required int id}) async {
    emit(GetActiveBannerDetailsLoadingState());

    try {
      final response =
          await ApiService().get(ApiEndpoints.activeBannerById(id));
      if (response.statusCode == 200) {
        activeBannerDetailsModel =
            ActiveBannerDetailsModel.fromJson(response.data);
        emit(GetActiveBannerDetailsSuccessState());
      } else {
        emit(GetActiveBannerDetailsErrorState(
            'Failed with status: ${response.statusCode}'));
      }
    } catch (e) {
      emit(GetActiveBannerDetailsErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  FavModel? favModel;
  Future<void> getFav() async {
    emit(GetFavProductsLoadingState());

    try {
      final response = await ApiService().get(
        ApiEndpoints.favProduct,
      );
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

  RegisterModel? registerModel;
  Future<void> register({required Map<String, String> data}) async {
    emit(RegisterLoadingState());

    try {
      final response = await ApiService().post(ApiEndpoints.register, data);

      registerModel = RegisterModel.fromJson(response.data);
      emit(RegisterSuccessState());
    } on DioException catch (dioError) {
      String errorMessage = 'Registration failed';

      if (dioError.response != null) {
        final responseData = dioError.response?.data;

        final message = responseData['message'];
        final errors = responseData['errors'];

        errorMessage = errors != null && errors is List && errors.isNotEmpty
            ? errors.join(', ')
            : (message ?? 'Registration failed');
      }

      emit(RegisterErrorState(errorMessage));
      log('Register DioException: $errorMessage');
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
      log('Register unexpected error: $e');
    }
  }

  LoginModel? loginModel;
  Future<void> login({required Map<String, String> data}) async {
    emit(LoginLoadingState());

    try {
      final response = await ApiService().post(ApiEndpoints.login, data);
      loginModel = LoginModel.fromJson(response.data);

      final accessToken = loginModel?.data?.accessToken;
      final refreshToken = loginModel?.data?.refreshToken;

      if (accessToken != null && refreshToken != null) {
        await SecureTokenStorage.saveTokens(accessToken, refreshToken);
        isLogin = true;

        // Call initial data fetch
        getProducts();
        getActiveBanners();

        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState('Invalid login response data.'));
      }
    } on DioException catch (dioError) {
      String errorMessage = 'Login failed';

      if (dioError.response != null) {
        final responseData = dioError.response?.data;
        final message = responseData?['message'];
        final errors = responseData?['errors'];

        errorMessage = (errors is List && errors.isNotEmpty)
            ? errors.join(', ')
            : (message ?? 'Login failed');
      }

      emit(LoginErrorState(errorMessage));
      log('Login DioException: $errorMessage');
    } catch (e) {
      emit(LoginErrorState('Unexpected error: $e'));
      log('Login unexpected error: $e');
    }
  }

  bool isLogin = false;

  Future<void> checkLoginStatus() async {
    final accessToken = await SecureTokenStorage.getAccessToken();
    final refreshToken = await SecureTokenStorage.getRefreshToken();

    isLogin = accessToken != null && refreshToken != null;

    if (isLogin) {
      getUserInfo();
      emit(LoginSuccessState());
    } else {
      getUserInfo();
      emit(LoginErrorState('Not logged in'));
    }
  }

  UserInfoModel? userInfoModel;
  Future<void> getUserInfo() async {
    emit(GetUserInfoLoadingState());
    log('[UserInfo] Started loading...');

    try {
      final response = await ApiService().get(ApiEndpoints.userInfo);
      log('[UserInfo] Response received with status: ${response.statusCode}');

      userInfoModel = UserInfoModel.fromJson(response.data);
      if (response.statusCode == 200) {
        emit(GetUserInfoSuccessState());
      } else {
        emit(GetUserInfoErrorState(
            'Failed with status: ${response.statusCode}'));
        log('[UserInfo] Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetUserInfoErrorState(e.toString()));
      log('[UserInfo] Caught exception: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      final response = await ApiService().post(ApiEndpoints.logout, {});
      log('Logout response with status: ${response.statusCode}');
      await SecureTokenStorage.clearTokens();
      isLogin = false;
      navBarCurrentIndex = 0;
      getProducts();

      emit(CheckLoginStatusState());
    } catch (e) {
      log('Logout caught exception: ${e.toString()}');
    }
  }

  Future<void> addToFav({
    required dynamic model,
  }) async {
    emit(AddToFavLoadingState());

    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final response = await ApiService().post(
          ApiEndpoints.addtoFavById(model.id!), {},
          headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200 || response.statusCode == 201) {
        model.favorite = !(model.favorite ?? false);
        emit(AddToFavSuccessState());
      } else {
        emit(AddToFavErrorState('Failed with status: ${response.statusCode}'));
        log('[AddToFav] Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(AddToFavErrorState(e.toString()));
      log('[AddToFav] Caught exception: ${e.toString()}');
    }
  }

  Future<void> removeFromFav({
    required dynamic model,
  }) async {
    emit(RemoveFromFavLoadingState());

    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final response = await ApiService().delete(
          ApiEndpoints.addtoFavById(model.id!),
          headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200 || response.statusCode == 201) {
        model.favorite = !(model.favorite ?? false);
        emit(RemoveFromFavSuccessState());
      } else {
        emit(RemoveFromFavErrorState(
            'Failed with status: ${response.statusCode}'));
        log('[RemoveFromFav] Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(RemoveFromFavErrorState(e.toString()));
      log('[RemoveFromFav] Caught exception: ${e.toString()}');
    }
  }

  //  the categories and items overflow in products page and categories prodcucts andfavvorite products and products details and search products and banners deatails

  // Admin

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

  Future<void> deleteBanner({required int id}) async {
    emit(DeleteBannerLoadingState());

    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final response = await ApiService().delete(
          ApiEndpoints.deleteBannerById(id),
          headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        getBanners();
        emit(DeleteBannerSuccessState());
      } else {
        emit(DeleteBannerErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(DeleteBannerErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  Future<void> addBanner({
    required String title,
    required String description,
    required String startDate,
    required String endDate,
    required File mainImage,
    required List<XFile> imageFiles,
  }) async {
    emit(AddBannerLoadingState());

    try {
      final accessToken = await SecureTokenStorage.getAccessToken();

      final formData = FormData.fromMap({
        'Title': title,
        'Description': description,
        'StartDate': startDate,
        'EndDate': endDate,
        'MainImage': await MultipartFile.fromFile(mainImage.path),
        'ImagesFiles': [
          for (var image in imageFiles)
            await MultipartFile.fromFile(image.path),
        ],
      });

      final response = await ApiService().post(
        ApiEndpoints.addBanner,
        formData,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'multipart/form-data',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddBannerSuccessState());
      } else {
        emit(AddBannerErrorState('Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(AddBannerErrorState(e.toString()));
      log('Failed with error: ${e.toString()}');
    }
  }

  BannerDetailsModel? bannerDetailsModel;
  Future<void> getBannerDetails({required int id}) async {
    emit(GetBannerDetailsLoadingState());

    try {
      final response = await ApiService().get(ApiEndpoints.bannerById(id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        bannerDetailsModel = BannerDetailsModel.fromJson(response.data);
        emit(GetBannerDetailsSuccessState());
      } else {
        emit(GetBannerDetailsErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetBannerDetailsErrorState(e.toString()));
      log('Failed with error: ${e.toString()}');
    }
  }

  Future<File> getFileFromServer(String fileName) async {
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';
    final file = File(filePath);

    final imageUrl = 'http://smartlabel1.runasp.net/Uploads/$fileName';
    await Dio().download(imageUrl, file.path);
    return file;
  }

  List<XFile> bannerDetailsImagesToUpload = [];
  List<int> bannerDetailsImagesToDelete = [];
  XFile? mainBannerImageToUpload;

  Future<void> updateBanner({
    required int id,
    required String title,
    required String description,
    required String startDate,
    required String endDate,
    List<XFile>? imageFiles,
    List<int>? imagesToDelete,
    XFile? mainImage,
  }) async {
    emit(UpdateBannerLoadingState());

    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final inputFormat = DateFormat('dd MMM yyyy');
      final formData = FormData.fromMap({
        'Id': id,
        'Title': title,
        'Description': description,
        'StartDate': inputFormat.parse(startDate).toIso8601String(),
        'EndDate': inputFormat.parse(endDate).toIso8601String(),
        'MainImage': mainImage != null
            ? await MultipartFile.fromFile(mainImage.path)
            : await MultipartFile.fromFile((await getFileFromServer(
                    bannerDetailsModel?.data!.mainImage ?? ""))
                .path),
        'ImagesFiles': imageFiles != []
            ? [
                for (var image in imageFiles!)
                  await MultipartFile.fromFile(image.path),
              ]
            : [],
        'RemovedImageIds': imagesToDelete != [] ? imagesToDelete : [],
      });
      print(formData.fields);
      log("${formData.fields}");
      final response = await ApiService().put(
        ApiEndpoints.updateBanner,
        formData,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'multipart/form-data',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateBannerSuccessState());
      } else {
        emit(UpdateBannerErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(UpdateBannerErrorState(e.toString()));
      log('Failed with error: ${e.toString()}');
    }
  }

  Future<void> deleteCategory({required int id}) async {
    emit(DeleteCategoryLoadingState());

    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final response = await ApiService().delete(
          ApiEndpoints.deleteCategoryById(id),
          headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        getCategories();
        emit(DeleteCategorySuccessState());
      } else {
        emit(DeleteCategoryErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(DeleteCategoryErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  Future<void> addCategory({
    required String name,
    required File image,
  }) async {
    emit(AddCategoryLoadingState());

    try {
      final accessToken = await SecureTokenStorage.getAccessToken();

      final formData = FormData.fromMap({
        'Name': name,
        'Image': await MultipartFile.fromFile(image.path),
      });

      final response = await ApiService().post(
        ApiEndpoints.addCategory,
        formData,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'multipart/form-data',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddCategorySuccessState());
      } else {
        emit(AddCategoryErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(AddCategoryErrorState(e.toString()));
      log('Failed with error: ${e.toString()}');
    }
  }

  XFile? mainCategoryImageToUpload;
  Future<void> updateCategory({
    required int id,
    required String name,
    XFile? categoryImage,
  }) async {
    emit(UpdateCategoryLoadingState());

    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final formData = FormData.fromMap({
        'Id': id,
        'Name': name,
        'Image': categoryImage != null
            ? await MultipartFile.fromFile(categoryImage.path)
            : await MultipartFile.fromFile((await getFileFromServer(
                    categoryProductsModel?.data!.imageUrl ?? ""))
                .path),
      });
      print(formData.fields);
      log("${formData.fields}");
      final response = await ApiService().put(
        ApiEndpoints.updateCategory,
        formData,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'multipart/form-data',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateCategorySuccessState());
      } else {
        emit(UpdateCategoryErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(UpdateCategoryErrorState(e.toString()));
      log('Failed with error: ${e.toString()}');
    }
  }

  Future<void> deleteProduct({
    required int productId,
    required int cateoryId,
  }) async {
    emit(DeleteProductLoadingState());

    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final response = await ApiService().delete(
          ApiEndpoints.deleteProductById(productId),
          headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200 || response.statusCode == 201) {
        getCategoryProducts(id: cateoryId);
        emit(DeleteProductSuccessState());
      } else {
        emit(DeleteProductErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(DeleteProductErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  Future<void> addProduct({
    required String name,
    required String oldPrice,
    required String discount,
    required String description,
    required int categoryId,
    required File mainImage,
    required List<XFile> imageFiles,
  }) async {
    emit(AddProductLoadingState());

    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      double? oldPrice_ = double.tryParse(oldPrice);
      int? discount_ = int.tryParse(discount);
      final formData = FormData.fromMap({
        'Name': name,
        'OldPrice': oldPrice_,
        'Discount': discount_,
        'Description': description,
        'CatId': categoryId,
        'MainImage': await MultipartFile.fromFile(mainImage.path),
        'ImagesFiles': [
          for (var image in imageFiles)
            await MultipartFile.fromFile(image.path),
        ],
      });

      final response = await ApiService().post(
        ApiEndpoints.addProduct,
        formData,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'multipart/form-data',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AddProductSuccessState());
      } else {
        emit(
            AddProductErrorState('Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(AddProductErrorState(e.toString()));
      log('Failed with error: ${e.toString()}');
    }
  }

  List<XFile> productImagesToUpload = [];
  List<int> productImagesToDelete = [];
  XFile? mainproductImageToUpload;

  Future<void> updateProduct({
    required int productId,
    required int categoryId,
    required String name,
    required String price,
    required String discount,
    required String description,
    List<XFile>? imageFiles,
    List<int>? imagesToDelete,
    XFile? mainImage,
  }) async {
    emit(UpdateProductLoadingState());
    print("Sending update for productId: $productId");
    print("Sending update for CategoryId: $categoryId");

    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      double price_ = double.tryParse(price)!;
      int discount_ = int.tryParse(discount)!;
      String? mainImagePath;
      if (mainImage != null) {
        mainImagePath = mainImage.path;
      } else {
        final serverFile =
            await getFileFromServer(productDetailsModel?.data?.mainImage ?? "");
        if (!File(serverFile.path).existsSync()) {
          emit(UpdateProductErrorState('Fallback main image file not found.'));
          return;
        }
        mainImagePath = serverFile.path;
      }
      final formData = FormData.fromMap({
        'Id': productId,
        'CatId': categoryId,
        'Name': name,
        'Description': description,
        'OldPrice': price_,
        'Discount': discount_,
        'MainImage': await MultipartFile.fromFile(mainImagePath),
        'ImagesFiles': imageFiles != []
            ? [
                for (var image in imageFiles!)
                  await MultipartFile.fromFile(image.path),
              ]
            : [],
        'RemovedImageIds': imagesToDelete != [] ? imagesToDelete : [],
      });
      print("Sending update for productId: $productId");

      print("FormData: ${formData.fields}");
      print("Files: ${formData.files.map((f) => f.key)}");

      final response = await ApiService().put(
        ApiEndpoints.updateProduct,
        formData,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'multipart/form-data',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateProductSuccessState());
      } else {
        emit(UpdateProductErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(UpdateProductErrorState(e.toString()));
      log('Failed withdfdsdfsdf error: ${e.toString()}');
    }
  }
}
