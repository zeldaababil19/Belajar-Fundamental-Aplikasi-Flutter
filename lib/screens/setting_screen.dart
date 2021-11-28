import 'package:final_submission/providers/preferences_provider.dart';
import 'package:final_submission/providers/schedulling_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  static String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Setting',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return Material(
            child: ListTile(
              title: Text('Daily reminder'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: provider.isDailyReminderActive,
                    onChanged: (value) async {
                      scheduled.scheduledRestaurant(value);
                      provider.enableDailyReminder(value);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
