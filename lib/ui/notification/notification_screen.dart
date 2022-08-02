import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/constants/colors.dart';
import 'package:redesprou_boilerplate_name/stores/notification/notification_store.dart';
import 'package:redesprou_boilerplate_name/stores/profile/profile_store.dart';
import 'package:redesprou_boilerplate_name/utils/message_utils.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationStore _notificationStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _notificationStore = Get.find();
    await _notificationStore.findNotifications();
    _notificationStore.markAsRead();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppScreen(
      screenTitle: translate(context, "notifications"),
      screenBody: _notificationStore.loading ? [] : _buildBody(),
      loading: _notificationStore.loading,
      contentAlign: Alignment.topCenter,
    );
  }

  List<Widget> _buildBody() {
    return [
      Observer(builder: (context) {
        return _notificationStore.notifications!.length > 0
            ? Container(
                margin: EdgeInsets.only(top: 30),
                height: _notificationStore.notifications!.length * 105,
                child: ListView.builder(
                  itemCount: _notificationStore.notifications!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1,
                      margin: EdgeInsets.only(bottom: 15),
                      child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          direction: Axis.horizontal,
                          child: _listTile(index, context),
                          secondaryActions: _secondaryActions(index)),
                    );
                  },
                ),
              )
            : Container();
      })
    ];
  }

  List<Widget> _secondaryActions(index) {
    return <Widget>[
      IconSlideAction(
        caption: 'Excluir',
        color: AppColors.purple[500]!,
        icon: Icons.delete,
        onTap: () => delete(_notificationStore.notifications![index].id!),
      ),
    ];
  }

  ListTile _listTile(int index, BuildContext context) {
    return ListTile(
      onLongPress: () => delete(_notificationStore.notifications![index].id!),
      contentPadding: EdgeInsets.only(left: 10),
      leading: _leading(context),
      title: _title(index),
      subtitle: _subtitle(index),
      isThreeLine: true,
    );
  }

  Column _subtitle(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_notificationStore.notifications![index].body!),
        Text(_notificationStore.notifications![index].createdAt!),
      ],
    );
  }

  Text _title(int index) => Text(_notificationStore.notifications![index].title!);

  CircleAvatar _leading(BuildContext context) {
    return CircleAvatar(
      radius: 30.0,
      child: Icon(
        Icons.message,
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  delete(int id) {
    showAlert(context, "Atenção", Text("Deseja excluir essa notificação?"), popActionText: translate(context, 'no'), actions: [_confirmActionButton(id)]);
  }

  Widget _confirmActionButton(int id) {
    return FlatButton(
      child: Text(translate(context, 'yes')),
      onPressed: () {
        _notificationStore.deleteNotification(id);
        Get.back();
      },
    );
  }
}
