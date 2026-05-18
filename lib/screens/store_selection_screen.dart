import 'package:flutter/material.dart';
import 'package:testflyer/constants.dart';

class StoreRecord {
  const StoreRecord({required this.title, required this.code});

  final String title;
  final String code;
}

const List<StoreRecord> kDemoStores = [
  StoreRecord(title: 'Driver Site', code: 'driver-site'),
  StoreRecord(title: 'Offroad Road Site', code: 'offroad-road-site'),
  StoreRecord(title: 'Lab Store', code: 'lab-store'),
  StoreRecord(title: 'Ayensu 8 downhill', code: 'ayensu-8-downhill'),
];

class StoreSelectionScreen extends StatefulWidget {
  const StoreSelectionScreen({
    super.key,
    required this.displayName,
    required this.onLogout,
    required this.onCheckedIn,
  });

  final String displayName;
  final VoidCallback onLogout;
  final void Function(StoreRecord store) onCheckedIn;

  static const Color headerNavy = Color(0xFF242F52);
  static const Color pageBg = Color(0xFFF3F4F8);

  @override
  State<StoreSelectionScreen> createState() => _StoreSelectionScreenState();
}

class _StoreSelectionScreenState extends State<StoreSelectionScreen> {
  StoreRecord _selected = kDemoStores.first;

  String _formatToday(DateTime d) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    String ordinal(int day) {
      if (day >= 11 && day <= 13) return '${day}th';
      switch (day % 10) {
        case 1:
          return '${day}st';
        case 2:
          return '${day}nd';
        case 3:
          return '${day}rd';
        default:
          return '${day}th';
      }
    }

    return '${weekdays[d.weekday - 1]} ${ordinal(d.day)} ${months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: StoreSelectionScreen.pageBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: brandBlue,
            padding: EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top + 8,
              bottom: 14,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: widget.onLogout,
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Welcome, where to begin?',
                    key: ValueKey('welcome_header'),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _formatToday(today),
                key: const ValueKey('current_date_display'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
              child: Column(
                children: [
                  Material(
                    elevation: 3,
                    shadowColor: Colors.black26,
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 6, 4, 8),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<StoreRecord>(
                                key: const ValueKey('store_dropdown_selector'),
                                isExpanded: true,
                                value: _selected,
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.grey.shade600,
                                ),
                                selectedItemBuilder: (context) => [
                                  for (final _ in kDemoStores)
                                    Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Click here to select a store',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                                items: [
                                  for (final s in kDemoStores)
                                    DropdownMenuItem<StoreRecord>(
                                      value: s,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            s.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            s.code,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                                onChanged: (v) {
                                  if (v != null) setState(() => _selected = v);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selected.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _selected.code,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      key: const ValueKey('checkin_action_button'),
                      color: brandBlue,
                      elevation: 2,
                      highlightElevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      onPressed: () => widget.onCheckedIn(_selected),
                      child: Text(
                        'Check in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),
                  InkWell(
                    key: const ValueKey('logout_action_button'),
                    onTap: widget.onLogout,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.red.shade600,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
