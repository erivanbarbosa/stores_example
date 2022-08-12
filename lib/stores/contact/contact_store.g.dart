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

  @override
  String toString() {
    return '''
contact: ${contact}
    ''';
  }
}
