import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios26_bottom_navigationbar/ios26_bottom_navigationbar.dart';

void main() {
  group('IOS26BottomNavigationBar', () {
    testWidgets('renders items with labels and icons correctly', (tester) async {
      int selectedIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                bottomNavigationBar: IOS26BottomNavigationBar(
                  currentIndex: selectedIndex,
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  items: const [
                    IOS26NavItem.icon(
                      icon: Icons.home_outlined,
                      activeIcon: Icons.home,
                      label: 'Home',
                    ),
                    IOS26NavItem.icon(
                      icon: Icons.search_outlined,
                      activeIcon: Icons.search,
                      label: 'Search',
                    ),
                    IOS26NavItem.icon(
                      icon: Icons.person_outline,
                      activeIcon: Icons.person,
                      label: 'Profile',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      // Verify labels rendered
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);

      // Verify active icon for Home (selected index 0)
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search_outlined), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);

      // Tap on Search item
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(selectedIndex, 1);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    });

    testWidgets('supports badges: count, text, dot, and custom widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: IOS26BottomNavigationBar(
              currentIndex: 0,
              items: const [
                IOS26NavItem.icon(
                  icon: Icons.mail_outline,
                  label: 'Inbox',
                  badgeCount: 5,
                ),
                IOS26NavItem.icon(
                  icon: Icons.notifications_none,
                  label: 'Alerts',
                  badgeText: '99+',
                ),
                IOS26NavItem.icon(
                  icon: Icons.settings,
                  label: 'Settings',
                  showBadge: true,
                ),
                IOS26NavItem.custom(
                  icon: Icon(Icons.star_border),
                  label: 'VIP',
                  badge: Text('★', key: Key('custom-badge')),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.text('99+'), findsOneWidget);
      expect(find.byKey(const Key('custom-badge')), findsOneWidget);
    });

    testWidgets('supports custom styles and overrides', (tester) async {
      final customTheme = IOS26NavThemeData.light(
        activeColor: Colors.teal,
        inactiveColor: Colors.grey,
        height: 70.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: IOS26BottomNavigationBar(
              currentIndex: 0,
              style: customTheme,
              items: const [
                IOS26NavItem.icon(
                  icon: Icons.home,
                  label: 'Home',
                ),
                IOS26NavItem.icon(
                  icon: Icons.explore,
                  label: 'Explore',
                ),
              ],
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(IOS26BottomNavigationBar),
          matching: find.byType(Container).first,
        ),
      );

      expect(container.constraints?.maxHeight, 70.0);
    });

    testWidgets('manually controls border color and strength via parameters', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: IOS26BottomNavigationBar(
              currentIndex: 0,
              borderColor: Colors.purple,
              borderWidth: 2.5,
              items: const [
                IOS26NavItem.icon(icon: Icons.home, label: 'Home'),
                IOS26NavItem.icon(icon: Icons.settings, label: 'Settings'),
              ],
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(IOS26BottomNavigationBar),
          matching: find.byType(Container).first,
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);
      final border = decoration.border as Border;
      expect(border.top.color, Colors.purple);
      expect(border.top.width, 2.5);
    });

    testWidgets('manually controls selected item border color and strength', (tester) async {
      int activeIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                bottomNavigationBar: IOS26BottomNavigationBar(
                  currentIndex: activeIndex,
                  onTap: (i) => setState(() => activeIndex = i),
                  selectedItemBorderColor: Colors.blue,
                  selectedItemBorderWidth: 1.8,
                  items: const [
                    IOS26NavItem.icon(icon: Icons.home, label: 'Home'),
                    IOS26NavItem.icon(
                      icon: Icons.star,
                      label: 'VIP',
                      selectedBorderColor: Colors.amber,
                      selectedBorderWidth: 3.0,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      // Find the animated gliding pill indicator container
      final animatedPos = tester.widget<AnimatedPositioned>(find.byType(AnimatedPositioned).first);
      final padding = animatedPos.child as Padding;
      final indicatorContainer = padding.child as Container;
      final indicatorDecoration = indicatorContainer.decoration as BoxDecoration;

      expect(indicatorDecoration.border, isNotNull);
      final border0 = indicatorDecoration.border as Border;
      expect(border0.top.color, Colors.blue);
      expect(border0.top.width, 1.8);

      // Tap second tab which has per-item selected border
      await tester.tap(find.text('VIP'));
      await tester.pumpAndSettle();

      final animatedPos2 = tester.widget<AnimatedPositioned>(find.byType(AnimatedPositioned).first);
      final padding2 = animatedPos2.child as Padding;
      final indicatorContainer2 = padding2.child as Container;
      final indicatorDecoration2 = indicatorContainer2.decoration as BoxDecoration;

      expect(indicatorDecoration2.border, isNotNull);
      final border1 = indicatorDecoration2.border as Border;
      expect(border1.top.color, Colors.amber);
      expect(border1.top.width, 3.0);
    });

    testWidgets('renders in IOS26NavScaffold with ambient fade', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: IOS26NavScaffold(
            body: const Center(child: Text('Underlying Content')),
            navigationBar: IOS26BottomNavigationBar(
              currentIndex: 0,
              items: const [
                IOS26NavItem.icon(icon: Icons.home, label: 'Home'),
                IOS26NavItem.icon(icon: Icons.favorite, label: 'Favorites'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Underlying Content'), findsOneWidget);
      expect(find.byType(IOS26AmbientFade), findsOneWidget);
      expect(find.byType(IOS26BottomNavigationBar), findsOneWidget);
    });
  });

  group('IOS26NavThemeData', () {
    test('theme presets instantiate with valid parameters', () {
      final light = IOS26NavThemeData.light();
      final dark = IOS26NavThemeData.dark();

      expect(light.height, 62.0);
      expect(dark.height, 62.0);
      expect(light.borderRadius, BorderRadius.circular(38.0));
      expect(dark.borderRadius, BorderRadius.circular(38.0));
      expect(light.borderWidth, 0.9);
      expect(dark.borderWidth, 0.9);
    });

    test('border customization and zero strength (no border)', () {
      final borderNone = IOS26NavThemeData.light(borderWidth: 0.0);
      expect(borderNone.effectiveBorder, isNull);

      final customBorder = IOS26NavThemeData.light(
        borderColor: Colors.cyan,
        borderWidth: 3.0,
      );
      expect(customBorder.effectiveBorder, isNotNull);
      final border = customBorder.effectiveBorder as Border;
      expect(border.top.color, Colors.cyan);
      expect(border.top.width, 3.0);
    });

    test('copyWith updates specified fields', () {
      final base = IOS26NavThemeData.light();
      final modified = base.copyWith(
        height: 80.0,
        activeColor: Colors.deepOrange,
        enableHapticFeedback: false,
        borderColor: Colors.amber,
        borderWidth: 4.0,
      );

      expect(modified.height, 80.0);
      expect(modified.activeColor, Colors.deepOrange);
      expect(modified.enableHapticFeedback, false);
      expect(modified.borderColor, Colors.amber);
      expect(modified.borderWidth, 4.0);
      expect(modified.inactiveColor, base.inactiveColor);
    });
  });
}
