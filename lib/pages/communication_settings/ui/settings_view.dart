import 'package:app/blocs/profile/profile_cubit.dart';
import 'package:app/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/theme.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late CommunicationPreferences communicationPreferences;

  bool showWebPush = false;
  bool showSms =  false;
  bool showWhatsApp = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    communicationPreferences =
        context.read<ProfileCubit>().state.profile?.communicationPreferences ??
            const CommunicationPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SwitchListTile(
            value: communicationPreferences.email ?? false,
            title: const Text("Email"),
            onChanged: (value) {
              setState(() {
                communicationPreferences =
                    communicationPreferences.copyWith(email: value);
              });
            },
          ),
          if(showWebPush) ... [
            SwitchListTile(
              value: communicationPreferences.webPushNotification ?? false,
              title: const Text("Web Push Notification"),
              onChanged: (value) {
                setState(() {
                  communicationPreferences =
                      communicationPreferences.copyWith(webPushNotification: value);
                });
              },
            ),
          ],

          if(showSms) ... [
            SwitchListTile(
              value: communicationPreferences.sms ?? false,
              title: const Text("SMS"),
              onChanged: (value) {
                setState(() {
                  communicationPreferences =
                      communicationPreferences.copyWith(sms: value);
                });
              },
            ),
          ],

          if(showWhatsApp) ... [
            SwitchListTile(
              value: communicationPreferences.whatsapp ?? false,
              title: const Text("Whatsapp"),
              onChanged: (value) {
                setState(() {
                  communicationPreferences =
                      communicationPreferences.copyWith(whatsapp: value);
                });
              },
            ),
          ],

          const Spacer(),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          kVerticalSpacerSmall,
          ElevatedButton(
            onPressed: (){
              context.read<ProfileCubit>().updatePreferences(communicationPreferences);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
