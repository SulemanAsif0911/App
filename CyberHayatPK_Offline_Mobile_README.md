# Cyber Hayat PK — Offline-First Mobile Safety Platform

> **Awareness. Evidence. Support. Stay safe online.**

Cyber Hayat PK is an **offline-first, full-stack Android application** for people experiencing cyber harassment, online abuse, impersonation, stalking, doxing, sextortion, hate speech, disinformation, threats, and related digital-safety incidents.

The mobile app is designed so that its **core safety guidance remains available without an internet connection**. A victim can open the app in a low-connectivity area—or with no connectivity at all—and still access the guide, evidence checklist, safety instructions, cached resources, emergency contacts, case notes, complaint templates, and an **offline Cyber Hayat Assistant**.

When connectivity becomes available, the app can securely synchronize selected data with the Cyber Hayat backend.

---

## 1. Vision

Cyber Hayat PK should work as a **digital safety companion**, not merely as a website packaged into an APK.

The mobile experience should combine:

- 🛡️ Immediate safety guidance
- 📸 Evidence preservation
- 🔐 Account-security guidance
- 📝 Incident documentation
- 📂 Private case management
- 🤖 Offline chatbot assistance
- ☎️ Emergency/helpline access
- ⚖️ Legal-rights awareness
- 📄 Complaint-letter generation
- 📡 Offline-first synchronization
- 🌐 Online resource updates
- 🧑‍💻 Secure support-team backend

The guiding principle is:

> **The most important safety information must never depend on an internet connection.**

---

# 2. Current Cyber Hayat PK Website → Mobile App Mapping

The mobile application should preserve and significantly expand the current platform's core information architecture.

The current website contains:

- Home
- About
- Guide
- Chatbot
- Resources
- Helplines
- Incident reporting
- Case tracking
- Harassment library
- Legal-rights information
- Evidence checklist
- Security quiz
- Complaint-letter generator
- Anonymous stories
- Campus ambassador signup
- Press/partner section
- WhatsApp/community links
- Privacy policy
- Terms

The website's guide is organized around three major actions:

1. **Save the Evidence**
2. **Secure Your Accounts**
3. **Report and Reach Help**

The mobile application should retain this structure while adding offline functionality, local case storage, secure evidence handling, and an on-device assistant.

---

# 3. Core Mobile Navigation

Recommended bottom navigation:

```text
┌─────────────────────────────────────────────────────┐
│                  CYBER HAYAT PK                     │
├─────────────────────────────────────────────────────┤
│                                                     │
│              Current safety status                  │
│                                                     │
│       🚨 GET HELP       🤖 ASSISTANT                │
│                                                     │
│       📸 EVIDENCE       📚 RESOURCES                │
│                                                     │
├─────────────────────────────────────────────────────┤
│ Home │ Guide │ Assistant │ Cases │ More             │
└─────────────────────────────────────────────────────┘
```

### Main sections

- **Home**
- **Guide**
- **Offline Assistant**
- **My Cases**
- **Resources**
- **Helplines**
- **Evidence Vault**
- **Security Audit**
- **Complaint Generator**
- **Legal Rights**
- **Settings**

---

# 4. Home Screen

The home screen should immediately answer:

> **"What should I do right now?"**

### Components

- Cyber Hayat PK branding
- Current connection status:
  - `ONLINE`
  - `OFFLINE`
  - `SYNCING`
- Offline readiness indicator
- Emergency / Get Help button
- Talk to Assistant button
- Save Evidence button
- Secure Account button
- Report Incident button
- Recent case status
- Quick safety cards
- Latest locally cached safety notice
- Language selector

### Emergency state

The user should be able to enter **Safety Mode** from anywhere.

Safety Mode displays:

- Immediate safety instructions
- Cached helpline numbers
- "Do not delete evidence" reminder
- "Do not send more money/content" reminder where applicable
- Trusted-contact instructions
- Nearby emergency guidance when location data is available
- Offline assistant
- Quick evidence capture
- Exit/lock screen

The app must clearly distinguish between:

> **Information available offline**

and

> **Actual communication that requires connectivity.**

The app must never falsely claim that a complaint, call, message, or report was delivered while offline.

---

# 5. Guide Module

The existing Cyber Hayat guide follows:

## Step 01 — Save the Evidence

The app should explain how to preserve:

- Screenshots
- Screen recordings
- Messages
- Usernames
- Profile URLs
- Phone numbers
- Email addresses
- Dates
- Timestamps
- Posts
- Comments
- Threats
- Payment requests
- Account IDs
- Relevant platform information

### Advanced evidence workflow

```text
Capture
   ↓
Review
   ↓
Redact sensitive information if necessary
   ↓
Add metadata
   ↓
Generate SHA-256 hash
   ↓
Encrypt locally
   ↓
Store in Evidence Vault
   ↓
Add to Case Timeline
```

---

## Step 02 — Secure Your Accounts

Offline instructions should cover:

- Password changes
- Unique passwords
- Password-manager awareness
- Two-factor authentication
- Recovery email
- Recovery phone
- Active sessions
- Connected applications
- Privacy settings
- Blocking/reporting
- Device security
- SIM/account security
- Trusted contacts

