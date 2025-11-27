import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:labwork8/constants/colors.dart';
import 'package:labwork8/constants/text_styles_value.dart';
import 'package:labwork8/generated/locale_keys.g.dart';
import 'package:labwork8/pages/profile_page.dart';
import 'package:labwork8/registration.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.hello_text.tr(),
              style: AppTextStyles.px12blue,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    await context.setLocale(const Locale('ru'));
                    if (!mounted) return;
                    navigator.pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                  ),
                  child: const Text("RU"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    await context.setLocale(const Locale('kk'));
                    if (!mounted) return;
                    navigator.pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.Azure,
                  ),
                  child: const Text("KZ"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                await context.setLocale(const Locale('en'));
                if (!mounted) return;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              icon: const Icon(Icons.person),
              label: const Text('Open Profile Page'),
            ),
          ],
        ),
      ),
    );
  }
}