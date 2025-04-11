abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeNavBarCurrentIndexState extends AppStates {}

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