The app should never request or store a user's actual password.

---

## Step 03 — Report and Reach Help

The app should provide:

- Official reporting guidance
- Cached official portal information
- Complaint preparation
- Evidence checklist
- Case reference storage
- Support-team submission when online
- Helpline information
- Complaint-letter generator

Official websites should always be opened externally or through the system browser when internet access is required.

---

# 6. Offline Cyber Hayat Assistant 🤖

## The most important feature

The mobile app must contain a **fully offline safety assistant**.

A victim should be able to use the assistant:

- Without Wi-Fi
- Without mobile data
- In airplane mode
- During network outages
- In remote areas
- While travelling
- In places with weak connectivity
- Even in an environment such as a ship or remote location

### Important limitation

If the phone has no connectivity, the assistant **cannot contact a helpline, police, NCCIA/FIA, Cyber Hayat support staff, or any external service**.

Instead, it must provide locally stored guidance and clearly say when an action requires connectivity.

---

# 7. Offline Assistant Architecture

Use a layered architecture rather than depending entirely on a cloud AI API.

```text
                 ┌───────────────────────┐
                 │   User Message        │
                 └───────────┬───────────┘
                             ↓
                 ┌───────────────────────┐
                 │ Safety Classifier     │
                 │ + Intent Detection    │
                 └───────────┬───────────┘
                             ↓
          ┌──────────────────┼──────────────────┐
          ↓                  ↓                  ↓
     Emergency          Harassment         General
      Detection          Category          Guidance
          ↓                  ↓                  ↓
     Safety Rules       Local KB/RAG       Local KB/RAG
          └──────────────────┼──────────────────┘
                             ↓
                  ┌─────────────────────┐
                  │ Response Generator  │
                  └──────────┬──────────┘
                             ↓
                  ┌─────────────────────┐
                  │ Safe Response       │
                  │ + Next Actions      │
                  └─────────────────────┘
```

---

# 8. Three-Level Offline AI

## Level 1 — Deterministic Safety Engine

Always available.

Use:

- Intent matching
- Keyword detection
- Decision trees
- Structured safety playbooks
- Local FAQ database
- Emergency rules
- Evidence checklists

This guarantees that essential guidance works even on low-end phones.

---

## Level 2 — Offline Retrieval / RAG

Bundle a local knowledge base containing:

- Cyber Hayat Guide
- Harassment library
- Safety procedures
- Evidence procedures
- Account-security guidance
- Complaint preparation
- Legal-awareness content
- Helpline information
- FAQ
- Platform reporting instructions
- Multilingual guidance

Use local retrieval to find the most relevant passages.

Possible implementation:

- SQLite / FTS5
- Local vector index
- Embedded metadata
- Chunked Markdown/JSON knowledge base

---

## Level 3 — Optional On-Device LLM

For compatible Android devices, optionally bundle a small quantized model.

Possible runtimes:

- `llama.cpp`
- `MLC`
- `MediaPipe / LiteRT-compatible local inference`
- Another open-source Android-compatible inference runtime

The LLM must be **optional** because model size and RAM requirements vary significantly between devices.

### Recommended fallback

```text
On-device LLM available?
        │
   ┌────┴────┐
  YES       NO
   │          │
Local LLM   Local RAG
   │          │
   └────┬─────┘
        ↓
Safety Rule Engine
        ↓
Final Response
```

The application must never become unusable merely because the local LLM cannot run.

---

# 9. Offline Assistant Safety Rules

The assistant should be trained/configured as a **support and safety navigator**, not as an unrestricted general chatbot.

It should:

- Stay calm
- Avoid victim blaming
- Ask only necessary questions
- Avoid requesting passwords
- Avoid requesting unnecessary intimate content
- Encourage evidence preservation
- Identify urgent physical-safety situations
- Encourage trusted-person support
- Explain when professional/legal help is appropriate
- Clearly distinguish general information from legal advice
- Provide actionable next steps
- Prefer short instructions during emergencies
- Work in the selected language

### Example

User:

> "Someone is threatening to publish my private pictures."

Assistant:

```text
First: do not send more images or money.

1. Save the threats and account details.
2. Record usernames, links, dates and payment requests.
3. Do not delete the conversation before preserving evidence.
4. Tell a trusted person if you can do so safely.
5. Use the official reporting route when connectivity is available.

I can now help you create an evidence checklist.
```

---

# 10. Multilingual Offline Support

The application should support:

- English
- Urdu
- Punjabi
- Sindhi
- Pashto

Architecture:

```text
User Language
     ↓
Intent Detection
     ↓
Language-specific Knowledge Base
     ↓
Safety Engine
     ↓
Response
```

Language packs should be downloadable/updateable when online and remain available offline afterward.

---

# 11. Resources Module

The Resources page should become a complete **Cyber Safety Action Center**.

## 01 — Incident Report

Allow the user to create a private incident record.

Fields:

- Case ID
- Incident type
- Platform
- Approximate date
- Description
- Username
- Profile URL
- Phone/email
- Threat level
- Evidence count
- Notes
- Status
- Created date
- Updated date

### Offline behavior

If offline:

