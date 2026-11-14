import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:football_app/view/signin/sign_in_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogOutWidget extends StatefulWidget {
  const LogOutWidget({super.key});

  @override
  State<LogOutWidget> createState() => _LogOutWidgetsState();
}

class _LogOutWidgetsState extends State<LogOutWidget> {
  final _storage = const FlutterSecureStorage();

  Future<void> _logout() async {
    // Grab these before any await so we don't use a stale context
    final navigator = Navigator.of(context, rootNavigator: true);
    final messenger = ScaffoldMessenger.of(context);

    try {
      // 1. (Optional) tell your Node backend, e.g. to revoke a refresh token.
      //    Don't let a network failure block the logout.
      // try {
      //   final token = await _storage.read(key: 'token');
      //   await http.post(
      //     Uri.parse('https://your-api.com/auth/logout'),
      //     headers: {'Authorization': 'Bearer $token'},
      //   ).timeout(const Duration(seconds: 5));
      // } catch (_) {}

      // 2. Sign out of Google so the account picker shows next time
      await GoogleSignIn.instance.signOut();
      // If you are on google_sign_in 7.x or newer, use this instead:
      // await GoogleSignIn.instance.signOut();

      // 3. Clear the session saved on the device
      await _storage.delete(key: 'token'); // use the key(s) you saved at login
      // or wipe everything: await _storage.deleteAll();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text("Logout failed: $e")));
      return;
    }

    // 4. Go to sign in and wipe the back stack
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SignInScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return AlertDialog(
                  backgroundColor: const Color(0xFF1C1C1E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                    "Logout",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  content: Text(
                    "Are you sure you want to logout?",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(color: Colors.white70),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(dialogContext); // close dialog
                        _logout(); // sign out + go to sign in
                      },
                      child: Text(
                        "Logout",
                        style: GoogleFonts.poppins(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(
            Icons.logout_rounded,
            color: Colors.redAccent,
            size: 20,
          ),
          label: Text(
            "Logout",
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.redAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0x1AFF5252),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Color(0x4DFF5252)),
            ),
          ),
        ),
      ),
    );
  }
}
