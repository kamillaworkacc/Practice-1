import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:labwork8/generated/locale_keys.g.dart';

class UserInfoPage extends StatelessWidget {
  final String fullName;
  final String phone;
  final String email;
  final String lifeStory;
  final String password;

  const UserInfoPage({
    super.key,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.lifeStory,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(LocaleKeys.user_information.tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.registration_successful.tr(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 30),
            _buildInfoCard(LocaleKeys.full_name.tr(), fullName),
            const SizedBox(height: 16),
            _buildInfoCard(LocaleKeys.phone_number.tr(), phone),
            const SizedBox(height: 16),
            _buildInfoCard(LocaleKeys.email_address.tr(), email),
            const SizedBox(height: 16),
            _buildInfoCard(LocaleKeys.life_story.tr(), lifeStory.isEmpty ? LocaleKeys.not_provided.tr() : lifeStory),
            const SizedBox(height: 16),
            _buildInfoCard(LocaleKeys.password.tr(), '${'*' * password.length} (${password.length} ${LocaleKeys.characters.tr()})'),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  LocaleKeys.back_to_registration.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
