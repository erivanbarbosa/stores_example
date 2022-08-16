import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/di/components/service_locator.dart';
import 'package:redesprou_boilerplate_name/models/contact.dart';
import 'package:redesprou_boilerplate_name/stores/contact/contact_store.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/input_inline_label.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';

class ContactNamePartialPage extends StatefulWidget {
  final void Function() onSubmit;

  ContactNamePartialPage({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<ContactNamePartialPage> createState() => _ContactNamePartialPageState();
}

class _ContactNamePartialPageState extends State<ContactNamePartialPage> {
  final TextEditingController textEditingController = TextEditingController();
  late ContactStore _contactStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contactStore = getIt<ContactStore>();
    _contactStore.contact = new Contact();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Center(
        child: Column(
          children: [
            InputInlineLabel(
              label: "Qual o nome do contato?",
              width: 500,
            ),
            TextFieldWidget(
              textController: textEditingController,
            ),
            _buildNextButton()
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return MainButton(
      buttonText: "Avançar",
      buttonColor: Colors.white,
      textColor: Theme.of(context).primaryColor,
      borderColor: Theme.of(context).primaryColor,
      onPressed: () async {
        _contactStore.contact.name = textEditingController.text;
        widget.onSubmit();
      },
    );
  }
}
