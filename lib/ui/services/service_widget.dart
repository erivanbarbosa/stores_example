import 'package:flutter/material.dart';

import 'package:redesprou_boilerplate_name/models/services/service.dart';
import 'package:redesprou_boilerplate_name/widgets/texts/center_text.dart';

class ServiceWidget extends StatelessWidget {
  final Service service;
  const ServiceWidget({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: _buildService(service, context),
    );
  }

  _buildService(Service service, context) {
    return Column(
      children: [
        CenterText(
          text: service.title!,
          fontSize: 16,
        ),
        CenterText(text: _getAttendance()),
        SizedBox(height: 15),
        _getImage(),
        Divider(
          height: 30,
        ),
      ],
    );
  }

  String _getAttendance() {
    String? homeCare = service.home_care! ? "Em domicílio" : "";
    String? ownAddress = service.own_address! ? "Endereço próprio" : "";

    String result = "";

    if (homeCare.isNotEmpty && ownAddress.isNotEmpty) {
      result = "$homeCare - $ownAddress";
    } else if (homeCare.isEmpty && ownAddress.isNotEmpty) {
      result = "$ownAddress";
    } else if (homeCare.isNotEmpty && ownAddress.isEmpty) {
      result = "$homeCare";
    } else if (homeCare.isEmpty && ownAddress.isEmpty) {
      result = service.description ?? "";
    }
    return result;
  }

  _getImage() {
    return service.medias != null && service.medias!.length > 0 ? _buildImage() : _buildDefaultPhoto();
  }

  Widget _buildImage() {
    return Container(
      height: 150,
      width: double.infinity,
      child: Image.network(
        service.medias![0].url!,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  _buildDefaultPhoto() {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            child: Image.network(
              'http://4.bp.blogspot.com/-K1mYxuMMc30/UiGCZ6nE1JI/AAAAAAAAFiU/B1nz4RYeYWk/s1600/Banner-Tools1.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            // height: 150,
            //  width: double.infinity,
            color: Colors.white.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}