```text
Create case locally
       ↓
Encrypt
       ↓
Add to Sync Queue
       ↓
Show "Saved Offline"
       ↓
Sync automatically when online
```

---

# 12. Case Tracker

Store:

- Cyber Hayat case reference
- Official complaint/acknowledgement number
- Submission date
- Organization
- Status
- Follow-up date
- Notes
- Attachments

Possible states:

```text
Draft
Saved Offline
Ready to Sync
Submitted
Acknowledged
Follow-up Required
Resolved
Closed
```

The app must never invent or fabricate an official case status.

---

# 13. Harassment Library

Include structured explainers for:

- Cyber stalking
- Doxing
- Sextortion
- Impersonation
- Hate speech
- Disinformation
- Bullying
- Extortion
- Threats
- Account takeover
- Privacy abuse
- Non-consensual intimate-image abuse
- Fake profiles
- Online blackmail

Each article should contain:

```text
What it means
↓
Warning signs
↓
What to save
↓
What NOT to do
↓
Account safety
↓
Reporting options
↓
When to seek urgent help
```

Content should include a visible:

- Last reviewed date
- Source
- Version
- Disclaimer

---

# 14. Legal Rights Module

Create an offline legal-awareness library.

Topics can include:

- PECA awareness
- Cyber stalking
- Identity information misuse
- Privacy-related harms
- Online threats
- Relevant reporting processes
- Evidence preservation

### Critical requirement

Legal information must display:

> **This is general awareness information, not legal advice. Laws and procedures can change. Verify current requirements with official sources or qualified legal professionals.**

Every legal document should contain:

```text
source_url
source_name
last_verified
content_version
jurisdiction
```

When online, the app can check for updated versions.

---

# 15. Evidence Checklist Generator

The user selects:

```text
Cyber Stalking
Doxing
Sextortion
Impersonation
Hate Speech
Disinformation
Bullying
Extortion
Other
```

The application generates a customized checklist.

Example:

```text
☐ Screenshot profile
☐ Save profile URL
☐ Capture username
☐ Capture threatening messages
☐ Record date/time
☐ Save phone number/email
☐ Save payment demand
☐ Preserve original files
☐ Record platform name
☐ Add incident notes
```

The checklist must work completely offline.

---

# 16. Evidence Vault

A secure local vault should be included.

### Features

- AES-encrypted local storage
- App PIN
- Biometric unlock where available
- Auto-lock
- Screenshot protection where supported
- Hidden previews
- Evidence categories
- Search
- Tags
- Case linking
- Hash generation
- Export
- Secure deletion workflow

### Evidence metadata

Store:

```text
filename
SHA-256 hash
created_at
captured_at
platform
case_id
mime_type
size
notes
```

Avoid altering the original evidence file.

If a processed/redacted copy is created, preserve it separately.

---

# 17. Privacy / Redaction Tools

Add a local privacy utility that can:

- Blur faces
- Blur phone numbers
- Blur email addresses
- Blur addresses
- Blur usernames
- Black-box sensitive text
- Crop screenshots
- Remove unnecessary metadata from exported copies

The original evidence must remain untouched.

---

# 18. Security Audit

The website currently provides a password/safety quiz.

The mobile version should expand this into an offline **Security Health Check**.

Checks:

- 2FA enabled?
- Unique passwords?
- Recovery email secure?
- Recovery phone current?
- Privacy settings reviewed?
- Unknown sessions checked?
- Suspicious apps?
- Device lock enabled?
- Backup configured?
- Trusted contact available?

Never send actual passwords to the backend.

---

# 19. Complaint Letter Generator

Generate a structured complaint document from:

- Name
- City
- Incident type
- Platform
- Account/number
- Date
- Summary
- Evidence list
- Relevant case reference

Export formats:

- PDF
- TXT
- Share sheet

The user must review the generated letter before submission.

---

# 20. Helplines Module

Create a locally cached emergency directory.

Each entry:

```text
Organization
Category
Phone
Website
Availability
Jurisdiction
Last verified
Source
```

Current website content includes:

- Punjab Women's Toll-Free Helpline — 1043
- National Cyber Crime Investigation Agency — 1799
- Federal Investigation Agency — 9911
- Digital Rights Foundation — 0800-39393

These values must be treated as **versioned data**, not hard-coded forever.

The app should periodically verify/update them when online.

### Offline call behavior

If the device supports calls:

```text
Tap Call
   ↓
Open Android dialer
```

The app must not claim that the call succeeded.

---

# 21. Offline-First Data Model

Recommended local database:

### SQLite

Suggested tables:

```text
users
cases
case_events
evidence
evidence_tags
checklists
checklist_items
resources
legal_documents
helplines
knowledge_chunks
chat_sessions
chat_messages
complaint_drafts
settings
language_packs
sync_queue
audit_events
```

---

# 22. Backend Architecture

Recommended backend:

