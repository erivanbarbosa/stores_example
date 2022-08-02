import 'package:flutter/material.dart';

import 'package:redesprou_boilerplate_name/utils/string_utils.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final String? profileImageUrl;
  final String? coverImageUrl;
  final VoidCallback onTap;
  final double size;
  final bool assetImage;

  ProfilePhotoWidget({
    Key? key,
    this.profileImageUrl,
    this.coverImageUrl,
    required this.onTap,
    this.size = 150,
    this.assetImage = false,
  }) : super(key: key);

  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Material(
      color: Colors.white,
      child: _buildInkWell(),
    );
  }

  InkWell _buildInkWell() {
    return InkWell(
      onTap: onTap,
      child: _buildContainer(),
    );
  }

  Container _buildContainer() {
    return Container(
      width: size,
      height: size,
      child: _buildStack(),
    );
  }

  Widget _buildStack() {
    return Stack(children: [
      _buildCover(),
      isNotBlank(profileImageUrl) ? _buildProfilePhoto() : Container(),
    ]);
  }

  _buildCover() {
    return Container(
      height: size / 2 + (size / 6),
      width: double.infinity,
      child: isNotBlank(coverImageUrl)
          ? Image.network(
              coverImageUrl!,
              fit: BoxFit.cover,
            )
          : Container(),
    );
  }

  Widget _buildProfilePhoto() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(_context!).primaryColor,
              width: 2,
            )),
        child: Container(
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: assetImage ? BoxFit.fitHeight : BoxFit.cover,
                  image: _getImage(),
                ))),
      ),
    );
  }

  _getImage() {
    return assetImage ? AssetImage(profileImageUrl!) : NetworkImage(profileImageUrl!);
  }
}
