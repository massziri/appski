# Appski - Macedonian Community of Australia App

## 🇲🇰 Overview
Appski is a comprehensive community platform built with Flutter for the Macedonian Community of Australia Inc. Featuring 47+ screens across 5 main navigation tabs, the app brings together news, events, media streaming, business directory, Orthodox calendar, and much more.

**Version:** 1.0.0  
**Platform:** Android (Flutter)  
**Language:** Bilingual - English & Македонски (Macedonian)

## 🎨 Brand Colors
- **Macedonian Red** `#C41E3A` — Primary actions, highlights
- **Gold** `#D4A843` — Accents, premium elements
- **Dark Navy** `#1A1A2E` — Background, base theme
- **White** `#FFFFFF` — Text, icons, contrast

## 📱 Features

### Tab 1: Home (Дома)
- Hero banner carousel
- Latest news preview
- Featured event with countdown
- Featured businesses (horizontal scroll)
- Orthodox calendar entry of the day
- Weather snapshot
- Quick access grid (8 shortcuts)

### Tab 2: Discover (Откриј)
- **Business Directory** — Search, filter by category & state, detailed profiles with map
- **Organisations** — Churches, clubs, dance groups with leadership info
- **Recipes** — Traditional Macedonian cuisine (Tavče Gravče, Ajvar, Zelnik, etc.)
- **Tourism** — Discover Macedonia (Lake Ohrid, Matka Canyon, monasteries, etc.)

### Tab 3: Events (Настани)
- Upcoming events list with countdown
- Calendar view with color-coded event markers
- Event detail with RSVP, map, social sharing
- Past events archive

### Tab 4: Media (Медиуми)
- **Radio** — Live Macedonian radio stations (Antenna 5, Kanal 77, etc.) with Now Playing screen
- **TV** — Live TV streams (Maso TV, Tera TV)
- **News** — Bilingual news feed with categories

### Tab 5: More (Повеќе)
- **Orthodox Calendar** — Saints, feasts, fasting rules, name day lookup
- **Weather** — 20+ Macedonian cities forecast
- **Settings** — Language toggle, notifications
- **Submit a Listing** — Community contribution form
- **About, Contact, Privacy, Terms**

## 🏗️ Architecture

```
lib/
├── config/          # Theme, constants, router
├── models/          # Data models
├── providers/       # App state (Provider pattern)
├── screens/         # All 46+ screens organized by tab
├── services/        # Mock data (replace with Firebase)
├── widgets/         # Reusable components
└── main.dart        # Entry point
```

## 🚀 Getting Started

```bash
# Get dependencies
flutter pub get

# Run on Android device/emulator
flutter run

# Build APK
flutter build apk --release
```

## 🔧 Firebase Setup (To Be Done)
1. Create Firebase project
2. Add `google-services.json` to `android/app/`
3. Replace mock data in `lib/services/mock_data.dart` with Firebase calls
4. Configure Firebase Auth, Firestore, Cloud Messaging
5. Set up Firestore security rules

## 📋 Client Configuration Needed
- [ ] Firebase project setup + `google-services.json`
- [ ] Radio station stream URLs
- [ ] TV channel stream URLs
- [ ] Weather API key (OpenWeatherMap or WeatherAPI.com)
- [ ] Google Maps API key
- [ ] Orthodox calendar data import
- [ ] Community content (news, events, businesses)
- [ ] Push notification setup (FCM)

## 📄 License
© 2026 Macedonian Community of Australia Inc. All rights reserved.
