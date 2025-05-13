abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeNavBarCurrentIndexState extends AppStates {}

class ChangeSuffixEyeState extends AppStates {}

class GetProductsLoadingState extends AppStates {}

class GetProductsSuccessState extends AppStates {}

class GetProductsErrorState extends AppStates {
  String error;

  GetProductsErrorState(this.error);
}

class GetCategoriesLoadingState extends AppStates {}

class GetCategoriesSuccessState extends AppStates {}

class GetCategoriesErrorState extends AppStates {
  String error;

  GetCategoriesErrorState(this.error);
}

class GetBannersLoadingState extends AppStates {}

class GetBannersSuccessState extends AppStates {}

class GetBannersErrorState extends AppStates {
  String error;

  GetBannersErrorState(this.error);
}

class GetFavProductsLoadingState extends AppStates {}

class GetFavProductsSuccessState extends AppStates {}

class GetFavProductsErrorState extends AppStates {
  String error;

  GetFavProductsErrorState(this.error);
}

class GetCategoryProductsLoadingState extends AppStates {}

class GetCategoryProductsSuccessState extends AppStates {}

class GetCategoryProductsErrorState extends AppStates {
  String error;

  GetCategoryProductsErrorState(this.error);
}

class GetProductDetailsLoadingState extends AppStates {}

class GetProductDetailsSuccessState extends AppStates {}

class GetProductDetailsErrorState extends AppStates {
  String error;

  GetProductDetailsErrorState(this.error);
}

class GetProductSearchLoadingState extends AppStates {}

class GetProductSearchSuccessState extends AppStates {}

class GetProductSearchErrorState extends AppStates {
  String error;

  GetProductSearchErrorState(this.error);
}

class GetCategorySearchLoadingState extends AppStates {}

class GetCategorySearchSuccessState extends AppStates {}

class GetCategorySearchErrorState extends AppStates {
  String error;

  GetCategorySearchErrorState(this.error);
}

class GetActiveBannersLoadingState extends AppStates {}

class GetActiveBannersSuccessState extends AppStates {}

class GetActiveBannersErrorState extends AppStates {
  String error;

  GetActiveBannersErrorState(this.error);
}

class GetActiveBannerDetailsLoadingState extends AppStates {}

class GetActiveBannerDetailsSuccessState extends AppStates {}

class GetActiveBannerDetailsErrorState extends AppStates {
  String error;

  GetActiveBannerDetailsErrorState(this.error);
}

class RegisterLoadingState extends AppStates {}

class RegisterSuccessState extends AppStates {}

class RegisterErrorState extends AppStates {
  String error;

  RegisterErrorState(this.error);
}

class LoginLoadingState extends AppStates {}

class LoginSuccessState extends AppStates {}

class LoginErrorState extends AppStates {
  String error;

  LoginErrorState(this.error);
}

class RefreshTokenLoadingState extends AppStates {}

class RefreshTokenSuccessState extends AppStates {}

class RefreshTokenErrorState extends AppStates {
  String error;

  RefreshTokenErrorState(this.error);
}

class CheckLoginStatusState extends AppStates {}

class AddToFavLoadingState extends AppStates {}

class AddToFavSuccessState extends AppStates {}

class AddToFavErrorState extends AppStates {
  String error;

  AddToFavErrorState(this.error);
}

class RemoveFromFavLoadingState extends AppStates {}

class RemoveFromFavSuccessState extends AppStates {}

class RemoveFromFavErrorState extends AppStates {
  String error;

  RemoveFromFavErrorState(this.error);
}

class GetUserInfoLoadingState extends AppStates {}

class GetUserInfoSuccessState extends AppStates {}

class GetUserInfoErrorState extends AppStates {
  String error;

  GetUserInfoErrorState(this.error);
}

class DeleteBannerLoadingState extends AppStates {}

class DeleteBannerSuccessState extends AppStates {}

class DeleteBannerErrorState extends AppStates {
  String error;

  DeleteBannerErrorState(this.error);
}

class AddBannerLoadingState extends AppStates {}

class AddBannerSuccessState extends AppStates {}

class AddBannerErrorState extends AppStates {
  String error;

  AddBannerErrorState(this.error);
}

class GetBannerDetailsLoadingState extends AppStates {}

class GetBannerDetailsSuccessState extends AppStates {}

