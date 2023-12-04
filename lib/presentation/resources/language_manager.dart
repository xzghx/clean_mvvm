enum LanguageType { ENGLISH, ARABIC, PERSIAN }

const String _FA = 'fa';
const String _EN = 'en';
const String _AR = 'ar';

extension LanguageTypeExtension on LanguageType {
  String toValue() {
    switch (this) {
      case LanguageType.PERSIAN:
        return _FA;
      case LanguageType.ARABIC:
        return _AR;
      case LanguageType.ENGLISH:
        return _EN;
    }
  }
}
