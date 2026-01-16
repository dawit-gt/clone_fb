import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';

class FacebookTabBar extends StatefulWidget {
  const FacebookTabBar({super.key});

  @override
  State<FacebookTabBar> createState() => _FacebookTabBarState();
}

class _FacebookTabBarState extends State<FacebookTabBar> {
  int _selectedIndex = 0;
    final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab(Icons.home, 0),
          _buildTab(Icons.ondemand_video, 1),
          _buildTab(Icons.group, 2),
          _buildTab(Icons.storefront, 3),
          _buildNotificationTab(4),
        ],
      ),
    );
  }

  // -------------------------
  // NORMAL TAB
  // -------------------------
  Widget _buildTab(IconData icon, int index) {
    final isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 26, color: isActive ? Colors.blue : Colors.black54),
          const SizedBox(height: 4),
          Container(
            height: 3,
            width: 36,
            color: isActive ? Colors.blue : Colors.transparent,
          ),
        ],
      ),
    );
  }

  // -------------------------
  // NOTIFICATION TAB
  // -------------------------
  Widget _buildNotificationTab(int index) {
    final isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.notifications,
                size: 26,
                color: isActive ? Colors.blue : Colors.black54,
              ),
              const SizedBox(height: 4),
              Container(
                height: 3,
                width: 36,
                color: isActive ? Colors.blue : Colors.transparent,
              ),
            ],
          ),
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            _authService.signOut();
            context.go('/login');
          }, child: Text("logout")),
        ],
      ),
    );
  }
}