class GetBannerDetailsErrorState extends AppStates {
  String error;

  GetBannerDetailsErrorState(this.error);
}

class AppUpdateState extends AppStates {}

class UpdateBannerLoadingState extends AppStates {}

class UpdateBannerSuccessState extends AppStates {}

class UpdateBannerErrorState extends AppStates {
  String error;

  UpdateBannerErrorState(this.error);
}

class DeleteCategoryLoadingState extends AppStates {}

class DeleteCategorySuccessState extends AppStates {}

class DeleteCategoryErrorState extends AppStates {
  String error;

  DeleteCategoryErrorState(this.error);
}

class AddCategoryLoadingState extends AppStates {}

class AddCategorySuccessState extends AppStates {}

class AddCategoryErrorState extends AppStates {
  String error;

  AddCategoryErrorState(this.error);
}

class UpdateCategoryLoadingState extends AppStates {}

class UpdateCategorySuccessState extends AppStates {}

class UpdateCategoryErrorState extends AppStates {
  String error;

  UpdateCategoryErrorState(this.error);
}

class DeleteProductLoadingState extends AppStates {}

class DeleteProductSuccessState extends AppStates {}

class DeleteProductErrorState extends AppStates {
  String error;

  DeleteProductErrorState(this.error);
}

class AddProductLoadingState extends AppStates {}

class AddProductSuccessState extends AppStates {}

class AddProductErrorState extends AppStates {
  String error;

  AddProductErrorState(this.error);
}

class UpdateProductLoadingState extends AppStates {}

class UpdateProductSuccessState extends AppStates {}

class UpdateProductErrorState extends AppStates {
  String error;

  UpdateProductErrorState(this.error);
}

class UpdateProfileLoadingState extends AppStates {}

class UpdateProfileSuccessState extends AppStates {}

class UpdateProfileErrorState extends AppStates {
  String error;

  UpdateProfileErrorState(this.error);
}

class ChangePasswordLoadingState extends AppStates {}

class ChangePasswordSuccessState extends AppStates {}

class ChangePasswordErrorState extends AppStates {
  String error;

  ChangePasswordErrorState(this.error);
}

class DeleteAccountLoadingState extends AppStates {}

class DeleteAccountSuccessState extends AppStates {}

class DeleteAccountErrorState extends AppStates {
  String error;

  DeleteAccountErrorState(this.error);
}

class MakeAdminLoadingState extends AppStates {}

class MakeAdminSuccessState extends AppStates {}

class MakeAdminErrorState extends AppStates {
  String error;

  MakeAdminErrorState(this.error);
}

class DeleteAdminLoadingState extends AppStates {}

class DeleteAdminSuccessState extends AppStates {}

class DeleteAdminErrorState extends AppStates {
  String error;

  DeleteAdminErrorState(this.error);
}

class ForgotPasswordSendCodeLoadingState extends AppStates {}

class ForgotPasswordSendCodeSuccessState extends AppStates {}

class ForgotPasswordSendCodeErrorState extends AppStates {
  String error;

  ForgotPasswordSendCodeErrorState(this.error);
}

class ForgotPasswordVerifyCodeLoadingState extends AppStates {}

class ForgotPasswordVerifyCodeSuccessState extends AppStates {}

class ForgotPasswordVerifyCodeErrorState extends AppStates {
  String error;

  ForgotPasswordVerifyCodeErrorState(this.error);
}

class ForgotPasswordChangePasswordLoadingState extends AppStates {}

class ForgotPasswordChangePasswordSuccessState extends AppStates {}

class ForgotPasswordChangePasswordErrorState extends AppStates {
  String error;

  ForgotPasswordChangePasswordErrorState(this.error);
}

class ChangeThemeState extends AppStates {}

class ChangeLanguageState extends AppStates {}

class ReceiveNotificationState extends AppStates {}

class GetNotificationsLoadingState extends AppStates {}

class GetNotificationsSuccessState extends AppStates {}

class GetNotificationsErrorState extends AppStates {
  String error;

  GetNotificationsErrorState(this.error);
}

class GetNotificationDetailsLoadingState extends AppStates {}

class GetNotificationDetailsSuccessState extends AppStates {}

class GetNotificationDetailsErrorState extends AppStates {
  String error;

  GetNotificationDetailsErrorState(this.error);
}
