import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:redesprou_boilerplate_name/constants/colors.dart';
import 'package:redesprou_boilerplate_name/models/media.dart';

class ImageGallery extends StatefulWidget {
  //final List<String>? imageUrls;
  final List<Media>? medias;
  final int count;

  const ImageGallery({
    Key? key,
    //required this.imageUrls,
    required this.medias,
    this.count = 2,
  }) : super(key: key);

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.medias == null || widget.medias!.length == 0
        ? Container()
        : GridView.count(
            crossAxisCount: widget.count,
            children: List.generate(widget.medias!.length, (index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                direction: Axis.horizontal,
                actionExtentRatio: 0.5,
                secondaryActions: _secondaryActions(widget.medias![index]),
                child: Container(
                  padding: EdgeInsets.all(2),
                  child: Image.network(
                    widget.medias![index].url!,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          );
  }

  List<Widget> _secondaryActions(Media media) {
    return <Widget>[
      IconSlideAction(
        caption: 'Excluir',
        color: AppColors.purple[500]!,
        icon: Icons.delete,
        onTap: () async {
          widget.medias!.remove(media);
          setState(() {});
        },
      ),
    ];
  }
}
