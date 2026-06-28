import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stem_union/authentication/controllers/user_controller.dart';
import 'package:stem_union/authentication/screens/loging/login.dart';
import 'package:stem_union/utils/constants/colors.dart';
import 'package:stem_union/utils/helpers/helper_functions.dart';

void showProfileDialog({required BuildContext context}) {
  showDialog(context: context, builder: (context) => const _ProfileDialog());
}

class _ProfileDialog extends StatelessWidget {
  const _ProfileDialog();

  String _capitalize(String s) {
    if (s.trim().isEmpty) return '';
    final t = s.trim();
    return t[0].toUpperCase() + t.substring(1).toLowerCase();
  }

  Widget _infoRow(String label, String value, Color textColor, Color mutedColor) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'JetBrainsMono',
                fontSize: 12,
                color: mutedColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaultAvatar(String firstName, Color bg, Color amber) {
    return Container(
      color: bg,
      child: Center(
        child: Text(
          firstName.isNotEmpty ? firstName[0].toUpperCase() : '?',
          style: TextStyle(
            fontFamily: 'JetBrainsMono',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: amber,
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Delete Account'),
        content: const Text(
          'This will permanently delete your account and all your data. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              try {
                final user = FirebaseAuth.instance.currentUser;
                final uid = user?.uid;
                if (uid != null) {
                  await UserController.instance.userRepository.removeUserRecord(uid);
                }
                await user?.delete();
                if (!context.mounted) return;
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              } catch (e) {
                debugPrint('Delete error: $e');
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final amber = isDark ? TColors.secondry : TColors.primary;
    final dialogBg = isDark ? const Color(0xFF111111) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white60 : Colors.black54;
    final avatarBg = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFEFEFEF);

    return Obx(() {
      final user = UserController.instance.user.value;
      final fullName = [
        _capitalize(user.firstName),
        _capitalize(user.lastName),
      ].where((s) => s.isNotEmpty).join(' ');
      final displayName = fullName.isNotEmpty ? fullName : 'Your Name';

      return Dialog(
        backgroundColor: dialogBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420, maxHeight: 620),
          child: user.id.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Not logged in', style: TextStyle(color: textColor)),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: amber, width: 2.5),
                          color: avatarBg,
                        ),
                        child: ClipOval(
                          child: user.profilePicture.isNotEmpty
                              ? Image.network(
                                  user.profilePicture,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      _defaultAvatar(_capitalize(user.firstName), avatarBg, amber),
                                )
                              : _defaultAvatar(_capitalize(user.firstName), avatarBg, amber),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        displayName,
                        style: TextStyle(
                          fontFamily: 'JetBrainsMono',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      if (user.username.isNotEmpty)
                        Text(
                          '@${user.username}',
                          style: TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontSize: 12,
                            color: amber,
                          ),
                        ),
                      const SizedBox(height: 20),
                      Divider(color: mutedColor.withOpacity(0.15)),
                      const SizedBox(height: 12),
                      _infoRow('Email', user.email, textColor, mutedColor),
                      _infoRow('Phone', user.phone, textColor, mutedColor),
                      _infoRow('Level', user.academicLevel, textColor, mutedColor),
                      _infoRow('Grade', user.grade, textColor, mutedColor),
                      _infoRow('School', user.stemSchool, textColor, mutedColor),
                      const SizedBox(height: 20),
                      Divider(color: mutedColor.withOpacity(0.15)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              icon: const Icon(Icons.logout, size: 15),
                              label: const Text('Log Out'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: textColor,
                                side: BorderSide(color: mutedColor.withOpacity(0.3)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _confirmDelete(context),
                              icon: const Icon(Icons.delete_outline, size: 15),
                              label: const Text('Delete'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.redAccent,
                                side: const BorderSide(color: Colors.red, width: 0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}