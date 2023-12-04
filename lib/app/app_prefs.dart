import 'package:clean_mvvm_project/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _PREF_LANG_KEY = 'PREF_LANG_KEY';

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
}
