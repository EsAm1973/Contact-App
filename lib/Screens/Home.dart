import 'package:contacts_app/Database/helper.dart';
import 'package:contacts_app/Models/contact.dart';
import 'package:contacts_app/Widgets/add_contact_sheet.dart';
import 'package:contacts_app/Widgets/contact_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    var dbHelper = Db_Helper();
    List<Map<String, dynamic>> contacts = await dbHelper.getContacts();
    setState(() {
      _contacts = contacts.map((contact) => Contact.fromMap(contact)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                      context: context,
                      builder: (context) => const AddContactSheet())
                  .then((_) => _fetchContacts());
            },
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue.shade700,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          appBar: AppBar(
            title: const Text(
              'My Contacts',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            foregroundColor: Colors.blue.shade700,
            backgroundColor: Colors.white,
          ),
          body: _contacts.isEmpty
              ? const Center(
                  child: Text('No Contacts Available'),
                )
              : FutureBuilder(
                  future: Db_Helper().getContacts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ContactsGrid(contacts: _contacts);
                    }
                  },
                )),
    );
  }
}
