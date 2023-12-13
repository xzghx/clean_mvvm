import 'package:clean_mvvm_project/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _PREF_LANG_KEY = 'PREF_LANG_KEY';
const String _PREF_ONBOARDING_VIEWED_KEY = 'PREF_ONBOARDING_VIEWED_KEY';
const String _PREF_IS_LOGGED_KEY = 'PREF_IS_LOGGED_KEY';

class AppPrefs {
  SharedPreferences _sharedPreferences;

  AppPrefs(this._sharedPreferences);

  String getLanguage() {
    String? lang = _sharedPreferences.getString(_PREF_LANG_KEY);
    if (lang != null && lang.isNotEmpty) {
      return lang;
    }
    return LanguageType.ENGLISH.toValue();
  }

  Future<void> setOnboardingViewed() async {
    await _sharedPreferences.setBool(_PREF_ONBOARDING_VIEWED_KEY, true);
  }

  Future<bool> isOnboardingViewed() async {
    return _sharedPreferences.getBool(_PREF_ONBOARDING_VIEWED_KEY) ?? false;
  }

  Future<void> setIsLoggedIn() async {
    await _sharedPreferences.setBool(_PREF_IS_LOGGED_KEY, true);
  }

  Future<bool> isLoggedIn() async {
    return _sharedPreferences.getBool(_PREF_IS_LOGGED_KEY) ?? false;
  }
}