```text
                    Mobile App
                        │
                 HTTPS / REST API
                        │
              ┌─────────▼─────────┐
              │    API Gateway    │
              └─────────┬─────────┘
                        │
        ┌───────────────┼────────────────┐
        │               │                │
   Authentication   Case Service   Resource Service
        │               │                │
        └───────────────┼────────────────┘
                        │
               ┌────────▼────────┐
               │   PostgreSQL    │
               └────────┬────────┘
                        │
              ┌─────────▼─────────┐
              │ Encrypted Object  │
              │ Storage / Files   │
              └───────────────────┘
```

---

# 23. Backend Responsibilities

The backend should handle:

- Authentication
- User accounts
- Anonymous/pseudonymous sessions
- Case records
- Support-team cases
- Resource updates
- Helpline updates
- Legal-content versions
- Knowledge-base versions
- Secure synchronization
- Complaint drafts
- Ambassador applications
- Anonymous stories
- Community moderation
- Audit logs
- Notifications
- Admin dashboard

The mobile app must remain functional even when the backend is unavailable.

---

# 24. Recommended Backend Stack

Use a free/open-source stack during development.

### Mobile

**Flutter + Dart**

Why:

- Android APK/AAB
- Strong offline support
- One codebase
- SQLite integrations
- Good UI performance
- Easy local encryption/inference integration

### Backend

**FastAPI + Python**

Recommended services:

```text
FastAPI
Pydantic
SQLAlchemy
Alembic
PostgreSQL
JWT/session authentication
REST API
OpenAPI
```

### Local database

```text
SQLite
Drift
```

### Optional local inference

```text
llama.cpp / compatible Android runtime
```

### Web admin

```text
React + TypeScript
```

### Deployment principle

Use open-source/self-hostable components so the project is not permanently tied to a paid AI API or proprietary backend.

---

# 25. API Structure

Suggested API:

```text
/api/v1/auth
/api/v1/users
/api/v1/cases
/api/v1/cases/{id}
/api/v1/evidence
/api/v1/resources
/api/v1/helplines
/api/v1/legal
/api/v1/knowledge
/api/v1/chat
/api/v1/complaints
/api/v1/stories
/api/v1/ambassadors
/api/v1/sync
/api/v1/health
```

Example:

```http
POST /api/v1/cases
GET  /api/v1/cases
GET  /api/v1/cases/{id}
PATCH /api/v1/cases/{id}
POST /api/v1/sync
GET  /api/v1/resources/version
GET  /api/v1/helplines/version
```

---

# 26. Offline Synchronization

Use an **outbox/sync queue**.

```text
User creates case
       ↓
Write to SQLite
       ↓
Create sync_queue item
       ↓
Internet unavailable?
       │
      YES
       ↓
Keep locally
       ↓
Internet becomes available
       ↓
Authenticate
       ↓
Sync changes
       ↓
Server acknowledges
       ↓
Mark queue item complete
```

### Conflict handling

Use:

- UUIDs
- `created_at`
- `updated_at`
- version numbers
- optimistic concurrency
- deterministic conflict rules

Never overwrite user evidence silently.

---

# 27. Privacy Architecture

Cyber Hayat deals with potentially extremely sensitive information.

Therefore:

### Default principles

- Data minimization
- Local-first
- Encryption at rest
- Encryption in transit
- No passwords
- No unnecessary permissions
- No hidden tracking
- No advertising SDKs
- No selling data
- Explicit consent
- Clear retention policy
- User-controlled deletion
- Audit logging
- Secure backups

### Sensitive information should not be logged.

Never place in normal application logs:

```text
Passwords
Private images
Private messages
Phone numbers
Emails
Complaint details
Authentication tokens
Chat contents
```

---

# 28. Anonymous Mode

Allow the user to use core features without creating an account.

Anonymous mode should provide:

- Guide
- Offline assistant
- Evidence checklist
- Security audit
- Legal awareness
- Helplines
- Complaint template
- Local case notes

When online, the user can optionally create an account or submit selected information.

---

# 29. Secure Account Mode

Optional authenticated mode:

```text
Email / supported authentication
        ↓
Secure session
        ↓
Encrypted local credentials
        ↓
Backend sync
```

Avoid requiring registration for emergency guidance.

---

# 30. Admin Dashboard

Build a secure web dashboard for authorized Cyber Hayat staff.

### Dashboard

```text
Cases
├── New
├── Pending
├── Urgent
├── Follow-up
└── Closed

Resources
├── Guides
├── Helplines
├── Legal
└── Knowledge Base

Community
├── Stories
├── Ambassadors
└── Partners

System
├── Users
├── Audit Logs
├── Sync Health
└── Content Versions
```

### Admin capabilities

- Review support-team reports
- Assign cases
- Change case status
- Add internal notes
- Publish resource updates
- Update helplines
- Update legal references
- Moderate anonymous stories
- Review ambassador applications
- Publish knowledge-base versions

Use strict role-based access control.

---

# 31. Roles

Suggested roles:

```text
USER
SUPPORT_AGENT
SENIOR_SUPPORT
CONTENT_EDITOR
ADMIN
SUPER_ADMIN
```

Permissions must be granular.

Example:

```text
CONTENT_EDITOR
    → Can update educational content
    → Cannot read private case evidence

SUPPORT_AGENT
    → Can read assigned support cases
    → Cannot change system settings

ADMIN
    → Can manage users/content/cases

SUPER_ADMIN
    → Full system administration
```

