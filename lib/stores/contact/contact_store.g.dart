// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactStore on _ContactStore, Store {
  final _$contactAtom = Atom(name: '_ContactStore.contact');

  @override
  Contact get contact {
    _$contactAtom.reportRead();
    return super.contact;
  }

  @override
  set contact(Contact value) {
    _$contactAtom.reportWrite(value, super.contact, () {
      super.contact = value;
    });
  }

  final _$contactsAtom = Atom(name: '_ContactStore.contacts');

  @override
  List<Contact> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(List<Contact> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  final _$_ContactStoreActionController =
      ActionController(name: '_ContactStore');

  @override
  void saveContact() {
    final _$actionInfo = _$_ContactStoreActionController.startAction(
        name: '_ContactStore.saveContact');
    try {
      return super.saveContact();
    } finally {
      _$_ContactStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadContacts() {
    final _$actionInfo = _$_ContactStoreActionController.startAction(
        name: '_ContactStore.loadContacts');
    try {
      return super.loadContacts();
    } finally {
      _$_ContactStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
contact: ${contact},
contacts: ${contacts}
    ''';
  }
}
