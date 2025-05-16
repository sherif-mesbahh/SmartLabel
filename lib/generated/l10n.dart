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

  /// `Featured Products`
  String get homePageNewProducts {
    return Intl.message(
      'Featured Products',
      name: 'homePageNewProducts',
      desc: '',
      args: [],
    );
  }

  /// ` Categories`
  String get homePageNewCategories {
    return Intl.message(
      ' Categories',
      name: 'homePageNewCategories',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAllButton {
    return Intl.message('See All', name: 'seeAllButton', desc: '', args: []);
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

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Products`
  String get searchProductsLabel {
    return Intl.message(
      'Products',
      name: 'searchProductsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get searchCategoriesLabel {
    return Intl.message(
      'Categories',
      name: 'searchCategoriesLabel',
      desc: '',
      args: [],
    );
  }

  /// `default`
  String get searchSortProductsByDefault {
    return Intl.message(
      'default',
      name: 'searchSortProductsByDefault',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get searchSortProductsByName {
    return Intl.message(
      'name',
      name: 'searchSortProductsByName',
      desc: '',
      args: [],
    );
  }

  /// `price`
  String get searchSortProductsByPrice {
    return Intl.message(
      'price',
      name: 'searchSortProductsByPrice',
      desc: '',
      args: [],
    );
  }

  /// `default`
  String get searchSortCategoriesByDefault {
    return Intl.message(
      'default',
      name: 'searchSortCategoriesByDefault',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get searchSortCategoriesByName {
    return Intl.message(
      'name',
      name: 'searchSortCategoriesByName',
      desc: '',
      args: [],
    );
  }

  /// `asc`
  String get searchOrderByAsc {
    return Intl.message('asc', name: 'searchOrderByAsc', desc: '', args: []);
  }

  /// `desc`
  String get searchOrderByDesc {
    return Intl.message('desc', name: 'searchOrderByDesc', desc: '', args: []);
  }

  /// `Search`
  String get searchLabel {
    return Intl.message('Search', name: 'searchLabel', desc: '', args: []);
  }

  /// `Search`
  String get searchHint {
    return Intl.message('Search', name: 'searchHint', desc: '', args: []);
  }

  /// `Please enter a search term`
  String get searchValidation {
    return Intl.message(
      'Please enter a search term',
      name: 'searchValidation',
      desc: '',
      args: [],
    );
  }

  /// `No items found with this name`
  String get noItemsFoundWithThisName {
    return Intl.message(
      'No items found with this name',
      name: 'noItemsFoundWithThisName',
      desc: '',
      args: [],
    );
  }

  /// `Search for any item`
  String get searchForAnyItem {
    return Intl.message(
      'Search for any item',
      name: 'searchForAnyItem',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load notifications`
  String get failedToLoadNotifications {
    return Intl.message(
      'Failed to load notifications',
      name: 'failedToLoadNotifications',
      desc: '',
      args: [],
    );
  }

  /// `No notifications found`
  String get noNotificationsFound {
    return Intl.message(
      'No notifications found',
      name: 'noNotificationsFound',
      desc: '',
      args: [],
    );
  }

  /// `Banner Deleted Successfully`
  String get bannerDeletedSuccessfully {
    return Intl.message(
      'Banner Deleted Successfully',
      name: 'bannerDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error while Deleting Banner, try again`
  String get errorDeletingBanner {
    return Intl.message(
      'Error while Deleting Banner, try again',
      name: 'errorDeletingBanner',
      desc: '',
      args: [],
    );
  }

  /// `Category Deleted successfully`
  String get categoryDeletedSuccessfully {
    return Intl.message(
      'Category Deleted successfully',
      name: 'categoryDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error while Deleting Category, try again`
  String get errorDeletingCategory {
    return Intl.message(
      'Error while Deleting Category, try again',
      name: 'errorDeletingCategory',
      desc: '',
      args: [],
    );
  }

  /// `Admin Panel`
  String get adminPanel {
    return Intl.message('Admin Panel', name: 'adminPanel', desc: '', args: []);
  }

  /// `All Banners`
  String get allBanners {
    return Intl.message('All Banners', name: 'allBanners', desc: '', args: []);
  }

  /// `Edit Users`
  String get editUsersButton {
    return Intl.message(
      'Edit Users',
      name: 'editUsersButton',
      desc: '',
      args: [],
    );
  }

  /// `Manage Admin Roles`
  String get manageAdminRules {
    return Intl.message(
      'Manage Admin Roles',
      name: 'manageAdminRules',
      desc: '',
      args: [],
    );
  }

  /// `Enter the user's email to add or remove admin access.`
  String get manageAdminText {
    return Intl.message(
      'Enter the user\'s email to add or remove admin access.',
      name: 'manageAdminText',
      desc: '',
      args: [],
    );
  }

  /// `User Email`
  String get userEmailLabel {
    return Intl.message(
      'User Email',
      name: 'userEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter user email`
  String get userEmailValidation {
    return Intl.message(
      'Please enter user email',
      name: 'userEmailValidation',
      desc: '',
      args: [],
    );
  }

  /// `is admin now`
  String get isAdminNow {
    return Intl.message('is admin now', name: 'isAdminNow', desc: '', args: []);
  }

  /// `is no longer admin`
  String get isNoLongerAdmin {
    return Intl.message(
      'is no longer admin',
      name: 'isNoLongerAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Make Admin`
  String get makeAdmin {
    return Intl.message('Make Admin', name: 'makeAdmin', desc: '', args: []);
  }

  /// `Remove Admin`
  String get removeAdmin {
    return Intl.message(
      'Remove Admin',
      name: 'removeAdmin',
      desc: '',
      args: [],
    );
  }

  /// `There is no Banners`
  String get thereIsNoBanners {
    return Intl.message(
      'There is no Banners',
      name: 'thereIsNoBanners',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Deletion`
  String get bannerConfirmDeletion {
    return Intl.message(
      'Confirm Deletion',
      name: 'bannerConfirmDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this Banner?`
  String get areYouSureYouWantToDeleteThisBanner {
    return Intl.message(
      'Are you sure you want to delete this Banner?',
      name: 'areYouSureYouWantToDeleteThisBanner',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get bannerDeleteCancelButton {
    return Intl.message(
      'Cancel',
      name: 'bannerDeleteCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get bannerDeleteDeleteButton {
    return Intl.message(
      'Delete',
      name: 'bannerDeleteDeleteButton',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get allCategories {
    return Intl.message(
      'All Categories',
      name: 'allCategories',
      desc: '',
      args: [],
    );
  }

  /// `Add Banner`
  String get addBannerButton {
    return Intl.message(
      'Add Banner',
      name: 'addBannerButton',
      desc: '',
      args: [],
    );
  }

  /// `Add Banner`
  String get addBannerDialogTitle {
    return Intl.message(
      'Add Banner',
      name: 'addBannerDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get addBannerDialogBannerTitle {
    return Intl.message(
      'Title',
      name: 'addBannerDialogBannerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get addBannerDialogBannerDescription {
    return Intl.message(
      'Description',
      name: 'addBannerDialogBannerDescription',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get addBannerDialogBannerSelectDate {
    return Intl.message(
      'Select Date',
      name: 'addBannerDialogBannerSelectDate',
      desc: '',
      args: [],
    );
  }

  /// `Start Date:`
  String get addBannerDialogBannerStartDate {
    return Intl.message(
      'Start Date:',
      name: 'addBannerDialogBannerStartDate',
      desc: '',
      args: [],
    );
  }

  /// `End Date:`
  String get addBannerDialogBannerEndDate {
    return Intl.message(
      'End Date:',
      name: 'addBannerDialogBannerEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Pick Main Image`
  String get addBannerDialogBannerPickMainImage {
    return Intl.message(
      'Pick Main Image',
      name: 'addBannerDialogBannerPickMainImage',
      desc: '',
      args: [],
    );
  }

  /// `Pick Banner Images`
  String get addBannerDialogBannerPickBannerImages {
    return Intl.message(
      'Pick Banner Images',
      name: 'addBannerDialogBannerPickBannerImages',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get addBannerDialogBannerApply {
    return Intl.message(
      'Apply',
      name: 'addBannerDialogBannerApply',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get addBannerDialogBannerCancel {
    return Intl.message(
      'Cancel',
      name: 'addBannerDialogBannerCancel',
      desc: '',
      args: [],
    );
  }

  /// `Banner added successfully.`
  String get bannerAddedSuccessfuly {
    return Intl.message(
      'Banner added successfully.',
      name: 'bannerAddedSuccessfuly',
      desc: '',
      args: [],
    );
  }

  /// `Error occured while adding banner, Please try again.`
  String get errorAddingBanner {
    return Intl.message(
      'Error occured while adding banner, Please try again.',
      name: 'errorAddingBanner',
      desc: '',
      args: [],
    );
  }

  /// `Title must not be empty.`
  String get bannerTitleValidation {
    return Intl.message(
      'Title must not be empty.',
      name: 'bannerTitleValidation',
      desc: '',
      args: [],
    );
  }

  /// `Start and end dates must be selected.`
  String get bannerStartAndEndDateValidation {
    return Intl.message(
      'Start and end dates must be selected.',
      name: 'bannerStartAndEndDateValidation',
      desc: '',
      args: [],
    );
  }

  /// `Start date must be before end date.`
  String get bannerStartDateMustBeBeforeEndDate {
    return Intl.message(
      'Start date must be before end date.',
      name: 'bannerStartDateMustBeBeforeEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Start date must not be before our time.`
  String get bannerStartDateMustNotBeBeforeNow {
    return Intl.message(
      'Start date must not be before our time.',
      name: 'bannerStartDateMustNotBeBeforeNow',
      desc: '',
      args: [],
    );
  }

  /// `Please select a main image.`
  String get bannerMainImageValidation {
    return Intl.message(
      'Please select a main image.',
      name: 'bannerMainImageValidation',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least one image.`
  String get bannerBannerImagesValidation {
    return Intl.message(
      'Please select at least one image.',
      name: 'bannerBannerImagesValidation',
      desc: '',
      args: [],
    );
  }

  /// `Banner Details`
  String get editBannerDetails {
    return Intl.message(
      'Banner Details',
      name: 'editBannerDetails',
      desc: '',
      args: [],
    );
  }

  /// `Banner Updated Successfully`
  String get bannerUpdatedSuccessfully {
    return Intl.message(
      'Banner Updated Successfully',
      name: 'bannerUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Edit Main Image`
  String get editBannerMainImageButton {
    return Intl.message(
      'Edit Main Image',
      name: 'editBannerMainImageButton',
      desc: '',
      args: [],
    );
  }

  /// `Set Main Banner Image`
  String get setMainBannerImage {
    return Intl.message(
      'Set Main Banner Image',
      name: 'setMainBannerImage',
      desc: '',
      args: [],
    );
  }

  /// `Pick main image`
  String get editBannerDialogPickMainImage {
    return Intl.message(
      'Pick main image',
      name: 'editBannerDialogPickMainImage',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get editBannerDialogApplyButton {
    return Intl.message(
      'Apply',
      name: 'editBannerDialogApplyButton',
      desc: '',
      args: [],
    );
  }

  /// `Add Images`
  String get editBannerAddImagesButton {
    return Intl.message(
      'Add Images',
      name: 'editBannerAddImagesButton',
      desc: '',
      args: [],
    );
  }

  /// `Add Images`
  String get editBannerAddImagesDialogTitle {
    return Intl.message(
      'Add Images',
      name: 'editBannerAddImagesDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pick Banner Images`
  String get editBannerAddImagesDialogPickBannreImages {
    return Intl.message(
      'Pick Banner Images',
      name: 'editBannerAddImagesDialogPickBannreImages',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get editBannerAddImagesDialogCancelButton {
    return Intl.message(
      'Cancel',
      name: 'editBannerAddImagesDialogCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get editBannerAddImagesDialogApplyButton {
    return Intl.message(
      'Apply',
      name: 'editBannerAddImagesDialogApplyButton',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get editBannerTitleText {
    return Intl.message(
      'Title',
      name: 'editBannerTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get editBannerStartDateText {
    return Intl.message(
      'Start Date',
      name: 'editBannerStartDateText',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get editBannerEndDateText {
    return Intl.message(
      'End Date',
      name: 'editBannerEndDateText',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get editBannerDescriptionText {
    return Intl.message(
      'Description',
      name: 'editBannerDescriptionText',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get editBannerSaveButton {
    return Intl.message(
      'Save Changes',
      name: 'editBannerSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get editBannerDiscardButton {
    return Intl.message(
      'Discard',
      name: 'editBannerDiscardButton',
      desc: '',
      args: [],
    );
  }

  /// `There is no Categories`
  String get thereIsNoCategories {
    return Intl.message(
      'There is no Categories',
      name: 'thereIsNoCategories',
      desc: '',
      args: [],
    );
  }

  /// `Confrm Deletion`
  String get categoryConfirmDeletion {
    return Intl.message(
      'Confrm Deletion',
      name: 'categoryConfirmDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this category?,`
  String get categoryDeletionText {
    return Intl.message(
      'Are you sure you want to delete this category?,',
      name: 'categoryDeletionText',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get categoryDeletionCancelButton {
    return Intl.message(
      'Cancel',
      name: 'categoryDeletionCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get categoryDeletionDeleteButton {
    return Intl.message(
      'Delete',
      name: 'categoryDeletionDeleteButton',
      desc: '',
      args: [],
    );
  }

  /// `Category added successfully.`
  String get categoryAddedSuccessfully {
    return Intl.message(
      'Category added successfully.',
      name: 'categoryAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add category. Try again.`
  String get categoryFailedToAdd {
    return Intl.message(
      'Failed to add category. Try again.',
      name: 'categoryFailedToAdd',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get categoryDialogTitle {
    return Intl.message(
      'Add Category',
      name: 'categoryDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get categoryDialogCategoryName {
    return Intl.message(
      'Category Name',
      name: 'categoryDialogCategoryName',
      desc: '',
      args: [],
    );
  }

  /// `Pick Category Image`
  String get categoryDialogPickImage {
    return Intl.message(
      'Pick Category Image',
      name: 'categoryDialogPickImage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get categoryDialogCancelButton {
    return Intl.message(
      'Cancel',
      name: 'categoryDialogCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get categoryDialogApplyButton {
    return Intl.message(
      'Apply',
      name: 'categoryDialogApplyButton',
      desc: '',
      args: [],
    );
  }

  /// `Category name must not be empty.`
  String get categoryDialogNameValidation {
    return Intl.message(
      'Category name must not be empty.',
      name: 'categoryDialogNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Category name must be at least 3 characters.`
  String get categoryDialogNameLengthValidation {
    return Intl.message(
      'Category name must be at least 3 characters.',
      name: 'categoryDialogNameLengthValidation',
      desc: '',
      args: [],
    );
  }

  /// `Please select an image for the category.`
  String get categoryDialogImageValidation {
    return Intl.message(
      'Please select an image for the category.',
      name: 'categoryDialogImageValidation',
      desc: '',
      args: [],
    );
  }

  /// `Category Updated Successfully`
  String get categoryUpdatedSuccessfully {
    return Intl.message(
      'Category Updated Successfully',
      name: 'categoryUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Product Deleted Successfully`
  String get productDeletedSuccessfully {
    return Intl.message(
      'Product Deleted Successfully',
      name: 'productDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error while Deleting Product, try again`
  String get productDeletedError {
    return Intl.message(
      'Error while Deleting Product, try again',
      name: 'productDeletedError',
      desc: '',
      args: [],
    );
  }

  /// `No Category details available.`
  String get noCategoryDetailsAvailable {
    return Intl.message(
      'No Category details available.',
      name: 'noCategoryDetailsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Edit Category`
  String get editCategoryAppBarTitle {
    return Intl.message(
      'Edit Category',
      name: 'editCategoryAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `CategoryName`
  String get editCategoryName {
    return Intl.message(
      'CategoryName',
      name: 'editCategoryName',
      desc: '',
      args: [],
    );
  }

  /// `Edit Image`
  String get editCategoryEditImageButton {
    return Intl.message(
      'Edit Image',
      name: 'editCategoryEditImageButton',
      desc: '',
      args: [],
    );
  }

  /// `Set New Category Image`
  String get setNewCategoryImage {
    return Intl.message(
      'Set New Category Image',
      name: 'setNewCategoryImage',
      desc: '',
      args: [],
    );
  }

  /// `Pick Image`
  String get pickNewCategoryImage {
    return Intl.message(
      'Pick Image',
      name: 'pickNewCategoryImage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get pickNewCategoryImageCancel {
    return Intl.message(
      'Cancel',
      name: 'pickNewCategoryImageCancel',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get pickNewCategoryImageApply {
    return Intl.message(
      'Apply',
      name: 'pickNewCategoryImageApply',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get editCategorySaveChangesButton {
    return Intl.message(
      'Save changes',
      name: 'editCategorySaveChangesButton',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get editCategoryDiscardChangesButton {
    return Intl.message(
      'Discard',
      name: 'editCategoryDiscardChangesButton',
      desc: '',
      args: [],
    );
  }

  /// `Name must be at least 3 characters`
  String get editCategoryNameValidation {
    return Intl.message(
      'Name must be at least 3 characters',
      name: 'editCategoryNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get categoryProductsTitle {
    return Intl.message(
      'Products',
      name: 'categoryProductsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No Products Available for this Category`
  String get noProductsInThisCategory {
    return Intl.message(
      'No Products Available for this Category',
      name: 'noProductsInThisCategory',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Deletion`
  String get productConfirmDeletion {
    return Intl.message(
      'Confirm Deletion',
      name: 'productConfirmDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this Product?`
  String get productConfirmDeletionText {
    return Intl.message(
      'Are you sure you want to delete this Product?',
      name: 'productConfirmDeletionText',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get productDeletionCancelButton {
    return Intl.message(
      'Cancel',
      name: 'productDeletionCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get productDeletionDeleteButton {
    return Intl.message(
      'Delete',
      name: 'productDeletionDeleteButton',
      desc: '',
      args: [],
    );
  }

  /// `Product added successfully.`
  String get productAddedSuccessfully {
    return Intl.message(
      'Product added successfully.',
      name: 'productAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add product. Try again.`
  String get productFailedToAdd {
    return Intl.message(
      'Failed to add product. Try again.',
      name: 'productFailedToAdd',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addProductDialogTitle {
    return Intl.message(
      'Add Product',
      name: 'addProductDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get addProductDialogName {
    return Intl.message(
      'Product Name',
      name: 'addProductDialogName',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get addProductDialogPrice {
    return Intl.message(
      'Price',
      name: 'addProductDialogPrice',
      desc: '',
      args: [],
    );
  }

  /// `Discount (%)`
  String get addProductDialogDiscount {
    return Intl.message(
      'Discount (%)',
      name: 'addProductDialogDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get addProductDialogDescription {
    return Intl.message(
      'Description',
      name: 'addProductDialogDescription',
      desc: '',
      args: [],
    );
  }

  /// `Pick Image`
  String get addProductDialogPickImageButton {
    return Intl.message(
      'Pick Image',
      name: 'addProductDialogPickImageButton',
      desc: '',
      args: [],
    );
  }

  /// `Pick Product Images`
  String get addProductDialogPickImagesButton {
    return Intl.message(
      'Pick Product Images',
      name: 'addProductDialogPickImagesButton',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get addProductDialogCancelButton {
    return Intl.message(
      'Cancel',
      name: 'addProductDialogCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get addProductDialogAddButton {
    return Intl.message(
      'Add',
      name: 'addProductDialogAddButton',
      desc: '',
      args: [],
    );
  }

  /// `Product name must not be empty.`
  String get addProductNameValidation {
    return Intl.message(
      'Product name must not be empty.',
      name: 'addProductNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Price must not be empty.`
  String get addProductPriceValidation {
    return Intl.message(
      'Price must not be empty.',
      name: 'addProductPriceValidation',
      desc: '',
      args: [],
    );
  }

  /// `Price must be a valid positive number.`
  String get addProductPricePositiveValidation {
    return Intl.message(
      'Price must be a valid positive number.',
      name: 'addProductPricePositiveValidation',
      desc: '',
      args: [],
    );
  }

  /// `Discount must not be empty.`
  String get addProductDiscountValidation {
    return Intl.message(
      'Discount must not be empty.',
      name: 'addProductDiscountValidation',
      desc: '',
      args: [],
    );
  }

  /// `Discount must be a valid number between 0 and 100.`
  String get addProductDiscountValidNumber {
    return Intl.message(
      'Discount must be a valid number between 0 and 100.',
      name: 'addProductDiscountValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please select a main image.`
  String get addProductMainImageValidation {
    return Intl.message(
      'Please select a main image.',
      name: 'addProductMainImageValidation',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProductAppBarTitle {
    return Intl.message(
      'Edit Product',
      name: 'editProductAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Product Updated Successfully`
  String get productUpdatedSuccessfully {
    return Intl.message(
      'Product Updated Successfully',
      name: 'productUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error while Updating Product, try again`
  String get productUpdatedError {
    return Intl.message(
      'Error while Updating Product, try again',
      name: 'productUpdatedError',
      desc: '',
      args: [],
    );
  }

  /// `No Product details available.`
  String get noProductDetailsAvailable {
    return Intl.message(
      'No Product details available.',
      name: 'noProductDetailsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Edit Main Image`
  String get editProductEditMainImageButton {
    return Intl.message(
      'Edit Main Image',
      name: 'editProductEditMainImageButton',
      desc: '',
      args: [],
    );
  }

  /// `Set Main Product Image`
  String get editProductEditMainImageTitle {
    return Intl.message(
      'Set Main Product Image',
      name: 'editProductEditMainImageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pick Main Image`
  String get editProductEditMainImagePickImage {
    return Intl.message(
      'Pick Main Image',
      name: 'editProductEditMainImagePickImage',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get editProductEditMainImageApply {
    return Intl.message(
      'Apply',
      name: 'editProductEditMainImageApply',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get editProductEditMainImageCancel {
    return Intl.message(
      'Cancel',
      name: 'editProductEditMainImageCancel',
      desc: '',
      args: [],
    );
  }

  /// `Add Images`
  String get editProductAddImagesButton {
    return Intl.message(
      'Add Images',
      name: 'editProductAddImagesButton',
      desc: '',
      args: [],
    );
  }

  /// `Add Product Images`
  String get editProductAddImagesDialogTitle {
    return Intl.message(
      'Add Product Images',
      name: 'editProductAddImagesDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pick Product Images`
  String get editProductAddImagesDialogPickProductImages {
    return Intl.message(
      'Pick Product Images',
      name: 'editProductAddImagesDialogPickProductImages',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get editProductAddImagesDialogCancel {
    return Intl.message(
      'Cancel',
      name: 'editProductAddImagesDialogCancel',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get editProductAddImagesDialogApply {
    return Intl.message(
      'Apply',
      name: 'editProductAddImagesDialogApply',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get editProductName {
    return Intl.message('Name', name: 'editProductName', desc: '', args: []);
  }

  /// `Price`
  String get editProductPrice {
    return Intl.message('Price', name: 'editProductPrice', desc: '', args: []);
  }

  /// `Discount`
  String get editProductDiscount {
    return Intl.message(
      'Discount',
      name: 'editProductDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get editProductDescription {
    return Intl.message(
      'Description',
      name: 'editProductDescription',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get editProductSaveChangesButton {
    return Intl.message(
      'Save Changes',
      name: 'editProductSaveChangesButton',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get editProductDiscardChangesButton {
    return Intl.message(
      'Discard',
      name: 'editProductDiscardChangesButton',
      desc: '',
      args: [],
    );
  }

  /// `Name must be not empty`
  String get editProductNameValidation {
    return Intl.message(
      'Name must be not empty',
      name: 'editProductNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Price must be not empty`
  String get editProductPriceValidation {
    return Intl.message(
      'Price must be not empty',
      name: 'editProductPriceValidation',
      desc: '',
      args: [],
    );
  }

  /// `Price must be a valid positive number`
  String get editProductPricePositiveValidation {
    return Intl.message(
      'Price must be a valid positive number',
      name: 'editProductPricePositiveValidation',
      desc: '',
      args: [],
    );
  }

  /// `Discount must be not empty`
  String get editProductDiscountValidation {
    return Intl.message(
      'Discount must be not empty',
      name: 'editProductDiscountValidation',
      desc: '',
      args: [],
    );
  }

  /// `Discount must be a valid number between 0 and 100`
  String get editProductDiscountNumberValidation {
    return Intl.message(
      'Discount must be a valid number between 0 and 100',
      name: 'editProductDiscountNumberValidation',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Notification Type`
  String get unknownNotificationTybe {
    return Intl.message(
      'Unknown Notification Type',
      name: 'unknownNotificationTybe',
      desc: '',
      args: [],
    );
  }

  /// `Banner details not found`
  String get bannerDetailsNotFound {
    return Intl.message(
      'Banner details not found',
      name: 'bannerDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Product details not found`
  String get productDetailsNotFound {
    return Intl.message(
      'Product details not found',
      name: 'productDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Invalid notification details`
  String get invalidNotificationDetails {
    return Intl.message(
      'Invalid notification details',
      name: 'invalidNotificationDetails',
      desc: '',
      args: [],
    );
  }

  /// `Invalid notification`
  String get invalidNotification {
    return Intl.message(
      'Invalid notification',
      name: 'invalidNotification',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categoriesAppBarr {
    return Intl.message(
      'Categories',
      name: 'categoriesAppBarr',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get navBarCart {
    return Intl.message('Cart', name: 'navBarCart', desc: '', args: []);
  }

  /// `Browse Products`
  String get browseProducts {
    return Intl.message(
      'Browse Products',
      name: 'browseProducts',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load Banners`
  String get failedToLoadBanners {
    return Intl.message(
      'Failed to load Banners',
      name: 'failedToLoadBanners',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get productsAppBarTitle {
    return Intl.message(
      'Products',
      name: 'productsAppBarTitle',
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
