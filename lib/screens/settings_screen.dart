import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_bloc/logic/settings_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          final notificationSnackbar = SnackBar(
              duration: Duration(milliseconds: 700),
              content: Text('App' +
                  state.appNotification.toString().toUpperCase() +
                  'Email' +
                  state.emailNotification.toString().toUpperCase()));
          ScaffoldMessenger.of(context).showSnackBar(notificationSnackbar);
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Container(
              child: Column(
                children: [
                  SwitchListTile(
                    value: state.appNotification,
                    onChanged: (newValue) {
                      context
                          .read<SettingsCubit>()
                          .toggleAppNotification(newValue);
                    },
                    title: Text('AppNotification'),
                  ),
                  SwitchListTile(
                    value: state.emailNotification,
                    onChanged: (newValue) {
                      context
                          .read<SettingsCubit>()
                          .toggleEmailNotification(newValue);
                    },
                    title: Text('EmailNotification'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
