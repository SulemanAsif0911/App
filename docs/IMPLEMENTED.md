# Implemented features

- Native Flutter Android app (not a WebView)
- Dark professional Material 3 UI
- Native splash + branded 1.2s animation with grid/light sweep, reduced-motion skip
- Four-screen skippable onboarding
- Bottom nav: Home | Guide | Assistant | Cases | More
- Home: status ONLINE/OFFLINE READY/SYNCING, emergency actions, language chips (en/ur/pa/sd/ps), RTL for Urdu
- Safety Mode from FAB
- Guide three steps from versioned JSON
- Offline assistant: keyword/intent engine + SQLite FTS retrieval; optional LLM interface returns unavailable
- Honest limitations (no fake police/FIA contact)
- Offline cases + sync queue (queue never marked complete without server ack)
- Evidence vault: SHA-256, AES copy on disk, camera/gallery
- Redaction produces a separate copy
- Harassment library (14 articles)
- Legal awareness + disclaimer
- Checklist generator
- Security health check (answers local only)
- Complaint PDF/TXT share drafts
- Versioned helplines + dialer (no call-success claim)
- PIN lock, anonymous mode, accessibility text scale / reduced motion
- FastAPI path stubs
- Unit tests for safety, hash, checklist, complaint, conflicts

# Known limitations

- **Release APK:** `cyber_hayat_pk.apk` (Flutter 3.24.5, Dart 3.5, minSdk 23, targetSdk 34, version 1.0.0+1). Built on GitHub Actions and committed to this branch.
- No production FastAPI/Postgres deployment; sync remains queued.
- No bundled on-device LLM weights.
- Helpline numbers are versioned baseline data — verify before emergency use.
- Biometric unlock is permission-ready; PIN is the implemented lock.
- Screenshot blocking is OS-dependent and not forced globally.
- Admin web dashboard is specified, not shipped in this APK codebase.
