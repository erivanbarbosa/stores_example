import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/di/components/service_locator.dart';
import 'package:redesprou_boilerplate_name/stores/contact/contact_store.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/input_inline_label.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';

class ContactBirthDatePartialPage extends StatefulWidget {
  final void Function() onSubmit;

  ContactBirthDatePartialPage({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<ContactBirthDatePartialPage> createState() => _ContactBirthDatePartialPageState();
}

class _ContactBirthDatePartialPageState extends State<ContactBirthDatePartialPage> {
  final TextEditingController textEditingController = TextEditingController();
  late ContactStore _contactStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contactStore = getIt<ContactStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Center(
        child: Column(
          children: [
            InputInlineLabel(
              label: "Qual a sua data de nascimento?",
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
        _contactStore.contact.birthDate = textEditingController.text;
        widget.onSubmit();
      },
    );
  }
}
