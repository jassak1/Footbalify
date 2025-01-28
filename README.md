# Footbalify
Footbalify is the ultimate NFL app providing Schedule and Standings for whole NFL season, covering Regular Weeks, Play-offs and all Season matches. Users can track AFC/NFC Conference Standings, track their favourite team, division and never miss match date, including ultimate countdown to Super Bowl.
The app highly focuses on providing same experience via Home Screen and Lock Screen Widgets.

![FootbalifyPromo](https://github.com/user-attachments/assets/63b00471-6cc6-4004-8561-d4165d839fac)

# Stack
- **Architecture**: MVVM with Navigation relying on `NavigationStack` and DI utilising `EnvironmentObject`
- **Interface**: SwiftUI
- **Dependencies:** 100% native libraries/no external dependencies
- **Others**:
  - **UserDefaults** - Customized UserDefaults allowing to persist generic data utilising AppGroup - in order to share prefs between Main App and Widgets Target
  -  **IapService** - Custom service providing In-App purchase via StoreKit 2, relying on modern Swift concurrency
