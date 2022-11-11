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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    communicationPreferences =
        context.read<ProfileCubit>().state.profile?.communicationPreferences ??
            CommunicationPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SwitchListTile(
            value: communicationPreferences.email ?? false,
            title: Text("Email"),
            onChanged: (value) {
              setState(() {
                communicationPreferences =
                    communicationPreferences.copyWith(email: value);
              });
            },
          ),
          SwitchListTile(
            value: communicationPreferences.webPushNotification ?? false,
            title: Text("Web Push Notification"),
            onChanged: (value) {
              setState(() {
                communicationPreferences =
                    communicationPreferences.copyWith(webPushNotification: value);
              });
            },
          ),
          SwitchListTile(
            value: communicationPreferences.sms ?? false,
            title: Text("SMS"),
            onChanged: (value) {
              setState(() {
                communicationPreferences =
                    communicationPreferences.copyWith(sms: value);
              });
            },
          ),
          SwitchListTile(
            value: communicationPreferences.whatsapp ?? false,
            title: Text("Whatsapp"),
            onChanged: (value) {
              setState(() {
                communicationPreferences =
                    communicationPreferences.copyWith(whatsapp: value);
              });
            },
          ),
          Spacer(),
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
