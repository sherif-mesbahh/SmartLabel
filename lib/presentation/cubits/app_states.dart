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
