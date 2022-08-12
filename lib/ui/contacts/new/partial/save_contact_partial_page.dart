import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/di/components/service_locator.dart';
import 'package:redesprou_boilerplate_name/stores/contact/contact_store.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/texts/table_row_title.dart';
import 'package:redesprou_boilerplate_name/widgets/texts/title_message.dart';
import 'package:flutter/services.dart';

class SaveContactPartialPage extends StatefulWidget {
  final void Function() onSubmit;

  SaveContactPartialPage({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<SaveContactPartialPage> createState() => _SaveContactPartialPageState();
}

class _SaveContactPartialPageState extends State<SaveContactPartialPage> {
  final TextEditingController textEditingController = TextEditingController();
  late ContactStore _contactStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contactStore = getIt<ContactStore>();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Center(
        child: Column(
          children: [
            TitleMessage(title: "Deseja realmente salvar esse contato?"),
            _buildContactResume(),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return MainButton(
      
      buttonText: "SALVAR CONTATO",
      buttonColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      borderColor: Theme.of(context).primaryColor,
      onPressed: _contactStore.contact.isValid() ? () async {
        if (_contactStore.contact.isValid()) {
          widget.onSubmit();
        }
      } : null,
    );
  }

  _buildContactResume() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 8),
      child: Table(
        children: [
          TableRow(children: [TableRowTitle("Nome: "), Text(_contactStore.contact.name!)]),
          TableRow(children: [TableRowTitle("Nascimento: "), Text(_contactStore.contact.birthDate!)]),
          TableRow(children: [TableRowTitle("Telefone: "), Text(_contactStore.contact.phone!)]),
          TableRow(children: [TableRowTitle("Email: "), Text(_contactStore.contact.email!)]),
        ],
      ),
    );
  }
}
