import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:beyou/core/constants/color_constants.dart';
import 'package:beyou/core/constants/path_constants.dart';
import 'package:beyou/core/constants/text_constants.dart';
import 'package:beyou/core/router/route_names.dart';
import 'package:beyou/core/service/auth_service.dart';
import 'package:beyou/screens/settings/bloc/bloc/settings_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackgroundColor,
      body: _buildContext(context),
    );
  }

  BlocProvider<SettingsBloc> _buildContext(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => SettingsBloc(),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        buildWhen: (_, currState) => currState is SettingsInitial,
        builder: (context, state) => _settingsContent(context),
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }

  Widget _settingsContent(BuildContext context) {
    String displayName;
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      displayName = user?.displayName ?? "User";
      photoUrl = user?.photoURL;
    } catch (_) {
      displayName = "User";
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // App bar row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Avatar + name
            Stack(
              alignment: Alignment.topRight,
              children: [
                Center(
                  child: photoUrl == null
                      ? CircleAvatar(
                          backgroundImage: AssetImage(PathConstants.profile),
                          radius: 52,
                        )
                      : CircleAvatar(
                          radius: 52,
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              placeholder: PathConstants.profile,
                              image: photoUrl!,
                              fit: BoxFit.cover,
                              width: 104,
                              height: 104,
                            ),
                          ),
                        ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width / 2 - 52 - 4,
                  child: GestureDetector(
                    onTap: () async {
                      await context.push(RouteNames.editAccount);
                      setState(() {});
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.primaryColor.withValues(alpha: 0.3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Text(
              displayName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Settings rows
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildSettingsRow(
                    icon: Icons.notifications_outlined,
                    label: TextConstants.reminder,
                    onTap: () => context.push(RouteNames.reminder),
                  ),
                  if (!kIsWeb)
                    _buildSettingsRow(
                      icon: Icons.star_outline,
                      label: '${TextConstants.rateUsOn}${Platform.isIOS ? 'App Store' : 'Play Store'}',
                      onTap: () => launchUrl(Uri.parse(
                          Platform.isIOS ? 'https://www.apple.com/app-store/' : 'https://play.google.com/store')),
                    ),
                  _buildSettingsRow(
                    icon: Icons.description_outlined,
                    label: TextConstants.terms,
                    onTap: () => launchUrl(Uri.parse('https://perpet.io/')),
                  ),
                  _buildSettingsRow(
                    icon: Icons.logout,
                    label: TextConstants.signOut,
                    isDestructive: true,
                    onTap: () {
                      AuthService.signOut();
                      context.go(RouteNames.signIn);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Text(
              TextConstants.joinUs,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorConstants.textGrey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton(PathConstants.facebook, 'https://www.facebook.com/'),
                const SizedBox(width: 12),
                _buildSocialButton(PathConstants.instagram, 'https://www.instagram.com/'),
                const SizedBox(width: 12),
                _buildSocialButton(PathConstants.twitter, 'https://twitter.com/'),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? ColorConstants.errorColor : ColorConstants.textBlack;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(40),
        child: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: onTap,
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.textBlack.withValues(alpha: 0.08),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(icon, color: isDestructive ? ColorConstants.errorColor : ColorConstants.primaryColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: ColorConstants.grey, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String assetPath, String url) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ColorConstants.textBlack.withValues(alpha: 0.1),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Image.asset(assetPath),
      ),
    );
  }
}
