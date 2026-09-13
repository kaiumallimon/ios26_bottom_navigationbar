# ios26_bottom_navigationbar

A highly customizable, frosted-glass floating bottom navigation bar for Flutter inspired by next-generation iOS design language.

Features a signature **smooth-gliding pill indicator capsule**, **ambient bottom fade gradient**, **translucent glassmorphism blur**, **reactive icon scaling**, and **100% theme & icon customizability**.

---

## ✨ Features

- 🫧 **Frosted Glassmorphism**: Pure floating glass pill with customizable backdrop blur (`BackdropFilter`), translucent background, subtle border highlight, and soft elevation shadows.
- 💊 **Smooth Gliding Pill Indicator**: Animated pill capsule indicator that glides seamlessly across tabs with fluid easing curves (`Curves.fastEaseInToSlowEaseOut`).
- 🌊 **Ambient Bottom Fade Gradient**: Optional ambient gradient overlay (`IOS26AmbientFade` / `IOS26NavScaffold`) ensuring scrollable body content flows beautifully underneath the floating bar without visual clashes.
- 🎨 **Maximum Customizability**:
  - **Zero hardcoded colors or icons**: Adjust active colors, inactive colors, pill capsule tints, borders, shadows, blur sigmas, and margins.
  - **Themes & Extensions**: Built-in `IOS26NavThemeData.light()`, `.dark()`, and `.resolve(context)` with full support for Flutter's `ThemeExtension`.
  - **Custom Icons & Widgets**: Supports any `IconData` (Material, Cupertino, Lucide, FontAwesome) or custom `Widget` (SVG, Image, Lottie, Rive).
  - **Independent Active / Inactive States**: Specify distinct icons for active and inactive states.
  - **Rich Badges**: Built-in support for numeric badges (`badgeCount`), textual badges (`badgeText`), dot badges (`showBadge`), or custom badge widgets.
  - **Custom Indicator & Item Builders**: Override the pill indicator or item widgets with custom builders for unlimited design freedom.
- 📳 **Haptic Feedback**: Subtle iOS-style tactile feedback on tab selection.

---

## 🚀 Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  ios26_bottom_navigationbar:
    path: /path/to/ios26_bottom_navigationbar # or version constraint when published
