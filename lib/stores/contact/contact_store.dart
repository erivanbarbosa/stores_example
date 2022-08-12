import 'package:mobx/mobx.dart';
import 'package:redesprou_boilerplate_name/models/contact.dart';

part 'contact_store.g.dart';

class ContactStore = _ContactStore with _$ContactStore;

abstract class _ContactStore with Store {
  @observable
  Contact contact = Contact();
}
