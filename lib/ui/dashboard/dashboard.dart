import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:redesprou_boilerplate_name/di/components/service_locator.dart';
import 'package:redesprou_boilerplate_name/models/contact.dart';
import 'package:redesprou_boilerplate_name/stores/contact/contact_store.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/alternative_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/layout/custom_container.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ContactStore _contactStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contactStore = getIt<ContactStore>();
    _contactStore.loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return AlternativeAppScreen(
          showNotifications: true,
          floatingActionButton: FloatingActionButton(
            onPressed: () => {Navigator.of(context).pushNamed(Routes.new_contact)},
            child: Icon(Icons.add),
          ),
          screenBody: Stack(
            children: [
              CustomContainer(),
              Column(
                children: [
                  _buildPageTitle(),
                  _buildPageContent(),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Container _buildPageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 25, right: 25),
      child: Text(
        "Meus Contatos",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Expanded _buildPageContent() {
    return Expanded(
        child: Container(
      height: 120,
      margin: EdgeInsets.only(top: 80, left: 25, right: 25, bottom: 25),
      child: _buildList(),
    ));
  }

  Observer _buildList() {
    return Observer(builder: (context) {
      return _contactStore.contacts.length > 0
          ? Container(
              height: MediaQuery.of(context).size.height - 150,
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: _contactStore.contacts.length,
                    itemBuilder: (context, index) {
                      return _buildListTile(_contactStore.contacts[index]);
                    },
                  ),
                ],
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height - 200,
              child: Center(child: Text("Nenhum item encontrado")),
            );
    });
  }

  _buildListTile(Contact contact) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10, top: 10),
      title: Text(contact.name ?? "", style: TextStyle(color: Theme.of(context).primaryColor),),
      leading: _buildAvatar(contact),
      subtitle: Text(contact.email!),
      horizontalTitleGap: 20,
    );
  }

  CircleAvatar _buildAvatar(Contact contact) {
    return CircleAvatar(
      radius: 30.0,
      child: Text(
        contact.name!.split("").first.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}
