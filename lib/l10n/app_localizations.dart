import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'language'**
  String get language;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'no'**
  String get no;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'expenses'**
  String get expenses;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'cash'**
  String get cash;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'income'**
  String get income;

  /// No description provided for @stipend.
  ///
  /// In en, this message translates to:
  /// **'stipend'**
  String get stipend;

  /// No description provided for @allExpenses.
  ///
  /// In en, this message translates to:
  /// **'all expenses'**
  String get allExpenses;

  /// No description provided for @notExpenses.
  ///
  /// In en, this message translates to:
  /// **'no information!'**
  String get notExpenses;

  /// No description provided for @persianDigit.
  ///
  /// In en, this message translates to:
  /// **'toPersianDigit()'**
  String get persianDigit;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @incomeDetail.
  ///
  /// In en, this message translates to:
  /// **'Income Details'**
  String get incomeDetail;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'export PDF'**
  String get export;

  /// No description provided for @chooseCurrency.
  ///
  /// In en, this message translates to:
  /// **'Choose currency'**
  String get chooseCurrency;

  /// No description provided for @doYouWantTheDesiredItemToBeDeleted.
  ///
  /// In en, this message translates to:
  /// **'Do you want the desired item to be deleted?'**
  String get doYouWantTheDesiredItemToBeDeleted;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @chooseCurrencyQuestion.
  ///
  /// In en, this message translates to:
  /// **'Please choose currency'**
  String get chooseCurrencyQuestion;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @frequentlyAskedQuestions.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get frequentlyAskedQuestions;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @pleaseChooseYourLanguage.
  ///
  /// In en, this message translates to:
  /// **'Please choose your language :'**
  String get pleaseChooseYourLanguage;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get chooseTheme;

  /// No description provided for @pleaseChooseYourTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose theme :'**
  String get pleaseChooseYourTheme;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @persian.
  ///
  /// In en, this message translates to:
  /// **'Persian'**
  String get persian;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @totalInventory.
  ///
  /// In en, this message translates to:
  /// **'Total inventory'**
  String get totalInventory;

  /// No description provided for @pleaseEnterYourBalanceAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter your balance amount'**
  String get pleaseEnterYourBalanceAmount;

  /// No description provided for @grouping.
  ///
  /// In en, this message translates to:
  /// **'grouping'**
  String get grouping;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'expense'**
  String get expense;

  /// No description provided for @newExpense.
  ///
  /// In en, this message translates to:
  /// **'New Expense'**
  String get newExpense;

  /// No description provided for @addIncome.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addIncome;

  /// No description provided for @editExpense.
  ///
  /// In en, this message translates to:
  /// **'Edit Expense'**
  String get editExpense;

  /// No description provided for @editIncome.
  ///
  /// In en, this message translates to:
  /// **'Edit Income'**
  String get editIncome;

  /// No description provided for @applyChange.
  ///
  /// In en, this message translates to:
  /// **'Apply Change'**
  String get applyChange;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'description'**
  String get description;

  /// No description provided for @addExpense.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addExpense;

  /// No description provided for @transportation.
  ///
  /// In en, this message translates to:
  /// **'transportation'**
  String get transportation;

  /// No description provided for @comestible.
  ///
  /// In en, this message translates to:
  /// **'comestible'**
  String get comestible;

  /// No description provided for @buyItems.
  ///
  /// In en, this message translates to:
  /// **'buy items'**
  String get buyItems;

  /// No description provided for @installmentsAndDebt.
  ///
  /// In en, this message translates to:
  /// **'installments and debt'**
  String get installmentsAndDebt;

  /// No description provided for @subsidy.
  ///
  /// In en, this message translates to:
  /// **'subsidy'**
  String get subsidy;

  /// No description provided for @treatment.
  ///
  /// In en, this message translates to:
  /// **'treatment'**
  String get treatment;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'other'**
  String get other;

  /// No description provided for @gifts.
  ///
  /// In en, this message translates to:
  /// **'gifts'**
  String get gifts;

  /// No description provided for @reward.
  ///
  /// In en, this message translates to:
  /// **'reward'**
  String get reward;

  /// No description provided for @sale.
  ///
  /// In en, this message translates to:
  /// **'sale'**
  String get sale;

  /// No description provided for @renovation.
  ///
  /// In en, this message translates to:
  /// **'renovation'**
  String get renovation;

  /// No description provided for @pastime.
  ///
  /// In en, this message translates to:
  /// **'pastime'**
  String get pastime;

  /// No description provided for @toman.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get toman;

  /// No description provided for @rial.
  ///
  /// In en, this message translates to:
  /// **'R'**
  String get rial;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @expensePerYear.
  ///
  /// In en, this message translates to:
  /// **'expense per year'**
  String get expensePerYear;

  /// No description provided for @expenseTypePerYear.
  ///
  /// In en, this message translates to:
  /// **'expense type per year'**
  String get expenseTypePerYear;

  /// No description provided for @selectMonth.
  ///
  /// In en, this message translates to:
  /// **'select month'**
  String get selectMonth;

  /// No description provided for @selectYear.
  ///
  /// In en, this message translates to:
  /// **'select year'**
  String get selectYear;

  /// No description provided for @mapScale.
  ///
  /// In en, this message translates to:
  /// **'map scale'**
  String get mapScale;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
