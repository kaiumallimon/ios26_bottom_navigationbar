import 'package:flutter/material.dart';
import 'package:ios26_bottom_navigationbar/ios26_bottom_navigationbar.dart';

void main() {
  runApp(const IOS26DemoApp());
}

class IOS26DemoApp extends StatefulWidget {
  const IOS26DemoApp({super.key});

  @override
  State<IOS26DemoApp> createState() => _IOS26DemoAppState();
}

class _IOS26DemoAppState extends State<IOS26DemoApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Color _accentColor = const Color(0xFF5B15FC); // Meditouch iOS Purple

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  void _changeAccent(Color color) {
    setState(() {
      _accentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iOS 26 Bottom Navigation Bar Demo',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFAF8F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: _accentColor,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000),
        colorScheme: ColorScheme.fromSeed(
          seedColor: _accentColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: DemoScreen(
        currentThemeMode: _themeMode,
        onToggleTheme: _toggleTheme,
        selectedAccent: _accentColor,
        onSelectAccent: _changeAccent,
      ),
    );
  }
}

class DemoScreen extends StatefulWidget {
  final ThemeMode currentThemeMode;
  final VoidCallback onToggleTheme;
  final Color selectedAccent;
  final ValueChanged<Color> onSelectAccent;

  const DemoScreen({
    super.key,
    required this.currentThemeMode,
    required this.onToggleTheme,
    required this.selectedAccent,
    required this.onSelectAccent,
  });

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  int _currentIndex = 0;
  bool _enableBadges = true;
  double _blurSigma = 30.0;

  final List<Color> _availableAccents = const [
    Color(0xFF5B15FC), // Apple System Purple / Meditouch
    Color(0xFF0A84FF), // Apple Blue
    Color(0xFF30D158), // Apple Green
    Color(0xFFFF9F0A), // Apple Orange
    Color(0xFFFF375F), // Apple Pink
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pages = [
      _buildTabContent('Home', Icons.home_rounded),
      _buildTabContent('Pharmacy', Icons.medication_rounded),
      _buildTabContent('Doctors', Icons.medical_services_rounded),
      _buildTabContent('AI Chat', Icons.auto_awesome_rounded),
      _buildTabContent('Settings', Icons.settings_rounded),
    ];

    return IOS26NavScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'iOS 26 Navigation Bar',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Toggle Theme',
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: pages[_currentIndex],
      navigationBar: IOS26BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        style: (isDark ? IOS26NavThemeData.dark() : IOS26NavThemeData.light()).copyWith(
          activeColor: widget.selectedAccent,
          blurSigmaX: _blurSigma,
          blurSigmaY: _blurSigma,
        ),
        items: [
          const IOS26NavItem.icon(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'Home',
            tooltip: 'Home Feed',
          ),
          IOS26NavItem.icon(
            icon: Icons.medication_outlined,
            activeIcon: Icons.medication_rounded,
            label: 'Pharmacy',
            badgeCount: _enableBadges ? 2 : null,
            tooltip: 'Order Medicines',
          ),
          const IOS26NavItem.icon(
            icon: Icons.medical_services_outlined,
            activeIcon: Icons.medical_services_rounded,
            label: 'Doctors',
            tooltip: 'Find Specialists',
          ),
          IOS26NavItem.icon(
            icon: Icons.auto_awesome_outlined,
            activeIcon: Icons.auto_awesome_rounded,
            label: 'AI Chat',
            badgeText: _enableBadges ? 'NEW' : null,
            tooltip: 'AI Medical Assistant',
          ),
          IOS26NavItem.icon(
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings_rounded,
            label: 'Settings',
            showBadge: _enableBadges,
            tooltip: 'Preferences',
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(String title, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      children: [
        Card(
          elevation: 0,
          color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: widget.selectedAccent.withValues(alpha: 0.15),
                      child: Icon(icon, color: widget.selectedAccent),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'This demo replicates the exact frosted glass floating bar from Meditouch with full customizability.',
                  style: TextStyle(
                    color: isDark ? const Color(0xFFA8A29E) : const Color(0xFF57534E),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Accent Color Customization',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  children: _availableAccents.map((color) {
                    final isSelected = color == widget.selectedAccent;
                    return GestureDetector(
                      onTap: () => widget.onSelectAccent(color),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: Colors.white, width: 3)
                              : null,
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: color.withValues(alpha: 0.5),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const Divider(height: 32),
                SwitchListTile.adaptive(
                  title: const Text('Show Badges (Count, Dot, Text)'),
                  value: _enableBadges,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) {
                    setState(() {
                      _enableBadges = val;
                    });
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'Blur Strength: ${_blurSigma.toInt()}px',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Slider.adaptive(
                  min: 0.0,
                  max: 50.0,
                  value: _blurSigma,
                  onChanged: (val) {
                    setState(() {
                      _blurSigma = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(10, (i) {
          return Card(
            elevation: 0,
            color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: widget.selectedAccent.withValues(alpha: 0.1),
                child: Text('#${i + 1}'),
              ),
              title: Text('Scrollable Content Row ${i + 1}'),
              subtitle: const Text('Passes smoothly under ambient fade gradient'),
            ),
          );
        }),
      ],
    );
  }
}
