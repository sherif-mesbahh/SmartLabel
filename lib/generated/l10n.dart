// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign In`
  String get signPageSignInButton {
    return Intl.message(
      'Sign In',
      name: 'signPageSignInButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signPageSignUpButton {
    return Intl.message(
      'Sign Up',
      name: 'signPageSignUpButton',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get loginEmailLabel {
    return Intl.message('Email', name: 'loginEmailLabel', desc: '', args: []);
  }

  /// `example@yahoo.com`
  String get loginEmailHint {
    return Intl.message(
      'example@yahoo.com',
      name: 'loginEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get loginEmailValidation {
    return Intl.message(
      'Please enter your email',
      name: 'loginEmailValidation',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPasswordLabel {
    return Intl.message(
      'Password',
      name: 'loginPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPasswordHint {
    return Intl.message(
      'Password',
      name: 'loginPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get loginPasswordValidation {
    return Intl.message(
      'Please enter your password',
      name: 'loginPasswordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInButton {
    return Intl.message('Sign In', name: 'signInButton', desc: '', args: []);
  }

  /// `Go Back`
  String get loginGoBackButton {
    return Intl.message(
      'Go Back',
      name: 'loginGoBackButton',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get loginForgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'loginForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get forgotPasswordEmailLabel {
    return Intl.message(
      'Email',
      name: 'forgotPasswordEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `example@yahoo.com`
  String get forgotPasswordEmailHint {
    return Intl.message(
      'example@yahoo.com',
      name: 'forgotPasswordEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get forgotPasswordEmailValidation {
    return Intl.message(
      'Please enter your email',
      name: 'forgotPasswordEmailValidation',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get forgotPasswordSubmitButton {
    return Intl.message(
      'Submit',
      name: 'forgotPasswordSubmitButton',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get forgotPasswordCodeLabel {
    return Intl.message(
      'Code',
      name: 'forgotPasswordCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your code`
  String get forgotPasswordCodeHint {
    return Intl.message(
      'Enter your code',
      name: 'forgotPasswordCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your code`
  String get forgotPasswordCodeValidation {
    return Intl.message(
      'Please enter your code',
      name: 'forgotPasswordCodeValidation',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get forgotPasswordNewPasswordLabel {
    return Intl.message(
      'New Password',
      name: 'forgotPasswordNewPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get forgotPasswordNewPasswordHint {
    return Intl.message(
      'Enter your new password',
      name: 'forgotPasswordNewPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get forgotPasswordConfirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'forgotPasswordConfirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your confirm password`
  String get forgotPasswordConfirmPasswordHint {
    return Intl.message(
      'Enter your confirm password',
      name: 'forgotPasswordConfirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password`
  String get forgotPasswordNewPasswordValidation {
    return Intl.message(
      'Please enter your new password',
      name: 'forgotPasswordNewPasswordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your confirm password`
  String get forgotPasswordConfirmPasswordValidation {
    return Intl.message(
      'Please enter your confirm password',
      name: 'forgotPasswordConfirmPasswordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get forgotPasswordConfirmPasswordDontMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'forgotPasswordConfirmPasswordDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Must contain an uppercase letter (A-Z)`
  String get passwordValidationUpperCase {
    return Intl.message(
      'Must contain an uppercase letter (A-Z)',
      name: 'passwordValidationUpperCase',
      desc: '',
      args: [],
    );
  }

  /// `Must contain a lowercase letter (a-z)`
  String get passwordValidationLowerCase {
    return Intl.message(
      'Must contain a lowercase letter (a-z)',
      name: 'passwordValidationLowerCase',
      desc: '',
      args: [],
    );
  }

  /// `Must contain a number (0-9)`
  String get passwordValidationNumber {
    return Intl.message(
      'Must contain a number (0-9)',
      name: 'passwordValidationNumber',
      desc: '',
      args: [],
    );
  }

  /// `Must contain a special character (!@#$%^&*)`
  String get passwordValidationSpecialChar {
    return Intl.message(
      'Must contain a special character (!@#\$%^&*)',
      name: 'passwordValidationSpecialChar',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 8 characters long`
  String get passwordValidationMinLength {
    return Intl.message(
      'Must be at least 8 characters long',
      name: 'passwordValidationMinLength',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get signupFirstNameLabel {
    return Intl.message(
      'First Name',
      name: 'signupFirstNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your first name`
  String get signupFirstNameHint {
    return Intl.message(
      'Enter your first name',
      name: 'signupFirstNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get signupLastNameLabel {
    return Intl.message(
      'Last Name',
      name: 'signupLastNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your last name`
  String get signupLastNameHint {
    return Intl.message(
      'Enter your last name',
      name: 'signupLastNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get signupEmailLabel {
    return Intl.message('Email', name: 'signupEmailLabel', desc: '', args: []);
  }

  /// `example@yahoo.com`
  String get signupEmailHint {
    return Intl.message(
      'example@yahoo.com',
      name: 'signupEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get signupPasswordLabel {
    return Intl.message(
      'Password',
      name: 'signupPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get signupPasswordHint {
    return Intl.message(
      'Enter your password',
      name: 'signupPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get signupConfirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'signupConfirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your confirm password`
  String get signupConfirmPasswordHint {
    return Intl.message(
      'Enter your confirm password',
      name: 'signupConfirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your first name`
  String get signupFirstNameValidation {
    return Intl.message(
      'Please enter your first name',
      name: 'signupFirstNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name`
  String get signupLastNameValidation {
    return Intl.message(
      'Please enter your last name',
      name: 'signupLastNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get signupEmailValidation {
    return Intl.message(
      'Please enter your email',
      name: 'signupEmailValidation',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get signupPasswordValidation {
    return Intl.message(
      'Please enter your password',
      name: 'signupPasswordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your confirm password`
  String get signupConfirmPasswordValidation {
    return Intl.message(
      'Please enter your confirm password',
      name: 'signupConfirmPasswordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get signupConfirmPasswordDontMatchValidation {
    return Intl.message(
      'Passwords do not match',
      name: 'signupConfirmPasswordDontMatchValidation',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signupButton {
    return Intl.message('Sign Up', name: 'signupButton', desc: '', args: []);
  }

  /// `Go Back`
  String get signupGoBackButton {
    return Intl.message(
      'Go Back',
      name: 'signupGoBackButton',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get navBarHome {
    return Intl.message('Home', name: 'navBarHome', desc: '', args: []);
  }

  /// `Categories`
  String get navBarCategories {
    return Intl.message(
      'Categories',
      name: 'navBarCategories',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get navBarFav {
    return Intl.message('Favourites', name: 'navBarFav', desc: '', args: []);
  }

  /// `Profile`
  String get navBarProfile {
    return Intl.message('Profile', name: 'navBarProfile', desc: '', args: []);
  }

  /// `New Products`
  String get homePageNewProducts {
    return Intl.message(
      'New Products',
      name: 'homePageNewProducts',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profilePageTitle {
    return Intl.message(
      'Profile',
      name: 'profilePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get profilePageSettings {
    return Intl.message(
      'Settings',
      name: 'profilePageSettings',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get profilePageSignInButton {
    return Intl.message(
      'Sign In',
      name: 'profilePageSignInButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get profilePageSingUpButton {
    return Intl.message(
      'Sign Up',
      name: 'profilePageSingUpButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get profilePageSingOutButton {
    return Intl.message(
      'Sign Out',
      name: 'profilePageSingOutButton',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get profilePageChangePasswordButton {
    return Intl.message(
      'Change Password',
      name: 'profilePageChangePasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get profilePageDeleteAccountButton {
    return Intl.message(
      'Delete Account',
      name: 'profilePageDeleteAccountButton',
      desc: '',
      args: [],
    );
  }

  /// `Admin Panel`
  String get profilePageAdminPanel {
    return Intl.message(
      'Admin Panel',
      name: 'profilePageAdminPanel',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get profilePageEditProfileTitle {
    return Intl.message(
      'Edit Profile',
      name: 'profilePageEditProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get profilePageEditProfileFirstNameLabel {
    return Intl.message(
      'First Name',
      name: 'profilePageEditProfileFirstNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get profilePageEditProfileLastNameLabel {
    return Intl.message(
      'Last Name',
      name: 'profilePageEditProfileLastNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get profilePageUserInfoFirstName {
    return Intl.message(
      'First Name',
      name: 'profilePageUserInfoFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get profilePageUserInfoLastName {
    return Intl.message(
      'Last Name',
      name: 'profilePageUserInfoLastName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get profilePageUserInfoEmail {
    return Intl.message(
      'Email',
      name: 'profilePageUserInfoEmail',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveButton {
    return Intl.message('Save', name: 'saveButton', desc: '', args: []);
  }

  /// `Cancel`
  String get cancelButton {
    return Intl.message('Cancel', name: 'cancelButton', desc: '', args: []);
  }

  /// `Delete`
  String get deleteButton {
    return Intl.message('Delete', name: 'deleteButton', desc: '', args: []);
  }

  /// `Change Password`
  String get profilePageChangePasswordTitle {
    return Intl.message(
      'Change Password',
      name: 'profilePageChangePasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get profilePageChangePasswordCurrentPasswordLabel {
    return Intl.message(
      'Current Password',
      name: 'profilePageChangePasswordCurrentPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get profilePageChangePasswordNewPasswordLabel {
    return Intl.message(
      'New Password',
      name: 'profilePageChangePasswordNewPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get profilePageChangePasswordConfirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'profilePageChangePasswordConfirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get profilePageDeleteAccountTitle {
    return Intl.message(
      'Delete Account',
      name: 'profilePageDeleteAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This action cannot be undone.`
  String get profilePageDeleteAccountText {
    return Intl.message(
      'Are you sure you want to delete your account? This action cannot be undone.',
      name: 'profilePageDeleteAccountText',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get profilePageSideMenuTitle {
    return Intl.message(
      'Settings',
      name: 'profilePageSideMenuTitle',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get profilePageSideMenuDarkMode {
    return Intl.message(
      'Dark Mode',
      name: 'profilePageSideMenuDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get profilePageSideMenuChangeLanguageTitle {
    return Intl.message(
      'Change Language',
      name: 'profilePageSideMenuChangeLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get profilePageSideMenuChangeLanguageDialogTitle {
    return Intl.message(
      'Change Language',
      name: 'profilePageSideMenuChangeLanguageDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get profilePageSideMenuChangeLanguageDialogEnglish {
    return Intl.message(
      'English',
      name: 'profilePageSideMenuChangeLanguageDialogEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get profilePageSideMenuChangeLanguageDialogArabic {
    return Intl.message(
      'Arabic',
      name: 'profilePageSideMenuChangeLanguageDialogArabic',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get profilePageSideMenuAboutUsTitle {
    return Intl.message(
      'About Us',
      name: 'profilePageSideMenuAboutUsTitle',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get profilePageSideMenuAboutUsDialogTitle {
    return Intl.message(
      'About Us',
      name: 'profilePageSideMenuAboutUsDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Smart Label is a next-gen pricing and inventory platform for retailers.\n\nVersion: 1.0.0\n© 2025 Smart Label Inc.`
  String get profilePageSideMenuAboutUsDialogText {
    return Intl.message(
      'Smart Label is a next-gen pricing and inventory platform for retailers.\n\nVersion: 1.0.0\n© 2025 Smart Label Inc.',
      name: 'profilePageSideMenuAboutUsDialogText',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get profilePageSideMenuAboutUsDialogButton {
    return Intl.message(
      'OK',
      name: 'profilePageSideMenuAboutUsDialogButton',
      desc: '',
      args: [],
    );
  }

  /// `Login Success`
  String get loginSuccess {
    return Intl.message(
      'Login Success',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Email is not confirmed, please check your email`
  String get emailisnotconfirmedpleasecheckyouremail {
    return Intl.message(
      'Email is not confirmed, please check your email',
      name: 'emailisnotconfirmedpleasecheckyouremail',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful! We have sent a confirmation email to your address.`
  String get registrationsuccessfulWehavesentaconfirmationemailtoyouraddress {
    return Intl.message(
      'Registration successful! We have sent a confirmation email to your address.',
      name: 'registrationsuccessfulWehavesentaconfirmationemailtoyouraddress',
      desc: '',
      args: [],
    );
  }

  /// `Code sent successfully, check your email`
  String get codesentsuccessfullycheckyouremail {
    return Intl.message(
      'Code sent successfully, check your email',
      name: 'codesentsuccessfullycheckyouremail',
      desc: '',
      args: [],
    );
  }

  /// `Code Verified Successfully`
  String get codeVerifiedSuccessfully {
    return Intl.message(
      'Code Verified Successfully',
      name: 'codeVerifiedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Password Changed Successfully`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Password Changed Successfully',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load products`
  String get failedToLoadProducts {
    return Intl.message(
      'Failed to load products',
      name: 'failedToLoadProducts',
      desc: '',
      args: [],
    );
  }

  /// `No Products Found`
  String get noProductsFound {
    return Intl.message(
      'No Products Found',
      name: 'noProductsFound',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load categories`
  String get failedToLoadCategories {
    return Intl.message(
      'Failed to load categories',
      name: 'failedToLoadCategories',
      desc: '',
      args: [],
    );
  }

  /// `No categories found`
  String get noCategoriesFound {
    return Intl.message(
      'No categories found',
      name: 'noCategoriesFound',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load favorites`
  String get failedToLoadFavourites {
    return Intl.message(
      'Failed to load favorites',
      name: 'failedToLoadFavourites',
      desc: '',
      args: [],
    );
  }

  /// `No favorites found`
  String get noFavouritesFound {
    return Intl.message(
      'No favorites found',
      name: 'noFavouritesFound',
      desc: '',
      args: [],
    );
  }

  /// `Please login first`
  String get pleaseLoginFirst {
    return Intl.message(
      'Please login first',
      name: 'pleaseLoginFirst',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load user info`
  String get failedToLoadUserInfo {
    return Intl.message(
      'Failed to load user info',
      name: 'failedToLoadUserInfo',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out Successfully`
  String get signOutSuccessfully {
    return Intl.message(
      'Sign Out Successfully',
      name: 'signOutSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Banner Details`
  String get bannerDetails {
    return Intl.message(
      'Banner Details',
      name: 'bannerDetails',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load banner details`
  String get failedToLoadBannerDetails {
    return Intl.message(
      'Failed to load banner details',
      name: 'failedToLoadBannerDetails',
      desc: '',
      args: [],
    );
  }

  /// `Title:`
  String get bannerDetailsTitle {
    return Intl.message(
      'Title:',
      name: 'bannerDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start Date:`
  String get bannerDetailsStartDate {
    return Intl.message(
      'Start Date:',
      name: 'bannerDetailsStartDate',
      desc: '',
      args: [],
    );
  }

  /// `End Date:`
  String get bannerDetailsEndDate {
    return Intl.message(
      'End Date:',
      name: 'bannerDetailsEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Description:`
  String get bannerDetailsDescription {
    return Intl.message(
      'Description:',
      name: 'bannerDetailsDescription',
      desc: '',
      args: [],
    );
  }

  /// `You must be logged in.`
  String get youMustBeLoggedIn {
    return Intl.message(
      'You must be logged in.',
      name: 'youMustBeLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load product details.`
  String get failedToLoadProductDetails {
    return Intl.message(
      'Failed to load product details.',
      name: 'failedToLoadProductDetails',
      desc: '',
      args: [],
    );
  }

  /// `Price:`
  String get productDetailsPrice {
    return Intl.message(
      'Price:',
      name: 'productDetailsPrice',
      desc: '',
      args: [],
    );
  }

  /// `Description:`
  String get productDetailsDescription {
    return Intl.message(
      'Description:',
      name: 'productDetailsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Category Products`
  String get categoryProducts {
    return Intl.message(
      'Category Products',
      name: 'categoryProducts',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load category products.`
  String get failedToLoadCategoryProducts {
    return Intl.message(
      'Failed to load category products.',
      name: 'failedToLoadCategoryProducts',
      desc: '',
      args: [],
    );
  }

  /// `No category products found in this category.`
  String get noCategoryProductsFoundInThisCategory {
    return Intl.message(
      'No category products found in this category.',
      name: 'noCategoryProductsFoundInThisCategory',
      desc: '',
      args: [],
    );
  }

  /// `Profile Updated Successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile Updated Successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Account Deleted Successfully`
  String get accountDeletedSuccessfully {
    return Intl.message(
      'Account Deleted Successfully',
      name: 'accountDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
