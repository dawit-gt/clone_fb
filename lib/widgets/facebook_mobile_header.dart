import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FacebookMobileHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const FacebookMobileHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Facebook logo
            const Icon(Icons.facebook, color: Color(0xff1877f2), size: 36),

            // Center: nothing for mobile (or optional search icon)
            // IconButton(
            //   icon: const Icon(Icons.search, color: Colors.grey),
            //   onPressed: () {
            //     // You can open a search page here
            //   },
            // ),

            // Right: profile & messages/notifications
            Row(
              children: [
                SizedBox(width: 8),
                _CircleButton(Icons.add),
                _CircleButton(Icons.search),
                _CircleButton(Icons.travel_explore,
                    onTap: () => context.go('/explore')),
                _CircleButton(Icons.message,
                    onTap: () => context.go('/messages')),

                SizedBox(width: 8),
                // CircleAvatar(
                //   radius: 18,
                //   child: ClipOval(
                //     child: Image.network(
                //       'https://i.pravatar.cc/40?u=myprofile',
                //       width: 36,
                //       height: 36,
                //       fit: BoxFit.cover,
                //       errorBuilder: (_, __, ___) => const Icon(Icons.person),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _CircleButton(this.icon, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: const Color(0xffe4e6eb),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}