```

Import the package:

```dart
import 'package:ios26_bottom_navigationbar/ios26_bottom_navigationbar.dart';
```

---

## 📖 Usage

### 1. Turnkey Usage with `IOS26NavScaffold`

The easiest and recommended way to achieve the full iOS 26 look is using `IOS26NavScaffold`. It automatically sets up the full-screen stack, ambient fade gradient, and floating bar positioning:

```dart
import 'package:flutter/material.dart';
import 'package:ios26_bottom_navigationbar/ios26_bottom_navigationbar.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return IOS26NavScaffold(
      body: Center(
        child: Text('Selected Index: $_currentIndex'),
      ),
      navigationBar: IOS26BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          IOS26NavItem.icon(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'Home',
          ),
          IOS26NavItem.icon(
            icon: Icons.local_pharmacy_outlined,
            activeIcon: Icons.local_pharmacy_rounded,
            label: 'Pharmacy',
            badgeCount: 3,
          ),
          IOS26NavItem.icon(
            icon: Icons.medical_services_outlined,
            activeIcon: Icons.medical_services_rounded,
            label: 'Doctors',
          ),
          IOS26NavItem.icon(
            icon: Icons.auto_awesome_outlined,
            activeIcon: Icons.auto_awesome_rounded,
            label: 'AI Chat',
            badgeText: 'NEW',
          ),
          IOS26NavItem.icon(
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings_rounded,
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
```

---

### 2. Standalone Floating Bar in Any `Scaffold`

You can also drop `IOS26BottomNavigationBar` into your existing `Scaffold` or custom `Stack`:

```dart
Scaffold(
  extendBody: true,
  body: MyScrollableContent(),
  bottomNavigationBar: IOS26BottomNavigationBar(
    currentIndex: _selectedIndex,
    onTap: (index) => setState(() => _selectedIndex = index),
    items: const [
      IOS26NavItem.icon(icon: Icons.home, label: 'Home'),
      IOS26NavItem.icon(icon: Icons.search, label: 'Search'),
      IOS26NavItem.icon(icon: Icons.person, label: 'Profile'),
    ],
  ),
);
```

---

### 3. Custom Icons & Widgets (SVGs, Images, Lottie)

You can pass arbitrary widgets as icons:

```dart
IOS26NavItem.custom(
  icon: Image.asset('assets/icons/home_outline.png', width: 20),
  activeIcon: Image.asset('assets/icons/home_filled.png', width: 20),
  label: 'Home',
),
```

---

### 4. Custom Styling & Themes

`ios26_bottom_navigationbar` offers deep styling control via `IOS26NavThemeData`.

#### Per-Instance Override:
```dart
IOS26BottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: _onTap,
  style: IOS26NavThemeData.light(
    activeColor: const Color(0xFF5B15FC), // Apple Purple
    inactiveColor: const Color(0xFF6B7280),
    backgroundColor: const Color(0xFFF6F6F8).withValues(alpha: 0.80),
    indicatorColor: Colors.white.withValues(alpha: 0.94),
    height: 64.0,
    borderRadius: BorderRadius.circular(40),
  ),
  items: items,
)
```

#### Global App Theme Integration:
```dart
MaterialApp(
  theme: ThemeData(
    brightness: Brightness.light,
    extensions: [
      IOS26NavThemeData.light(
        activeColor: Colors.deepPurple,
      ),
    ],
  ),
  darkTheme: ThemeData(
    brightness: Brightness.dark,
    extensions: [
      IOS26NavThemeData.dark(
        activeColor: Colors.purpleAccent,
      ),
    ],
  ),
  home: const MyHomeScreen(),
);
```

---

## 🛠️ API Reference

### `IOS26NavItem`

| Property | Type | Description |
|---|---|---|
| `icon` | `Widget?` | Unselected icon widget (e.g. SVG or Image) |
| `iconData` | `IconData?` | Shorthand icon font data |
| `activeIcon` | `Widget?` | Selected icon widget |
| `activeIconData` | `IconData?` | Selected shorthand icon font data |
| `label` | `String?` | Text label displayed under icon |
| `customLabel` | `Widget?` | Custom widget to display as label |
| `activeColor` | `Color?` | Custom active color override for this item |
| `inactiveColor` | `Color?` | Custom inactive color override for this item |
| `badge` | `Widget?` | Custom badge widget |
| `badgeCount` | `int?` | Numeric badge count (e.g. `5` or `99+`) |
| `badgeText` | `String?` | Text badge (e.g. `'NEW'`) |
| `showBadge` | `bool` | Displays small dot badge |
| `badgeColor` | `Color?` | Badge background color |
| `badgeTextColor` | `Color?` | Badge text color |
| `tooltip` | `String?` | Accessibility / hover tooltip |
| `onTap` | `VoidCallback?` | Specific callback when this item is tapped |

---

### `IOS26NavThemeData`

| Property | Default (Light / Dark) | Description |
|---|---|---|
| `height` | `62.0` | Container bar height |
| `padding` | `EdgeInsets.all(5.0)` | Internal container padding |
| `margin` | `EdgeInsets.symmetric(horizontal: 16)` | Outer margin around floating pill |
| `borderRadius` | `BorderRadius.circular(38.0)` | Capsule border radius |
| `blurSigmaX` / `Y` | `30.0` | Backdrop filter blur intensity |
| `backgroundColor` | `0xFFF6F6F8 (80%)` / `0xFF161618 (72%)` | Glass capsule background color |
| `border` | `Colors.white (85% / 18%), 0.9px` | Subtle capsule border outline |
| `boxShadow` | Subtle ambient drop shadow | Floating elevation shadows |
| `indicatorColor` | `Colors.white (94% / 16%)` | Gliding pill capsule background |
| `indicatorBorderRadius` | `BorderRadius.circular(30.0)` | Gliding pill border radius |
| `indicatorAnimationDuration`| `300ms` | Gliding animation duration |
| `indicatorAnimationCurve` | `Curves.fastEaseInToSlowEaseOut` | Gliding animation easing curve |
| `activeColor` | `0xFF5B15FC` / `0xFFBF5AF2` | Active icon and label tint |
| `inactiveColor` | `0xFF6B7280` / `0xFF8E8E93` | Inactive icon and label tint |
| `iconSize` | `19.0` | Icon dimension |
| `selectedIconScale` | `1.08` | Scale factor on active icon |
| `enableHapticFeedback` | `true` | Subtle iOS haptic feedback on tap |
| `enableAmbientFade` | `true` | Soft bottom ambient gradient overlay |

---

## 📄 License

MIT License. Free for personal and commercial use.
