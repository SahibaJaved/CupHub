🔐 FIREBASE & GOOGLE SIGN-IN SETUP GUIDE FOR ANDROID
=====================================================

⚠️ CRITICAL ISSUE FOUND:
Your google-services.json has EMPTY "oauth_client" array!
This is why Google Sign-In doesn't work.

---

## STEP 1: Generate Android Signing SHA-1 Fingerprint

Run this command in your project root:
```bash
cd android
./gradlew signingReport
```

Look for the SHA1 fingerprint in the output (it looks like):
```
Variant: debug
Config: debug
Store: ~/.android/debug.keystore
Alias: AndroidDebugKey
MD5: ...
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
SHA-256: ...
```

Copy the SHA1 value (without colons).

---

## STEP 2: Add SHA-1 to Firebase Console

1. Go to Firebase Console: https://console.firebase.google.com/
2. Select your project: "cuphub-33900"
3. Go to: Project Settings → Your Apps → Android App
4. Add your SHA1 fingerprint:
   - Click "Add Fingerprint"
   - Paste the SHA1 value
   - Click "Save"

---

## STEP 3: Configure Google OAuth Consent Screen

1. Go to Google Cloud Console: https://console.cloud.google.com/
2. Select project: "cuphub-33900"
3. Go to: APIs & Services → OAuth consent screen
4. Configure the consent screen (if not done):
   - User type: External
   - App name: "CupHub"
   - Add your email
   - Complete the form
   - Save

---

## STEP 4: Create Android OAuth Credentials

1. Go to Google Cloud Console
2. Go to: APIs & Services → Credentials
3. Click: "Create Credentials" → "OAuth 2.0 Client ID"
4. Select: "Android"
5. Configure:
   - Package name: com.example.cuphub
   - SHA-1 fingerprint: (paste your SHA1 from Step 1)
   - Click "Create"
6. Download the credentials

---

## STEP 5: Download Updated google-services.json

1. Go back to Firebase Console
2. Go to: Project Settings → Your Apps → Android App
3. Click: "Download google-services.json"
4. Replace the old file: android/app/google-services.json

---

## STEP 6: Verify Configuration

After replacing google-services.json:
1. Check the file contains "oauth_client" array with credentials
2. Run: flutter pub get
3. Run: flutter clean
4. Rebuild and test:
   ```bash
   flutter run
   ```

---

## EMAIL ACCOUNT PICKER FEATURES (NOW IMPLEMENTED ✅)

When user taps "Continue with Google":
1. Google account picker dialog appears
2. User can select from multiple emails
3. Selected email shows in confirmation message
4. Proper error handling for all scenarios

---

## KEY FIXES IMPLEMENTED:

✅ AuthService class for centralized auth logic
✅ Proper Google Sign-In with account picker
✅ Email confirmation after sign-in
✅ Better error messages for all scenarios
✅ Proper state management and loading states
✅ Error handling for network issues

---

## TEST CHECKLIST:

- [ ] SHA-1 fingerprint added to Firebase
- [ ] OAuth client configured in Google Cloud
- [ ] google-services.json updated
- [ ] Flutter clean & pub get
- [ ] Test email/password login
- [ ] Test Google sign-in (should show email picker)
- [ ] Test with multiple Google accounts on device
- [ ] Verify email displays after sign-in
- [ ] Test admin email special handling
- [ ] Test error scenarios (wrong password, no network, etc.)

---

Need help? Contact Firebase support or check:
https://firebase.flutter.dev/docs/auth/social#google
https://developers.google.com/identity/sign-in/android