---

# 32. Chat Privacy

The offline assistant should default to:

> **Local conversation**

Chat messages should remain on-device unless the user explicitly chooses a cloud/support feature.

If a user submits a conversation to the support team:

```text
Show exactly what will be shared
        ↓
User confirms
        ↓
Encrypt
        ↓
Upload when online
```

No silent chat uploading.

---

# 33. "Middle of the Ocean" Offline Scenario

This is a key design requirement.

Imagine:

> A victim is on a ship with no Wi-Fi and no mobile signal.

The app should still provide:

```text
OPEN APP
   ↓
OFFLINE MODE
   ↓
"Are you in immediate physical danger?"
   ↓
     YES
      │
      ├── Immediate safety instructions
      ├── Trusted-person guidance
      ├── Local emergency information if available
      └── Offline assistant

     NO
      │
      ├── Identify incident
      ├── Preserve evidence
      ├── Secure account
      ├── Build evidence checklist
      ├── Create private case
      ├── Draft complaint
      └── Prepare actions for when connectivity returns
```

The application must never pretend that it can reach an external authority without connectivity.

---

# 34. Offline Content Bundle

Bundle a versioned content package:

```text
assets/
└── knowledge/
    ├── guide/
    ├── harassment/
    ├── evidence/
    ├── account_security/
    ├── legal/
    ├── helplines/
    ├── reporting/
    ├── faq/
    └── languages/
```

Example:

```json
{
  "version": "2026.09.01",
  "jurisdiction": "Pakistan",
  "language": "en",
  "last_verified": "2026-09-01"
}
```

The application checks for a newer package when online.

---

# 35. Resource Update System

Do not require a new APK whenever a helpline or educational article changes.

Use:

```text
Bundled baseline content
        +
Signed remote content updates
        =
Current offline knowledge
```

Updates should be:

- Versioned
- Signed
- Validated
- Cached
- Rollback-capable

If an update fails validation, keep the previous known-good content.

---

# 36. Security Architecture

Use:

- HTTPS
- TLS
- Secure token storage
- Short-lived access tokens
- Refresh-token rotation
- Certificate/public-key pinning where appropriate
- Rate limiting
- Input validation
- SQL parameterization
- CSRF protection where applicable
- RBAC
- Audit logs
- Secure headers
- Database encryption/backups
- Secret management
- Dependency scanning
- Static analysis
- Automated tests

---

# 37. Threat Model

Threats to consider:

### Device theft

Mitigation:

- App lock
- Encryption
- Auto-lock
- Minimal notifications
- Hidden evidence previews

### Malicious app

Mitigation:

- Secure storage
- Minimal permissions
- No unnecessary exported components

### Account takeover

Mitigation:

- Strong authentication
- Session management
- 2FA where appropriate

### Backend breach

Mitigation:

- Encryption
- Data minimization
- RBAC
- Separate sensitive storage
- Audit logs

### Insider access

Mitigation:

- Least privilege
- Case assignment
- Access logs
- Admin auditing

### Network interception

Mitigation:

- HTTPS
- Secure certificate validation
- No sensitive HTTP traffic

---

# 38. Permissions

Request only what is actually needed.

Possible permissions:

- Notifications
- Camera — only for evidence capture
- Photos/media — only for user-selected evidence
- Phone — only to initiate a call through the dialer
- Location — optional and only for explicitly requested safety features

Do not request:

- Contacts
- Microphone
- SMS
- Accessibility
- Call logs

unless a clearly defined feature genuinely requires them.

---

# 39. Notifications

Notifications should never expose sensitive incident details.

Bad:

```text
"Sextortion case update: Ahmed threatened you again."
```

Better:

```text
"Cyber Hayat: You have a case update."
```

Allow users to disable sensitive notifications.

---

# 40. UI/UX Direction

The interface should be:

- Hyper professional
- Calm
- Trustworthy
- Modern
- Premium
- Accessible
- Fast
- Minimal
- Cyber-safety focused
- Not cartoonish

### Visual direction

Use a dark professional foundation with restrained accent colors.

Suggested design language:

```text
Dark surfaces
Soft gradients
Thin borders
Subtle glow
Rounded cards
Clear typography
Large emergency actions
Minimal animation
High contrast
```

Avoid:

- Excessive neon
- Hacker clichés
- Aggressive animations
- Clutter
- Fake "cyber" terminal effects
- Overly gamified emergency screens

---

# 41. Accessibility

Support:

- Large text
- Screen readers
- High contrast
- Reduced motion
- Voice-friendly navigation
- RTL Urdu layout
- Large touch targets
- Clear error messages
- Offline indicators

Urdu should use proper RTL layout rather than simply changing the font.

---

# 42. Performance Requirements

Target:

- Fast cold start
- Smooth scrolling
- Low memory usage
- Offline operation
- Efficient image loading
- Background sync only when appropriate
- Battery-conscious synchronization
- Lazy loading
- Local caching

The app should remain usable on mid-range Android devices.

---

# 43. APK / Build Requirements

Development:

```bash
flutter pub get
flutter analyze
flutter test
flutter build apk --release
```

Release:

