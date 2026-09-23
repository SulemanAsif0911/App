
class AppStrings {
  String of(String lang, String key) => _t[lang]?[key] ?? _t['en']![key] ?? key;
  static const _t = {
    'en': {
      'app': 'CYBER HAYAT PK',
      'tag': 'Digital Safety • Support • Awareness',
      'offlineReady': 'OFFLINE READY',
      'home': 'Home', 'guide': 'Guide', 'assistant': 'Assistant', 'cases': 'Cases', 'more': 'More',
      'disclaimer': 'Cyber Hayat PK provides safety information and support-navigation tools. It is not a replacement for emergency services, law enforcement, qualified legal advice, or professional mental-health care.',
      'legalDisclaimer': 'This is general awareness information, not legal advice. Laws and procedures can change. Verify current requirements with official sources or qualified legal professionals.',
    },
    'ur': {'app': 'سائبر حیات پی کے', 'home': 'ہوم', 'guide': 'رہنمائی', 'assistant': 'اسسٹنٹ', 'cases': 'کیسز', 'more': 'مزید', 'offlineReady': 'آف لائن تیار'},
    'pa': {'app': 'سائبر حیات پی کے', 'home': 'ہوم', 'guide': 'گائیڈ', 'assistant': 'اسسٹنٹ', 'cases': 'کیسز', 'more': 'ہور'},
    'sd': {'app': 'سائبر حيات پي ڪي', 'home': 'گهر', 'guide': 'رهنمائي', 'assistant': 'اسسٽنٽ', 'cases': 'ڪيس', 'more': 'وڌيڪ'},
    'ps': {'app': 'سایبر حیات پی کے', 'home': 'کور', 'guide': 'لارښود', 'assistant': 'مرستیال', 'cases': 'قضیې', 'more': 'نور'},
  };
}
