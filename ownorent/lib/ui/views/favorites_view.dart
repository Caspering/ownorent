import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ownorent/ui/shared/empty_screen.dart';
import 'package:ownorent/ui/widgets/favorite_container.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/favorite_viewmodel.dart';
import '../../utils/colors.dart';
import '../../utils/font_size.dart';
import '../../utils/router.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    FavoriteViewModel _favorites = Provider.of<FavoriteViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ownorentWhite,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            RouteController().pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ownorentPurple,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Favourites",
          style: TextStyle(
              color: ownorentPurple, fontSize: TextSize().h3(context)),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ownorentWhite,
        child: _favorites.favoriteIds!.isNotEmpty
            ? ListView.builder(
                itemCount: _favorites.favoriteIds?.length,
                itemBuilder: (context, index) {
                  return FavoritesContainer(id: _favorites.favoriteIds![index]);
                })
            : Empty(),
      ),
    );
  }
}
