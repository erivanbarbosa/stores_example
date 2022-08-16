import 'package:redesprou_boilerplate_name/data/repository/contact_repository.dart';
import 'package:redesprou_boilerplate_name/models/contact.dart';

class ContactService {
  ContactsRepository repository = ContactsRepository();

  void saveContact(Contact contact) {
    repository.save(contact);
  }

  List<Contact> findContacts() {
    return repository.findContacts();
  }
}