```bash
flutter build appbundle --release
```

Recommended:

```text
APK → direct testing/sideloading
AAB → Play Store distribution
```

Never embed production secrets inside the APK.

---

# 44. Suggested Project Structure

```text
cyber-hayat-mobile/
│
├── android/
├── ios/
│
├── lib/
│   ├── main.dart
│   │
│   ├── core/
│   │   ├── security/
│   │   ├── networking/
│   │   ├── storage/
│   │   ├── sync/
│   │   ├── localization/
│   │   └── error_handling/
│   │
│   ├── features/
│   │   ├── home/
│   │   ├── guide/
│   │   ├── assistant/
│   │   ├── cases/
│   │   ├── evidence/
│   │   ├── resources/
│   │   ├── helplines/
│   │   ├── legal/
│   │   ├── security_audit/
│   │   ├── complaint_generator/
│   │   ├── stories/
│   │   └── settings/
│   │
│   ├── data/
│   │   ├── database/
│   │   ├── repositories/
│   │   ├── api/
│   │   └── models/
│   │
│   └── shared/
│       ├── widgets/
│       ├── theme/
│       └── utilities/
│
├── backend/
│   ├── app/
│   │   ├── api/
│   │   ├── auth/
│   │   ├── cases/
│   │   ├── resources/
│   │   ├── legal/
│   │   ├── helplines/
│   │   ├── knowledge/
│   │   ├── sync/
│   │   └── admin/
│   │
│   ├── migrations/
│   ├── tests/
│   └── requirements.txt
│
├── admin-web/
│
├── content/
│   ├── knowledge/
│   ├── legal/
│   ├── helplines/
│   └── languages/
│
├── docs/
│   ├── architecture.md
│   ├── security.md
│   ├── privacy.md
│   ├── api.md
│   └── threat-model.md
│
└── README.md
```

---

# 45. Cost-Free Development Strategy

The application should be designed to avoid mandatory paid APIs.

### No mandatory:

- OpenAI API
- Anthropic API
- Google Gemini API
- Paid chatbot API
- Paid analytics
- Paid authentication service
- Paid database
- Paid storage

### Core offline functionality

```text
Flutter
+
SQLite
+
Local knowledge base
+
Rule engine
+
Optional open-source on-device model
=
Offline Cyber Hayat Assistant
```

### Backend

Use open-source software and deploy it on infrastructure that fits the project's available free/self-hosted resources.

The application must remain functional if the backend is completely offline.

---

# 46. Analytics Philosophy

Do not build invasive tracking.

If analytics are added, prefer:

- Anonymous aggregate events
- Opt-in telemetry
- No message content
- No evidence content
- No passwords
- No personal case details

Example:

```text
guide_opened
assistant_opened
offline_mode_used
checklist_completed
```

Not:

```text
user_message
evidence_image
private_case_description
```

---

# 47. Testing Strategy

## Unit tests

Test:

- Safety rules
- Intent classification
- Evidence hashing
- Encryption
- Database
- Sync queue
- Conflict resolution
- Checklist generation
- Complaint generation

## Integration tests

Test:

- Offline → online sync
- Authentication
- Case creation
- Evidence upload
- Resource updates
- Content rollback

## UI tests

Test:

- Home
- Guide
- Assistant
- Cases
- Evidence Vault
- Helplines
- Settings
- RTL Urdu

## Security tests

Test:

- Authentication
- Authorization
- Injection
- Session handling
- Sensitive logging
- Local storage
- Backup handling
- API rate limiting

---

# 48. Offline Test Matrix

The application should be tested under:

```text
Wi-Fi ON
Mobile Data ON
Wi-Fi OFF
Mobile Data OFF
Airplane Mode
Intermittent Network
Very Slow Network
Server Unavailable
DNS Failure
Expired Session
Corrupt Sync Queue
Low Storage
Low Battery
App Restart During Sync
Device Restart During Sync
```

Critical safety features must remain usable.

---

# 49. Data Retention

The project should define explicit retention rules.

For example:

```text
Local draft
→ User controlled

Submitted support case
→ Retained according to published policy

Evidence
→ User controlled unless explicitly uploaded

Analytics
→ Minimal and anonymized

Chat
→ Local by default
```

Do not silently retain sensitive content indefinitely.

---

# 50. Privacy Policy Requirements

The final app should document:

- What data is collected
- Why it is collected
- Where it is stored
- What stays on the device
- What is uploaded
- Who can access support cases
- How long data is retained
- How users can request deletion
- What happens during synchronization
- What happens if the device is lost
- Third-party services
- Legal disclosures

---

# 51. Emergency Safety Disclaimer

The application should clearly state:

> Cyber Hayat PK provides safety information and support-navigation tools. It is not a replacement for emergency services, law enforcement, qualified legal advice, or professional mental-health care.

If someone is in immediate physical danger, the app should encourage them to seek immediate local emergency assistance or a trusted nearby person.

---

# 52. Content Governance

Every official resource should have:

```text
title
category
jurisdiction
source
source_url
version
published_at
last_reviewed
reviewed_by
expires_at
```

This is especially important for:

- Helpline numbers
- Government portals
- Legal information
- Reporting procedures

