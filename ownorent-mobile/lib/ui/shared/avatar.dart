import 'package:flutter/material.dart';
import 'package:ownorent/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../core/models/user_model.dart';
import '../../core/services/authentication.dart';
import '../../core/viewmodels/user_viewmodel.dart';

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    final userViewModel = Provider.of<UserViewmodel>(context);

    return Container(
      child: CircleAvatar(
        backgroundColor: ownorentWhite,
        radius: 7,
        backgroundImage:
            NetworkImage(userViewModel.currentUser?.profilePhoto ?? ""),
      ),
      padding: EdgeInsets.all(10),
    );
  }
}
