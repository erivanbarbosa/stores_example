import 'package:redesprou_boilerplate_name/models/notification/notification.dart';

import 'data_base_sqflite.dart';

class PushNotificationDao extends DatabaseSqflite {
  static const String TABLE = 'Pushnotification';
  static const String SELECT = 'SELECT * FROM $TABLE';
  static const String SELECT_COUNT = 'SELECT COUNT(*) FROM $TABLE';

  static PushNotificationDao? _instance;

  final String colId = 'id';
  final String colMessage = 'body';
  final String colTitle = 'title';
  final String createdAt = 'created_at';
  final String colRead = 'read';

  static PushNotificationDao of() {
    if (_instance == null) {
      _instance = PushNotificationDao();
      return _instance!;
    }

    return _instance!;
  }

  Future<List> getTable() async {
    List result = await super.getTable_(TABLE);
    return result.toList();
  }

  Future<List<NotificationMessage>> getRawTable() async {
    List list = await super.getTable_(TABLE);
    final notifications = list.map<NotificationMessage>((json) => NotificationMessage.fromJson(json)).toList();
    return notifications;
  }

  Future<List> getById(int id) async {
    return await super.getById_(TABLE, colId, id);
  }

  Future<int> getCount() async {
    return await super.getCount_(TABLE);
  }

  Future<int> getCountUnreads() async {
    return await super.countUnreads(TABLE);
  }

  Future<int> getNextId() async {
    return await super.getNextId_(TABLE, colId);
  }

  Future<int> insert(Map<String, dynamic> options) async {
    return await super.insert_(TABLE, options);
  }

  Future<int> update(Map<String, dynamic> options, int id) async {
    return await super.update_(TABLE, '$colId = ?', options, id);
  }

  Future<int> updateAsRead() async {
    return await super.updateAsRead();
  }

  Future<int> delete(int id) async {
    return await super.delete_(TABLE, '$colId = ?', id);
  }

  Future<int> deleteAll() async {
    return await super.deleteAll_(TABLE);
  }
}