---

# 53. Future Advanced Features

Possible future modules:

### AI Evidence Organizer

Automatically organize user-selected evidence by:

- Date
- Platform
- Case
- Evidence type

### Timeline Builder

```text
Incident
 ↓
First message
 ↓
Threat
 ↓
Account action
 ↓
Evidence saved
 ↓
Report submitted
 ↓
Follow-up
```

### Safety Plan

Create a personal step-by-step safety plan.

### Trusted Contact

Allow the user to prepare a trusted-contact notification.

### Offline Emergency Card

One-tap display of:

- Essential instructions
- Emergency contacts
- Medical/safety notes voluntarily entered by the user

### QR Emergency Information

Generate an optional QR containing only user-approved emergency information.

### Local File Integrity

Generate hashes for evidence and export a verification manifest.

---

# 54. Project Principles

Cyber Hayat PK must follow these principles:

1. **Safety first**
2. **Offline first**
3. **Privacy by design**
4. **Evidence preservation**
5. **User control**
6. **No victim blaming**
7. **No unnecessary data collection**
8. **Transparent AI**
9. **No fabricated information**
10. **No fake reporting confirmations**
11. **Accessible to non-technical users**
12. **Free/open-source-first architecture**

---

# 55. Definition of Done

The project is ready for a production beta when:

- [ ] Android APK builds successfully
- [ ] App works without internet
- [ ] Offline assistant works
- [ ] Guide is available offline
- [ ] Helplines are cached
- [ ] Resource library works offline
- [ ] Evidence Vault is encrypted
- [ ] Evidence hashes work
- [ ] Cases can be created offline
- [ ] Sync queue works
- [ ] Complaint letters can be generated offline
- [ ] Security audit works offline
- [ ] Urdu RTL works
- [ ] Backend authentication works
- [ ] API authorization works
- [ ] Admin dashboard works
- [ ] Resource versioning works
- [ ] Helpline updates work
- [ ] Security testing is completed
- [ ] Privacy policy is published
- [ ] Terms are published
- [ ] Backup/recovery process is tested
- [ ] Sensitive data is excluded from logs
- [ ] Emergency limitations are clearly disclosed

---

# 56. Final Product

The final Cyber Hayat PK application should feel like:

> **A private digital safety companion that remains useful even when the internet disappears.**

The app should not be a simple APK wrapper around the website.

It should be a complete:

```text
                 CYBER HAYAT PK
                       │
       ┌───────────────┼────────────────┐
       │               │                │
   EDUCATION        PROTECTION        SUPPORT
       │               │                │
    Guide          Evidence Vault    Helplines
    Resources      Security Audit    Case System
    Legal          Privacy Tools     Reporting
       │               │                │
       └───────────────┼────────────────┘
                       │
                OFFLINE ASSISTANT
                       │
                 LOCAL KNOWLEDGE
                       │
                 OFFLINE-FIRST APP
                       │
                SECURE FULL STACK
                       │
              OPTIONAL ONLINE SYNC
```

**Cyber Hayat PK — Awareness. Evidence. Support. Stay safe online.**


---

# 4. Premium Application Launch Experience

The application must **not** look like a website wrapped inside an APK or a generic Flutter application.

The first seconds of the application experience should establish Cyber Hayat PK as a **serious, premium, privacy-focused digital safety platform**.

## 4.1 Launch Experience

The app should use a native Android splash screen for immediate launch, followed by a short custom branded transition.

Recommended sequence:

```text
APP LAUNCH
     │
     ▼
┌─────────────────────────────┐
│      Deep Dark Background   │
│                             │
│       CYBER HAYAT PK        │
│          EMBLEM             │
└──────────────┬──────────────┘
               │
               ▼
     Subtle digital grid
        fades in
               │
               ▼
     Cyber Hayat emblem
       reveals precisely
               │
               ▼
       Controlled light
          sweep
               │
               ▼
        CYBER HAYAT PK
               │
               ▼
 Digital Safety • Support • Awareness
               │
               ▼
       OFFLINE READY
               │
               ▼
          HOME SCREEN
```

## 4.2 Visual Direction

The startup screen should feel similar to a **premium cybersecurity / digital-security product**, not a gaming intro.

### Required visual characteristics

- Deep black / dark navy foundation
- Extremely subtle digital texture
- Precise geometric logo treatment
- High-quality typography
- Restrained blue/cyan accent lighting
- Very subtle glass/light effects
- Soft depth and contrast
- Clean negative space
- Professional motion design
- No visual clutter

### Avoid

- Cartoon animations
- Excessive neon
- Hacker-terminal clichés
- Matrix-style falling characters
- Spinning generic loaders
- Excessive particles
- Gaming-style explosions
- Loud startup effects
- Long animations

The visual language should communicate:

> **Trust • Privacy • Protection • Professionalism**

---

# 4.3 Logo Animation

The Cyber Hayat PK logo should be the visual focus.

Suggested animation:

```text
Dark screen
    ↓
Very subtle ambient glow
    ↓
Logo geometry begins appearing
    ↓
Shield / emblem structure completes
    ↓
Controlled light sweep across emblem
    ↓
Logo settles
    ↓
CYBER HAYAT PK fades in
    ↓
Subtitle appears
```

