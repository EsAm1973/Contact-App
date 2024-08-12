import 'package:contacts_app/Database/helper.dart';
import 'package:contacts_app/Models/contact.dart';
import 'package:contacts_app/Screens/Home.dart';
import 'package:flutter/material.dart';

class UpdateDelete extends StatefulWidget {
  const UpdateDelete({super.key, required this.contact});
  final Contact contact;

  @override
  State<UpdateDelete> createState() => _UpdateDeleteState();
}

class _UpdateDeleteState extends State<UpdateDelete> {
  TextEditingController textname = TextEditingController();
  TextEditingController textphone = TextEditingController();
  TextEditingController textimgurl = TextEditingController();

  @override
  void initState() {
    super.initState();
    textname.text = widget.contact.name;
    textphone.text = widget.contact.phone;
    textimgurl.text = widget.contact.imgUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Contact Details',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          foregroundColor: Colors.blue.shade700,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Image.network(
                      widget.contact.imgUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  TextField(
                    controller: textname,
                  ),
                  TextField(
                    controller: textphone,
                  ),
                  TextField(
                    controller: textimgurl,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Save Contact",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: const Text(
                                "Are you sure you want to Save Changes?",
                                style: TextStyle(fontSize: 20),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    var updatedContact = Contact({
                                      'id': widget.contact.id,
                                      'name': textname.text,
                                      'phone': textphone.text,
                                      'imgUrl': textimgurl.text,
                                    });
      
                                    await Db_Helper()
                                        .contactUpdate(updatedContact);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => const HomePage()),
                                        (route) => false);
                                  },
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'SAVE',
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Delete Contact",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: const Text(
                                "Are you sure you want to Delete this Contact?",
                                style: TextStyle(fontSize: 20),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await Db_Helper()
                                        .deleteContact(widget.contact.id);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => const HomePage()),
                                        (route) => false);
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'DELETE',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
