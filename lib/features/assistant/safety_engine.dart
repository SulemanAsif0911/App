class AssistantResult {
  AssistantResult({
    required this.reply,
    required this.intent,
    required this.emergency,
    required this.needsConnectivity,
  });
  final String reply;
  final String intent;
  final bool emergency;
  final bool needsConnectivity;
}

class SafetyEngine {
  static const physical = [
    'kill', 'rape', 'coming to my house', 'has a weapon', 'i am being followed',
    'physical danger', 'they are here', 'break in',
  ];
  static const sextortion = [
    'private pictures', 'nude', 'nudes', 'sextort', 'publish my', 'leak my photos',
    'intimate', 'blackmail',
  ];
  static const money = ['send money', 'pay me', 'bitcoin', 'easypaisa', 'jazzcash', 'gift card'];
  static const stalking = ['stalk', 'follow me', 'tracking me', 'everywhere i go'];
  static const impersonation = ['fake profile', 'impersonat', 'pretending to be me'];
  static const takeover = ['hacked', 'can\'t login', 'account stolen', 'password changed'];
  static const passwordAsk = ['what is your password', 'tell me your password', 'otp code'];

  static AssistantResult respond(String raw, {String lang = 'en'}) {
    final t = raw.toLowerCase();
    if (physical.any(t.contains)) {
      return AssistantResult(
        intent: 'emergency_physical',
        emergency: true,
        needsConnectivity: true,
        reply: _short(lang, '''If you are in immediate physical danger, seek local emergency help or a trusted nearby person right now.

This app cannot contact police, FIA, NCCIA, or Cyber Hayat staff.

When you are safer:
1. Preserve threats without deleting conversations first.
2. Use Helplines to open the Android dialer (a call still needs a signal).
3. I can help you document what happened offline.'''),
      );
    }
    if (sextortion.any(t.contains) || (t.contains('pictures') && t.contains('threat'))) {
      return AssistantResult(
        intent: 'sextortion',
        emergency: false,
        needsConnectivity: false,
        reply: _short(lang, '''First: do not send more images or money.

1. Save the threats and account details.
2. Record usernames, links, dates and payment requests.
3. Do not delete the conversation before preserving evidence.
4. Tell a trusted person if you can do so safely.
5. Use the official reporting route when connectivity is available.

I can now help you create an evidence checklist.

I have not contacted any authority.'''),
      );
    }
    if (money.any(t.contains)) {
      return AssistantResult(
        intent: 'extortion_payment',
        emergency: false,
        needsConnectivity: false,
        reply: 'Do not send more money or gift cards. Save the payment demand, account names, and timestamps in Evidence Vault. Paying rarely stops the abuse. Prepare a complaint offline; submit only when you have connectivity.',
      );
    }
    if (stalking.any(t.contains)) {
      return AssistantResult(
        intent: 'stalking',
        emergency: false,
        needsConnectivity: false,
        reply: 'Treat repeated unwanted contact as cyber stalking. Block where safe, preserve messages and profile URLs, tighten account privacy, and document dates. If you fear physical harm, prioritize a safe location. Official reports need connectivity.',
      );
    }
    if (impersonation.any(t.contains)) {
      return AssistantResult(
        intent: 'impersonation',
        emergency: false,
        needsConnectivity: false,
        reply: 'Save the fake profile URL, screenshots, and any messages. Report the profile on the platform when online. Warn trusted contacts if someone is messaging in your name. Create a local case so you do not lose details.',
      );
    }
    if (takeover.any(t.contains)) {
      return AssistantResult(
        intent: 'account_takeover',
        emergency: false,
        needsConnectivity: false,
        reply: 'Use a device you trust. Recover via official account recovery — I will never ask for your password or OTP. Enable 2FA after you regain access, sign out other sessions, and note the time you lost access.',
      );
    }
    if (t.contains('password') && (t.contains('what is') || t.contains('tell'))) {
      return AssistantResult(
        intent: 'refuse_password',
        emergency: false,
        needsConnectivity: false,
        reply: 'I will never ask for or store your passwords. Change them in the official app or website of that service.',
      );
    }
    if (t.contains('call police') || t.contains('contact fia') || t.contains('tell nccia')) {
      return AssistantResult(
        intent: 'cannot_contact',
        emergency: false,
        needsConnectivity: true,
        reply: 'I cannot place calls or file complaints for you. Open Helplines to launch the Android dialer, or use official websites in the system browser when you have connectivity. Offline, I can only prepare evidence and drafts.',
      );
    }
    return AssistantResult(
      intent: 'general',
      emergency: false,
      needsConnectivity: false,
      reply: '''I am an offline safety navigator.

I can help you: identify the incident, preserve evidence, secure accounts, build a checklist, draft a complaint, and find cached helpline numbers.

I do not replace emergency services. I do not send reports while offline.

Tell me what happened, or open Guide for the three steps: Save evidence, Secure accounts, Report when you can.''',
    );
  }

  static String _short(String lang, String en) {
    if (lang == 'ur') {
      return 'پہلے: مزید تصاویر یا پیسے نہ بھیجیں۔ ثبوت محفوظ کریں۔ میں پولیس سے خود رابطہ نہیں کر سکتا۔\n\n$en';
    }
    return en;
  }

  static String classifyIntent(String raw) => respond(raw).intent;
}

class ChecklistGenerator {
  static List<String> forCategory(String category) {
    const base = [
      'Screenshot profile',
      'Save profile URL',
      'Capture username',
      'Capture threatening messages',
      'Record date/time',
      'Save phone number/email',
      'Preserve original files',
      'Record platform name',
      'Add incident notes',
    ];
    final extra = <String>[];
    switch (category.toLowerCase()) {
      case 'sextortion':
      case 'ncii':
        extra.addAll(['Save payment demand', 'Do not send further images', 'Note any cloud-album links']);
        break;
      case 'doxing':
        extra.addAll(['List leaked data types', 'Record where it was posted']);
        break;
      case 'impersonation':
        extra.addAll(['Archive fake profile', 'Collect witness reports']);
        break;
      case 'account takeover':
        extra.addAll(['Note recovery emails used', 'List unknown sessions']);
        break;
      default:
        extra.add('Save payment demand if any');
    }
    return [...base, ...extra];
  }
}

class ComplaintGenerator {
  static String build({
    required String name,
    required String city,
    required String incidentType,
    required String platform,
    required String account,
    required String date,
    required String summary,
    required List<String> evidence,
    String caseRef = '',
  }) {
    final ev = evidence.isEmpty ? '(none listed yet)' : evidence.map((e) => '- $e').join('\n');
    return '''
TO WHOM IT MAY CONCERN

Subject: Complaint regarding $incidentType on $platform

I, $name, currently in $city, wish to report an incident of $incidentType.

Approximate date: $date
Platform: $platform
Account / number: $account
Local case reference: ${caseRef.isEmpty ? 'not assigned' : caseRef}

Summary:
$summary

Evidence preserved (hashes and originals remain on my device unless I later choose to share them):
$ev

This document was generated by Cyber Hayat PK as a draft for the user to review. It is not a filed complaint and has not been submitted to any authority.

I request guidance on the appropriate official reporting process.

Respectfully,
$name
'''.trim();
  }
}