The animation should feel **engineered and precise**, not flashy.

### Animation requirements

- 60 FPS
- Hardware accelerated
- 800–1500 ms total branded animation
- No network dependency
- No external API dependency
- No blocking operations
- No sound required
- Respect Android reduced-motion/accessibility settings
- Skip unnecessary animation on repeated launches where appropriate

---

# 4.4 Offline-First Startup

The splash screen must work completely without internet.

The app must **never wait for the server before showing the main application**.

Startup flow:

```text
Launch
  ↓
Native splash
  ↓
Load local configuration
  ↓
Load local database
  ↓
Load offline knowledge base
  ↓
Initialize security services
  ↓
Check connectivity in background
  ↓
Open Home
```

Connectivity should be represented as application state:

```text
ONLINE
OFFLINE
SYNCING
```

Offline mode is **not an error state**.

---

# 4.5 Professional Offline Indicator

When the application launches without internet, the user can see a subtle indicator such as:

```text
CYBER HAYAT PK

Digital Safety • Support • Awareness

● OFFLINE READY
```

Do not display alarming messages such as:

```text
ERROR: INTERNET NOT FOUND
```

The application is intentionally designed to operate offline.

---

# 4.6 First Launch

On the first launch, after the logo animation, display a concise onboarding sequence.

### Screen 1

```text
CYBER HAYAT PK

Your digital safety companion.

Continue
```

### Screen 2

```text
WORKS OFFLINE

Core safety guidance, resources,
checklists and assistance remain
available without internet.

Continue
```

### Screen 3

```text
YOUR PRIVACY MATTERS

Sensitive information can remain
on your device unless you choose
to share it.

Continue
```

### Screen 4

```text
READY WHEN YOU NEED IT

Cyber Hayat PK is ready to help
you understand, preserve evidence
and find the right next step.

Get Started
```

The onboarding must be skippable where appropriate.

---

# 4.7 Application Identity

The application should consistently use:

```text
CYBER HAYAT PK
```

Primary positioning:

```text
Digital Safety • Support • Awareness
```

Optional product description:

```text
An offline-first digital safety companion.
```

The branding should remain consistent across:

- Splash screen
- App icon
- Home screen
- Notifications
- Assistant
- Evidence Vault
- Case management
- Reports
- Settings
- PDF exports
- Complaint documents
- Admin dashboard

---

# 4.8 Android App Icon

The Android launcher icon should be a dedicated Cyber Hayat PK icon rather than a screenshot of the website.

Requirements:

- Adaptive Android icon
- Clean emblem
- High contrast
- Recognizable at small sizes
- No tiny text
- No unnecessary details
- Professional cybersecurity aesthetic
- Light/dark launcher compatibility where appropriate

Recommended structure:

```text
        ┌───────────────┐
        │               │
        │    CYBER      │
        │     HAYAT     │
        │    EMBLEM     │
        │               │
        └───────────────┘
```

The detailed wordmark should remain inside the application; the launcher icon should prioritize the emblem.

---

# 4.9 Home Transition

After initialization, the splash should transition smoothly into the Home screen.

Recommended transition:

```text
Splash
  ↓
Logo remains centered
  ↓
Background expands into application surface
  ↓
Home content fades/slides into place
  ↓
Logo becomes the Home navigation identity
```

Avoid abrupt:

```text
Splash → white screen → Home
```

or:

```text
Splash → loading spinner → Home
```

---

# 4.10 Startup Performance

The branded experience must not compromise usability.

Target:

```text
Native splash:
Immediate

Local initialization:
Fast

Branded animation:
~0.8–1.5 seconds

Home:
Available as soon as essential local services initialize
```

Non-critical operations such as:

- Resource synchronization
- Remote content checking
- Analytics initialization
- Knowledge-base updates
- Server health checks

must happen **after the core application becomes usable**.

---

# 4.11 Startup Failure Handling

If the backend is unavailable:

```text
Continue into application
        ↓
OFFLINE READY
```

If the internet is unavailable:

```text
Continue into application
        ↓
OFFLINE READY
```

If a remote content update fails:

```text
Keep last known-good local content
        ↓
Continue normally
```

If a non-critical service fails:

```text
Do not block the entire application.
```

Only critical local integrity/security failures should prevent access to the affected feature.

---

# 4.12 Brand Motion Principles

All Cyber Hayat PK animations should follow:

```text
Precise
     ↓
Subtle
     ↓
Fast
     ↓
Purposeful
     ↓
Professional
```

Animation should communicate state rather than exist only for decoration.

Examples:

```text
Syncing       → subtle progress animation
Saved         → small confirmation animation
Offline       → restrained status indicator
Evidence      → secure-lock animation
Assistant     → subtle processing indicator
Case created  → precise success transition
```

---

# 4.13 Final Startup Experience

The final experience should feel like:

> **A premium digital safety product that happens to work offline—not an offline website.**

The user should immediately understand:

```text
CYBER HAYAT PK

Digital Safety • Support • Awareness

Private
Professional
Offline-Ready
```

---
