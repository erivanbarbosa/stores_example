import 'package:redesprou_boilerplate_name/models/contact.dart';

class ContactsRepository {
  static List<Contact> contacts = [];

  void save(Contact contact) {
    contacts.add(contact);
  }

  List<Contact> findContacts() {
    return contacts;
  }
}
