import 'package:flutter/material.dart';

import 'package:testflyer/constants.dart';
import 'store_selection_screen.dart';

/// Home after check-in — layout inspired by a clean course / product-detail UI.
class TestDriverHomeScreen extends StatefulWidget {
  const TestDriverHomeScreen({
    super.key,
    required this.store,
    required this.onSignOut,
    this.onBackToStoreSelection,
  });

  final StoreRecord store;
  final VoidCallback onSignOut;

  /// When set (e.g. from [AuthFlow]), the top-left control returns here instead of popping the route.
  final VoidCallback? onBackToStoreSelection;

  /// Light page background tinted with brand teal.
  static const Color pageBg = Color(0xFFF4FAF8);
  static const Color softGrayBg = Color(0xFFECECEF);

  @override
  State<TestDriverHomeScreen> createState() => _TestDriverHomeScreenState();
}

class _TestDriverHomeScreenState extends State<TestDriverHomeScreen> {
  int _navIndex = 0;

  bool _favorite = false;

  static BoxDecoration _elevatedCardDecoration({required double radius}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: Colors.grey.shade300),
    );
  }

  Widget _circleSurfaceButton({
    required VoidCallback onPressed,
    required Widget child,
    double size = 44,
    Color? bg,
    Key? key,
  }) {
    return SizedBox(
      key: key,
      width: size,
      height: size,
      child: Material(
        shape: const CircleBorder(),
        elevation: 0,
        shadowColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: IconTheme.merge(
            data: const IconThemeData(color: Color(0xFF1A1A1A), size: 22),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brand = brandBlue;
    final brandLight = Color.lerp(brand, Colors.white, 0.45)!;
    final topPad = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: TestDriverHomeScreen.pageBg,
      body: IndexedStack(
        index: _navIndex,
        children: [
          Column(
            children: [
              SizedBox(height: topPad),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Row(
                  children: [
                   Icon(Icons.local_car_wash_rounded, size: 30, color: brand,),
                    const Expanded(
                      child: Text(
                        'Store Home',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111111),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    Tooltip(
                      message: 'Sign out',
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Card(
                              color: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                              child: _circleSurfaceButton(
                                key: const ValueKey('home_sign_out_button'),
                                onPressed: widget.onSignOut,
                                child: const Icon(
                                  Icons.exit_to_app_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 4,
                              top: 4,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: brand,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: _elevatedCardDecoration(radius: 28),
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  color: Colors.black87,
                                  ),
                                  child: const Icon(
                                    Icons.person_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Corolla Overnightr',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF111111),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        widget.store.title,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF727272),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 8),
                                OutlinedButton(
                                  onPressed: () =>
                                      setState(() => _favorite = !_favorite),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(40, 40),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.zero,
                                    shape: const CircleBorder(),
                                    side: const BorderSide(
                                      color: Color(0xFFDCDCE0),
                                    ),
                                    foregroundColor: _favorite
                                        ? brand
                                        : const Color(0xFF222222),
                                  ),
                                  child: Icon(
                                    _favorite
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: AspectRatio(
                                aspectRatio: 16 / 10,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // Use the car image as the background
                                    Image.network(
                                      'https://images.pexels.com/photos/32609636/pexels-photo-32609636.jpeg',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return DecoratedBox(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [brandLight, brand],
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF0F0F2),
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 11,
                                            vertical: 6,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.star_rounded,
                                                size: 16,
                                                color: Color(0xFFEAB308),
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                '4.5',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                          border: Border.all(
                                            color: brand.withValues(
                                              alpha: 0.55,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Bestseller',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: brand,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  r'$256k',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF111111),
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Text(
                            //   widget.store.title,
                            //   style: const TextStyle(
                            //     fontSize: 24,
                            //     fontWeight: FontWeight.w800,
                            //     color: Color(0xFF111111),
                            //     letterSpacing: -0.4,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.grey.shade200),
                                ),
                                child: Center(
                                  child: _MiniStatTile(
                                    icon: Icons.groups_2_rounded,
                                    label: 'Test Drives',
                                    value: '200',
                                    iconBg: brand.withValues(alpha: 0.14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.grey.shade200),
                                ),
                                child: Center(
                                  child: _MiniStatTile(
                                    icon: Icons.star_rounded,
                                    label: 'Reviews',
                                    value: '3,648',
                                    iconBg: Color.lerp(
                                      brand,
                                      Colors.amber.shade100,
                                      0.55,
                                    )!,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: brand,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            shape: const StadiumBorder(),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Buy Now'),
                        ),
                      ),
                      const SizedBox(height: 11),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF111111),
                            side: const BorderSide(color: Color(0xFFD8D8DD)),
                            shape: const StadiumBorder(),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Add to Cart'),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ColoredBox(
            color: TestDriverHomeScreen.pageBg,
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 320),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.store.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111111),
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              shape: const StadiumBorder(),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: widget.onSignOut,
                            child: const Text('Log out'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        elevation: 12,
        shadowColor: Colors.black.withValues(alpha: 0.06),
        surfaceTintColor: Colors.transparent,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NavigationBarTheme(
                  data: NavigationBarThemeData(
                    height: 64,
                    backgroundColor: Colors.transparent,
                    indicatorColor: brand.withValues(alpha: 0.14),
                    labelTextStyle: WidgetStateProperty.resolveWith((states) {
                      final sel = states.contains(WidgetState.selected);
                      return TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: sel ? brand : const Color(0xFF52525B),
                      );
                    }),
                    iconTheme: WidgetStateProperty.resolveWith((states) {
                      final sel = states.contains(WidgetState.selected);
                      return IconThemeData(
                        color: sel ? brand : const Color(0xFF52525B),
                        size: 24,
                      );
                    }),
                  ),
                  child: NavigationBar(
                    selectedIndex: _navIndex,
                    onDestinationSelected: (i) => setState(() => _navIndex = i),
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysShow,
                    destinations: const [
                      NavigationDestination(
                        key: ValueKey('home_nav_home'),
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        key: ValueKey('home_nav_account'),
                        icon: Icon(Icons.person_outline_rounded),
                        selectedIcon: Icon(Icons.person_rounded),
                        label: 'Account',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _MiniStatTile extends StatelessWidget {
  const _MiniStatTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconBg,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color iconBg;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Icon(icon, size: 23, color: const Color(0xFF474747)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF71717A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111111),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
