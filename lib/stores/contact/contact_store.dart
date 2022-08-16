import 'package:mobx/mobx.dart';
import 'package:redesprou_boilerplate_name/models/contact.dart';
import 'package:redesprou_boilerplate_name/services/contact_service.dart';

part 'contact_store.g.dart';

class ContactStore = _ContactStore with _$ContactStore;

abstract class _ContactStore with Store {
  @observable
  Contact contact = Contact();

  @observable
  List<Contact> contacts = [];

  ContactService _service = ContactService();

  @action
  void saveContact() {
    _service.saveContact(contact);
  }

  @action
  void loadContacts() {
    this.contacts = _service.findContacts();
    print(contacts);
  }
}
