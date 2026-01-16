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
    final name = (locale.countryCode?.isEmpty ?? false)
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

  /// `Welcome`
  String get title {
    return Intl.message('Welcome', name: 'title', desc: '', args: []);
  }

  /// `Apartment`
  String get apartment {
    return Intl.message('Apartment', name: 'apartment', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Enter your password`
  String get password {
    return Intl.message(
      'Enter your password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your number`
  String get number {
    return Intl.message(
      'Enter your number',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields`
  String get fill_field {
    return Intl.message(
      'Please fill all fields',
      name: 'fill_field',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get phone_required {
    return Intl.message(
      'Phone number is required',
      name: 'phone_required',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get signup {
    return Intl.message('Signup', name: 'signup', desc: '', args: []);
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Night Mode`
  String get night_mode {
    return Intl.message('Night Mode', name: 'night_mode', desc: '', args: []);
  }

  /// `Filter Apartments`
  String get filter_apartments {
    return Intl.message(
      'Filter Apartments',
      name: 'filter_apartments',
      desc: '',
      args: [],
    );
  }

  /// `Governorate`
  String get governorate {
    return Intl.message('Governorate', name: 'governorate', desc: '', args: []);
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Rooms`
  String get rooms {
    return Intl.message('Rooms', name: 'rooms', desc: '', args: []);
  }

  /// `Price Range`
  String get price_range {
    return Intl.message('Price Range', name: 'price_range', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Search...`
  String get search {
    return Intl.message('Search...', name: 'search', desc: '', args: []);
  }

  /// `Damascus`
  String get damascus {
    return Intl.message('Damascus', name: 'damascus', desc: '', args: []);
  }

  /// `Midan`
  String get midan {
    return Intl.message('Midan', name: 'midan', desc: '', args: []);
  }

  /// `Mazzeh`
  String get mazzeh {
    return Intl.message('Mazzeh', name: 'mazzeh', desc: '', args: []);
  }

  /// `Syria`
  String get syria {
    return Intl.message('Syria', name: 'syria', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Apartment`
  String get apartment_type {
    return Intl.message(
      'Apartment',
      name: 'apartment_type',
      desc: '',
      args: [],
    );
  }

  /// `Villa`
  String get villa {
    return Intl.message('Villa', name: 'villa', desc: '', args: []);
  }

  /// `Hotel Room`
  String get hotel_room {
    return Intl.message('Hotel Room', name: 'hotel_room', desc: '', args: []);
  }

  /// `Cottage`
  String get cottage {
    return Intl.message('Cottage', name: 'cottage', desc: '', args: []);
  }

  /// `Special For You`
  String get special_for_you {
    return Intl.message(
      'Special For You',
      name: 'special_for_you',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get see_all {
    return Intl.message('See All', name: 'see_all', desc: '', args: []);
  }

  /// `Birthday Date`
  String get birthday_date {
    return Intl.message(
      'Birthday Date',
      name: 'birthday_date',
      desc: '',
      args: [],
    );
  }

  /// `Please enter date of birth`
  String get please_birth {
    return Intl.message(
      'Please enter date of birth',
      name: 'please_birth',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get please_password {
    return Intl.message(
      'Please enter password',
      name: 'please_password',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Owner`
  String get owner {
    return Intl.message('Owner', name: 'owner', desc: '', args: []);
  }

  /// `Tenant`
  String get tenant {
    return Intl.message('Tenant', name: 'tenant', desc: '', args: []);
  }

  /// `First Name`
  String get first_name {
    return Intl.message('First Name', name: 'first_name', desc: '', args: []);
  }

  /// `Please enter first name`
  String get please_first {
    return Intl.message(
      'Please enter first name',
      name: 'please_first',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message('Last Name', name: 'last_name', desc: '', args: []);
  }

  /// `Please enter last name`
  String get please_last {
    return Intl.message(
      'Please enter last name',
      name: 'please_last',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_match',
      desc: '',
      args: [],
    );
  }

  /// `Add identity photo`
  String get add_identity {
    return Intl.message(
      'Add identity photo',
      name: 'add_identity',
      desc: '',
      args: [],
    );
  }

  /// `Please choose personal photo`
  String get please_personal_photo {
    return Intl.message(
      'Please choose personal photo',
      name: 'please_personal_photo',
      desc: '',
      args: [],
    );
  }

  /// `Please choose identity photo`
  String get please_identity_photo {
    return Intl.message(
      'Please choose identity photo',
      name: 'please_identity_photo',
      desc: '',
      args: [],
    );
  }

  /// `Please choose role`
  String get please_role {
    return Intl.message(
      'Please choose role',
      name: 'please_role',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get booking {
    return Intl.message('Booking', name: 'booking', desc: '', args: []);
  }

  /// `Start Date`
  String get start_date {
    return Intl.message('Start Date', name: 'start_date', desc: '', args: []);
  }

  /// `End Date`
  String get end_date {
    return Intl.message('End Date', name: 'end_date', desc: '', args: []);
  }

  /// `Price per night`
  String get per_night {
    return Intl.message(
      'Price per night',
      name: 'per_night',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Days`
  String get days {
    return Intl.message('Days', name: 'days', desc: '', args: []);
  }

  /// `Please select dates first`
  String get select_dates_first {
    return Intl.message(
      'Please select dates first',
      name: 'select_dates_first',
      desc: '',
      args: [],
    );
  }

  /// `Update Booking`
  String get update_booking {
    return Intl.message(
      'Update Booking',
      name: 'update_booking',
      desc: '',
      args: [],
    );
  }

  /// `Book Now`
  String get book_now {
    return Intl.message('Book Now', name: 'book_now', desc: '', args: []);
  }

  /// `My Bookings`
  String get my_bookings {
    return Intl.message('My Bookings', name: 'my_bookings', desc: '', args: []);
  }

  /// `No bookings yet`
  String get no_bookings_yet {
    return Intl.message(
      'No bookings yet',
      name: 'no_bookings_yet',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message('Cancelled', name: 'cancelled', desc: '', args: []);
  }

  /// `Check-in`
  String get check_in {
    return Intl.message('Check-in', name: 'check_in', desc: '', args: []);
  }

  /// `Check-out`
  String get check_out {
    return Intl.message('Check-out', name: 'check_out', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Cancel Booking`
  String get cancel_booking {
    return Intl.message(
      'Cancel Booking',
      name: 'cancel_booking',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this booking?`
  String get confirm_cancel_booking {
    return Intl.message(
      'Are you sure you want to cancel this booking?',
      name: 'confirm_cancel_booking',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `My Documents`
  String get my_documents {
    return Intl.message(
      'My Documents',
      name: 'my_documents',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `No favorites yet`
  String get no_favorites_yet {
    return Intl.message(
      'No favorites yet',
      name: 'no_favorites_yet',
      desc: '',
      args: [],
    );
  }

  /// `Booking cancelled`
  String get booking_cancelled {
    return Intl.message(
      'Booking cancelled',
      name: 'booking_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Failed to cancel`
  String get failed_to_cancel {
    return Intl.message(
      'Failed to cancel',
      name: 'failed_to_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Rooms`
  String get rooms_label {
    return Intl.message('Rooms', name: 'rooms_label', desc: '', args: []);
  }

  /// `Booking Error`
  String get booking_error {
    return Intl.message(
      'Booking Error',
      name: 'booking_error',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Select start date`
  String get select_start_date {
    return Intl.message(
      'Select start date',
      name: 'select_start_date',
      desc: '',
      args: [],
    );
  }

  /// `Select end date`
  String get select_end_date {
    return Intl.message(
      'Select end date',
      name: 'select_end_date',
      desc: '',
      args: [],
    );
  }

  /// `Price per night`
  String get price_per_night {
    return Intl.message(
      'Price per night',
      name: 'price_per_night',
      desc: '',
      args: [],
    );
  }

  /// `Account created, waiting for admin approval`
  String get account_created_waiting_for_admin {
    return Intl.message(
      'Account created, waiting for admin approval',
      name: 'account_created_waiting_for_admin',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your number`
  String get enter_phone {
    return Intl.message(
      'Please enter your number',
      name: 'enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message('cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Rate this Apartment`
  String get Rate_this_Apartment {
    return Intl.message(
      'Rate this Apartment',
      name: 'Rate_this_Apartment',
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
