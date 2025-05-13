import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_dio.dart';
import 'package:smart_label_software_engineering/core/services/api_services/api_endpoints.dart';
import 'package:smart_label_software_engineering/core/utils/flutter_local_notifications.dart';
import 'package:smart_label_software_engineering/core/utils/secure_token_storage_helper.dart';
import 'package:smart_label_software_engineering/core/utils/shared_preferences.dart';
import 'package:smart_label_software_engineering/models/acitve_banners_model/acitve_banners_model.dart';
import 'package:smart_label_software_engineering/models/active_banner_details_model/active_banner_details_model.dart';
import 'package:smart_label_software_engineering/models/banner_details_model/banner_details_model.dart';
import 'package:smart_label_software_engineering/models/banners_model/banners_model.dart';
import 'package:smart_label_software_engineering/models/category_model/category_model.dart';
import 'package:smart_label_software_engineering/models/category_products_model/category_products_model.dart';
import 'package:smart_label_software_engineering/models/category_search_model/category_search_model.dart';
import 'package:smart_label_software_engineering/models/fav_model/fav_model.dart';
import 'package:smart_label_software_engineering/models/login_model/login_model.dart';
import 'package:smart_label_software_engineering/models/notification_details_model/notification_details_model.dart';
import 'package:smart_label_software_engineering/models/notifications_model/notifications_model.dart';
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
    activeBannerDetailsModel = null; // Clear old banner data

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
    productDetailsModel = null; // Clear old product data

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
  Future<void> getProductSearch({
    required String name,
    required String sortType,
    required String orderType,
  }) async {
    emit(GetProductSearchLoadingState());

    try {
      final response =
          await ApiService().get(ApiEndpoints.productSearch, queryParams: {
        'Search': name,
        'SortColumn': sortType,
        'SortOrder': orderType,
      });
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
  Future<void> getCategorySearch({
    required String name,
    required String sortType,
    required String orderType,
  }) async {
    emit(GetCategorySearchLoadingState());

    try {
      final response =
          await ApiService().get(ApiEndpoints.categorySearch, queryParams: {
        'Search': name,
        'SortColumn': sortType,
        'SortOrder': orderType,
      });
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
        startSignalR();

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
      final parsedStartDate = DateTime.parse(startDate);
      final parsedEndDate = DateTime.parse(endDate);

      final formatedStartDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", 'en')
          .format(parsedStartDate);
      final formatedEndDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", 'en')
          .format(parsedEndDate);

      final formData = FormData.fromMap({
        'Title': title,
        'Description': description,
        'StartDate': formatedStartDate,
        'EndDate': formatedEndDate,
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
        print(formData.fields);
        log("${formData.fields}");
      } else {
        emit(AddBannerErrorState('Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        final response = e.response;
        if (response != null && response.statusCode == 422) {
          final errors = response.data['errors'];
          final errorMessage = (errors as List).join('\n');
          emit(AddBannerErrorState(errorMessage));
          log('Validation errors: $errorMessage');
        } else {
          emit(AddBannerErrorState(e.message ?? 'Unknown error'));
          log('Dio error: ${e.message}');
        }
      } else {
        emit(AddBannerErrorState(e.toString()));
        log('Non-Dio error: ${e.toString()}');
      }
    }
  }

  BannerDetailsModel? bannerDetailsModel;
  Future<void> getBannerDetails({required int id}) async {
    emit(GetBannerDetailsLoadingState());

    try {
      final response = await ApiService().get(ApiEndpoints.bannerById(id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        bannerDetailsModel = BannerDetailsModel.fromJson(response.data);
        print(bannerDetailsModel?.data?.title);
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

  Future<File> getFileFromServer(String imageUrl) async {
    final dir = await getTemporaryDirectory();

    // Extract *raw* filename from URL (already encoded)
    final encodedFilename = Uri.parse(imageUrl).pathSegments.last;
    final decodedFilename =
        Uri.decodeComponent(encodedFilename); // "images (6).jpg"
    final safeFilePath = '${dir.path}/$decodedFilename';

    final file = File(safeFilePath);

    print("Downloading from: $imageUrl");
    print("Saving to: $safeFilePath");

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
      final parsedStartDate = DateTime.parse(startDate);
      final parsedEndDate = DateTime.parse(endDate);

      final formatedStartDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", 'en')
          .format(parsedStartDate);
      final formatedEndDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", 'en')
          .format(parsedEndDate);

      String? mainImagePath;

      if (mainImage != null) {
        mainImagePath = mainImage.path;
      } else {
        mainImagePath = null;
      }
      final formData = FormData.fromMap({
        'Id': id,
        'Title': title,
        'Description': description,
        'StartDate': formatedStartDate,
        'EndDate': formatedEndDate,
        'MainImage': mainImagePath != null
            ? await MultipartFile.fromFile(mainImagePath)
            : null,
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
      if (e is DioException) {
        final response = e.response;
        if (response != null && response.statusCode == 422) {
          final errors = response.data['errors'];
          final errorMessage = (errors as List).join('\n');
          emit(UpdateBannerErrorState(errorMessage));
          log('Validation errors: $errorMessage');
        } else {
          emit(UpdateBannerErrorState(e.message ?? 'Unknown error'));
          log('Dio error: ${e.message}');
        }
      } else {
        emit(UpdateBannerErrorState(e.toString()));
        log('Non-Dio error: ${e.toString()}');
      }
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
      if (e is DioException) {
        final response = e.response;
        if (response != null && response.statusCode == 422) {
          final errors = response.data['errors'];
          final errorMessage = (errors as List).join('\n');
          emit(AddCategoryErrorState(errorMessage));
          log('Validation errors: $errorMessage');
        } else {
          emit(AddCategoryErrorState(e.message ?? 'Unknown error'));
          log('Dio error: ${e.message}');
        }
      } else {
        emit(AddCategoryErrorState(e.toString()));
        log('Non-Dio error: ${e.toString()}');
      }
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
      String? categoryImagePath;
      if (categoryImage != null) {
        categoryImagePath = categoryImage.path;
      } else {
        categoryImagePath = null;
      }

      final formData = FormData.fromMap({
        'Id': id,
        'Name': name,
        'Image': categoryImagePath != null
            ? await MultipartFile.fromFile(categoryImagePath)
            : null,
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
      if (e is DioException) {
        final response = e.response;
        if (response != null && response.statusCode == 422) {
          final errors = response.data['errors'];
          final errorMessage = (errors as List).join('\n');
          emit(UpdateCategoryErrorState(errorMessage));
          log('Validation errors: $errorMessage');
        } else {
          emit(UpdateCategoryErrorState(e.message ?? 'Unknown error'));
          log('Dio error: ${e.message}');
        }
      } else {
        emit(UpdateCategoryErrorState(e.toString()));
        log('Non-Dio error: ${e.toString()}');
      }
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
      if (e is DioException) {
        final response = e.response;
        if (response != null && response.statusCode == 422) {
          // Extract and join validation errors from the backend response
          final errors = response.data['errors'];
          final errorMessage = (errors as List).join('\n');
          emit(AddProductErrorState(
              errorMessage)); // Emit all errors to the state
          log('Validation errors: $errorMessage');
        } else {
          // Handle general errors if status is not 422
          emit(AddProductErrorState(e.message ?? 'Unknown error'));
          log('Dio error: ${e.message}');
        }
      } else {
        // Catch non-Dio errors (e.g., parsing issues)
        emit(AddProductErrorState(e.toString()));
        log('Non-Dio error: ${e.toString()}');
      }
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
        print("Using new main image: $mainImagePath");
      } else {
        mainImagePath = null;
      }

      final formData = FormData.fromMap({
        'Id': productId,
        'CatId': categoryId,
        'Name': name,
        'Description': description,
        'OldPrice': price_,
        'Discount': discount_,
        'MainImage': mainImagePath != null
            ? await MultipartFile.fromFile(mainImagePath)
            : null,
        'ImagesFiles': imageFiles != []
            ? [
                for (var image in imageFiles!)
                  await MultipartFile.fromFile(image.path),
              ]
            : [],
        'RemovedImageIds': imagesToDelete != [] ? imagesToDelete : [],
      });
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
        print("else error: ${formData.fields}");
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      if (e is DioException) {
        final response = e.response;
        if (response != null && response.statusCode == 422) {
          final errors = response.data['errors'];
          final errorMessage = (errors as List).join('\n');
          emit(UpdateProductErrorState(errorMessage));
          log('Validation errors: $errorMessage');
        } else {
          emit(UpdateProductErrorState(e.message ?? 'Unknown Dio error'));
          log('Dio error: ${e.message}');
        }
      } else {
        emit(UpdateProductErrorState(e.toString()));
        log('Non-Dio error: ${e.toString()}');
      }
    }
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    emit(UpdateProfileLoadingState());
    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final body = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };
      final response = await ApiService().put(
        ApiEndpoints.updateProfile,
        body,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateProfileSuccessState());
      } else {
        emit(UpdateProfileErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse is Map<String, dynamic>) {
          final errors = errorResponse['errors'];
          if (errors != null && errors is List) {
            final errorMessage = errors.join('\n'); // join all errors
            emit(UpdateProfileErrorState(errorMessage));
          } else {
            emit(UpdateProfileErrorState('Unknown error occurred'));
          }
        } else {
          emit(UpdateProfileErrorState('Unknown error occurred'));
        }
      } else {
        emit(UpdateProfileErrorState(e.toString()));
      }
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoadingState());
    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final body = {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      };
      final response = await ApiService().put(
        ApiEndpoints.changePassword,
        body,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ChangePasswordSuccessState());
      } else {
        emit(ChangePasswordErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse is Map<String, dynamic>) {
          final errors = errorResponse['errors'];
          if (errors != null && errors is List) {
            final errorMessage = errors.join('\n'); // join all errors
            emit(ChangePasswordErrorState(errorMessage));
          } else {
            emit(ChangePasswordErrorState('Unknown error occurred'));
          }
        } else {
          emit(ChangePasswordErrorState('Unknown error occurred'));
        }
      } else {
        emit(ChangePasswordErrorState(e.toString()));
      }
    }
  }

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoadingState());
    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final response = await ApiService().delete(
        ApiEndpoints.deleteAccount,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(DeleteAccountSuccessState());
        await SecureTokenStorage.clearTokens();
        isLogin = false;
      } else {
        emit(DeleteAccountErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse is Map<String, dynamic>) {
          final errors = errorResponse['errors'];
          if (errors != null && errors is List) {
            final errorMessage = errors.join('\n'); // join all errors
            emit(DeleteAccountErrorState(errorMessage));
          } else {
            emit(DeleteAccountErrorState('Unknown error occurred'));
          }
        } else {
          emit(DeleteAccountErrorState('Unknown error occurred'));
        }
      } else {
        emit(DeleteAccountErrorState(e.toString()));
      }
    }
  }

  Future<void> makeAdmin({
    required String email,
  }) async {
    emit(MakeAdminLoadingState());
    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final response = await ApiService().put(
        ApiEndpoints.makeAdmin,
        {
          'email': email,
          'roleName': 'admin',
        },
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(MakeAdminSuccessState());
      } else {
        emit(MakeAdminErrorState('Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse is Map<String, dynamic>) {
          final errors = errorResponse['errors'];
          if (errors != null && errors is List) {
            final errorMessage = errors.join('\n'); // join all errors
            emit(MakeAdminErrorState(errorMessage));
          } else {
            emit(MakeAdminErrorState('Unknown error occurred'));
          }
        } else {
          emit(MakeAdminErrorState('Unknown error occurred'));
        }
      } else {
        emit(MakeAdminErrorState(e.toString()));
      }
    }
  }

  Future<void> deleteAdmin({
    required String email,
  }) async {
    emit(DeleteAdminLoadingState());
    try {
      final accessToken = await SecureTokenStorage.getAccessToken();
      final response = await ApiService().put(
        ApiEndpoints.deleteAdmin,
        {
          'email': email,
          'roleName': 'user',
        },
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(DeleteAdminSuccessState());
      } else {
        emit(DeleteAdminErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse is Map<String, dynamic>) {
          final errors = errorResponse['errors'];
          if (errors != null && errors is List) {
            final errorMessage = errors.join('\n'); // join all errors
            emit(DeleteAdminErrorState(errorMessage));
          } else {
            emit(DeleteAdminErrorState('Unknown error occurred'));
          }
        } else {
          emit(DeleteAdminErrorState('Unknown error occurred'));
        }
      } else {
        emit(DeleteAdminErrorState(e.toString()));
      }
    }
  }

  bool codeSent = false;
  Future<void> forgotPasswordSendCode({
    required String email,
  }) async {
    emit(ForgotPasswordSendCodeLoadingState());
    try {
      final response = await ApiService().post(
        ApiEndpoints.forgotPasswordSendCode,
        {
          'email': email,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        codeSent = true;
        emit(ForgotPasswordSendCodeSuccessState());
      } else {
        emit(ForgotPasswordSendCodeErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse is Map<String, dynamic>) {
          final errors = errorResponse['errors'];
          if (errors != null && errors is List) {
            final errorMessage = errors.join('\n'); // join all errors
            emit(ForgotPasswordSendCodeErrorState(errorMessage));
          } else {
            emit(ForgotPasswordSendCodeErrorState('Unknown error occurred'));
          }
        } else {
          emit(ForgotPasswordSendCodeErrorState('Unknown error occurred'));
        }
      } else {
        emit(ForgotPasswordSendCodeErrorState(e.toString()));
      }
    }
  }

  bool codeVerified = false;
  Future<void> forgotPasswordVerifyCode({
    required String email,
    required String code,
  }) async {
    emit(ForgotPasswordVerifyCodeLoadingState());
    try {
      final response = await ApiService().post(
        ApiEndpoints.forgotPasswordVerifyCode,
        {
          'email': email,
          'code': code,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        codeVerified = true;
        emit(ForgotPasswordVerifyCodeSuccessState());
      } else {
        emit(ForgotPasswordVerifyCodeErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse is Map<String, dynamic>) {
          final errors = errorResponse['errors'];
          if (errors != null && errors is List) {
            final errorMessage = errors.join('\n'); // join all errors
            emit(ForgotPasswordVerifyCodeErrorState(errorMessage));
          } else {
            emit(ForgotPasswordVerifyCodeErrorState('Unknown error occurred'));
          }
        } else {
          emit(ForgotPasswordVerifyCodeErrorState('Unknown error occurred'));
        }
      } else {
        emit(ForgotPasswordVerifyCodeErrorState(e.toString()));
      }
    }
  }

  Future<void> forgotPasswordChangePassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(ForgotPasswordChangePasswordLoadingState());
    try {
      final response = await ApiService().post(
        ApiEndpoints.forgotPasswordChangePassword,
        {
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ForgotPasswordChangePasswordSuccessState());
      } else {
        emit(ForgotPasswordChangePasswordErrorState(
            'Failed with status: ${response.statusCode}'));
      }
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse is Map<String, dynamic>) {
          final errors = errorResponse['errors'];
          if (errors != null && errors is List) {
            final errorMessage = errors.join('\n'); // join all errors
            emit(ForgotPasswordChangePasswordErrorState(errorMessage));
          } else {
            emit(ForgotPasswordChangePasswordErrorState(
                'Unknown error occurred'));
          }
        } else {
          emit(
              ForgotPasswordChangePasswordErrorState('Unknown error occurred'));
        }
      } else {
        emit(ForgotPasswordChangePasswordErrorState(e.toString()));
      }
    }
  }

  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    SharedPrefs.setIsDarkMode(isDark); // Save user preference
    emit(ChangeThemeState());
  }

  Future<void> loadTheme() async {
    final isDark = SharedPrefs.getIsDarkMode();
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Locale appLocale = const Locale('en');

  void toggleLanguage(bool isArabic) {
    appLocale = isArabic ? const Locale('ar') : const Locale('en');
    SharedPrefs.setLanguage(isArabic ? 'ar' : 'en'); // Save user preference
    emit(ChangeLanguageState());
  }

  Future<void> loadLanguage() async {
    final langCode = await SharedPrefs.getLanguage();
    appLocale = Locale(langCode ?? 'en');
  }

  late HubConnection hubConnection;

  void startSignalR() async {
    final serverUrl = ApiEndpoints.notifications;

    hubConnection = HubConnectionBuilder()
        .withUrl(
          serverUrl,
          options: HttpConnectionOptions(
            accessTokenFactory: () async {
              final token = await SecureTokenStorage.getAccessToken();
              return token!;
            },
          ),
        )
        .withAutomaticReconnect()
        .build();

    hubConnection.on("ReceiveNotification", (messege) {
      final body = messege != null && messege.isNotEmpty
          ? messege[0].toString()
          : "You have a new message";
      NotificationHelper.showNotification(body);
      print("📢 Notification: $body");

      emit(ReceiveNotificationState());
    });

    try {
      await hubConnection.start();
      print("✅ SignalR connected.");
    } catch (e) {
      print("❌ SignalR connection failed: $e");
    }
  }

  bool isAdminPanelLoading = false;

  NotificationsModel? notificationsModel;

  Future<void> getNotifications() async {
    emit(GetNotificationsLoadingState());
    try {
      final response = await ApiService().get(ApiEndpoints.getNotifications);
      if (response.statusCode == 200 || response.statusCode == 201) {
        notificationsModel = NotificationsModel.fromJson(response.data);
        emit(GetNotificationsSuccessState());
      } else {
        emit(GetNotificationsErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetNotificationsErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  NotificationDetailsModel? notificationDetailsModel;
  Future<void> getNotificationDetails({required int id}) async {
    notificationDetailsModel = null; // Clear old data

    emit(GetNotificationDetailsLoadingState());
    try {
      final response =
          await ApiService().get(ApiEndpoints.getNotificationById(id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        notificationDetailsModel =
            NotificationDetailsModel.fromJson(response.data);
        emit(GetNotificationDetailsSuccessState());
      } else {
        emit(GetNotificationDetailsErrorState(
            'Failed with status: ${response.statusCode}'));
        log('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      emit(GetNotificationDetailsErrorState(e.toString()));
      log('Failed with status: ${e.toString()}');
    }
  }

  GlobalKey<ScaffoldState>? scaffoldKey;
}
