# AUCitiesApp - SwiftUI (Assignment)

This project demonstrates a SwiftUI app that loads Australian cities from a bundled JSON, displays them grouped by state (collapsible sections), supports reversing list order, dark mode, caching, refresh, MVVM and SOLID-principled structure.

## Features
- SwiftUI views (no Storyboards).
- MVVM pattern (AUCitiesViewModel).
- Service protocol + implementation (dependency injection).
- File-based caching with TTL.
- Refresh from backend (simulated by bundled JSON).
- Collapsible state sections, reverse order button, pull-to-refresh via toolbar.
- Unit tests for view model grouping and reversing.
- Uses constants, DI-friendly, clean and idiomatic Swift.

## How to open
1. You can open the `Package.swift` in Xcode (File → Open) — Xcode will allow running the package or you can generate an Xcode project:
```bash
swift package generate-xcodeproj
open *.xcodeproj
```
2. In Xcode, create an iOS App target and include `Sources` files, or replace the `App` target with `AUCitiesApp` as the entry point.

## Notes
- `au_cities.json` is included in project root. For a real backend, replace `AUCityServiceImpl` to fetch from network and decode.
- To keep this small and portable, caching uses user's caches directory.
- Accessibility identifiers added for key buttons to assist UI tests.

## Files of interest
- `Models/CityModel.swift`, `ViewModel/AUCitiesViewModel.swift`, `ScreenControls/AUCities.swift`, `Sources/AUCitiesApp.swift`
- `au_cities.json`
- `Tests/AUCitiesTests.swift`

## Video
I included a short demo GIF/video in the repo in a real submission. For this environment, record the UI by running the app in Xcode and use QuickTime or built-in simulator recording.

## License
MIT
