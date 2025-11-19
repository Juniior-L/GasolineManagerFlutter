import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeMessage;

  /// No description provided for @myVehicles.
  ///
  /// In en, this message translates to:
  /// **'My vehicles'**
  String get myVehicles;

  /// No description provided for @registerRefuel.
  ///
  /// In en, this message translates to:
  /// **'Register refuel'**
  String get registerRefuel;

  /// No description provided for @refuelHistory.
  ///
  /// In en, this message translates to:
  /// **'Refuel history'**
  String get refuelHistory;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @monthOverview.
  ///
  /// In en, this message translates to:
  /// **'{month} Overview'**
  String monthOverview(Object month);

  /// No description provided for @yourFuelBalance.
  ///
  /// In en, this message translates to:
  /// **'Your fuel balance'**
  String get yourFuelBalance;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get thisMonth;

  /// No description provided for @vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get vehicle;

  /// No description provided for @selectOne.
  ///
  /// In en, this message translates to:
  /// **'Select one'**
  String get selectOne;

  /// No description provided for @noneRefuel.
  ///
  /// In en, this message translates to:
  /// **'None refuel yet 😴.'**
  String get noneRefuel;

  /// No description provided for @refuels.
  ///
  /// In en, this message translates to:
  /// **'Refuels'**
  String get refuels;

  /// No description provided for @totalKm.
  ///
  /// In en, this message translates to:
  /// **'Total kilometers'**
  String get totalKm;

  /// No description provided for @kmPerLiter.
  ///
  /// In en, this message translates to:
  /// **'Km/L average'**
  String get kmPerLiter;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @noneVehicle.
  ///
  /// In en, this message translates to:
  /// **'None vehicles yet 🚗'**
  String get noneVehicle;

  /// No description provided for @registerFirstVehicle.
  ///
  /// In en, this message translates to:
  /// **'Register your first vehicle!'**
  String get registerFirstVehicle;

  /// No description provided for @emptyGraph.
  ///
  /// In en, this message translates to:
  /// **'Empty graph, refuel your car first.'**
  String get emptyGraph;

  /// No description provided for @monthExpensives.
  ///
  /// In en, this message translates to:
  /// **'Month expensives'**
  String get monthExpensives;

  /// No description provided for @addVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add vehicle'**
  String get addVehicle;

  /// No description provided for @addRefuel.
  ///
  /// In en, this message translates to:
  /// **'Add refuel'**
  String get addRefuel;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @errorLogin.
  ///
  /// In en, this message translates to:
  /// **'Error on Login'**
  String get errorLogin;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'user-not-found'**
  String get userNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'wrong-password'**
  String get wrongPassword;

  /// No description provided for @invalidCredential.
  ///
  /// In en, this message translates to:
  /// **'invalid-credential'**
  String get invalidCredential;

  /// No description provided for @emailIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Email or password incorrect.'**
  String get emailIncorrect;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'invalid-email'**
  String get invalidEmail;

  /// No description provided for @fillFields.
  ///
  /// In en, this message translates to:
  /// **'Fill the fields'**
  String get fillFields;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccount;

  /// No description provided for @editRefuel.
  ///
  /// In en, this message translates to:
  /// **'Edit refuel'**
  String get editRefuel;

  /// No description provided for @deleteRefuel.
  ///
  /// In en, this message translates to:
  /// **'Delete refuel'**
  String get deleteRefuel;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete?'**
  String get confirmDelete;

  /// No description provided for @yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, delete'**
  String get yesDelete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @gasStation.
  ///
  /// In en, this message translates to:
  /// **'Gas station'**
  String get gasStation;

  /// No description provided for @liters.
  ///
  /// In en, this message translates to:
  /// **'Liters'**
  String get liters;

  /// No description provided for @odometer.
  ///
  /// In en, this message translates to:
  /// **'Odometer'**
  String get odometer;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @vehicleRemoved.
  ///
  /// In en, this message translates to:
  /// **'Vehicle removed'**
  String get vehicleRemoved;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @operationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Operation completed successfully!'**
  String get operationSuccess;

  /// No description provided for @operationFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed'**
  String get operationFailed;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @editVehicle.
  ///
  /// In en, this message translates to:
  /// **'Edit vehicle'**
  String get editVehicle;

  /// No description provided for @deleteVehicle.
  ///
  /// In en, this message translates to:
  /// **'Delete vehicle'**
  String get deleteVehicle;

  /// No description provided for @vehicleSaved.
  ///
  /// In en, this message translates to:
  /// **'Vehicle saved successfully!'**
  String get vehicleSaved;

  /// No description provided for @vehicleDeleted.
  ///
  /// In en, this message translates to:
  /// **'Vehicle deleted successfully!'**
  String get vehicleDeleted;

  /// No description provided for @selectVehicle.
  ///
  /// In en, this message translates to:
  /// **'Select the vehicle'**
  String get selectVehicle;

  /// No description provided for @fuelType.
  ///
  /// In en, this message translates to:
  /// **'Fuel type'**
  String get fuelType;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No description provided for @lastRefuels.
  ///
  /// In en, this message translates to:
  /// **'Last refuels'**
  String get lastRefuels;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get average;

  /// No description provided for @myRefuels.
  ///
  /// In en, this message translates to:
  /// **'My refuels'**
  String get myRefuels;

  /// No description provided for @trackFuelHistory.
  ///
  /// In en, this message translates to:
  /// **'Track your fuel history easily ⛽'**
  String get trackFuelHistory;

  /// No description provided for @noRefuels.
  ///
  /// In en, this message translates to:
  /// **'No refuels yet ⛽'**
  String get noRefuels;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @refuelRemoved.
  ///
  /// In en, this message translates to:
  /// **'Refuel removed successfully!'**
  String get refuelRemoved;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @fillDetailsRegister.
  ///
  /// In en, this message translates to:
  /// **'Fill in your details to register'**
  String get fillDetailsRegister;

  /// No description provided for @errorCreate.
  ///
  /// In en, this message translates to:
  /// **'Error on Creating account'**
  String get errorCreate;

  /// No description provided for @emailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already in use. Try logging in.'**
  String get emailInUse;

  /// No description provided for @passwordMinimo.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get passwordMinimo;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @backLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backLogin;

  /// No description provided for @takeCareVehicles.
  ///
  /// In en, this message translates to:
  /// **'Take care of all your vehicles'**
  String get takeCareVehicles;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'date'**
  String get date;

  /// No description provided for @fillCarefull.
  ///
  /// In en, this message translates to:
  /// **'Fill the information carefully.'**
  String get fillCarefull;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @licensePlate.
  ///
  /// In en, this message translates to:
  /// **'License Plate'**
  String get licensePlate;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
