import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/di/components/service_locator.dart';
import 'package:redesprou_boilerplate_name/stores/contact/contact_store.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/input_inline_label.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';

class ContactPhonePartialPage extends StatefulWidget {
  final void Function() onSubmit;

  ContactPhonePartialPage({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<ContactPhonePartialPage> createState() => _ContactPhonePartialPageState();
}

class _ContactPhonePartialPageState extends State<ContactPhonePartialPage> {
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
              label: "Qual o seu telefone?",
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
        _contactStore.contact.phone = textEditingController.text;
        widget.onSubmit();
      },
    );
  }
}
