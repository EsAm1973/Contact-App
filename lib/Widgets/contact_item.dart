import 'package:contacts_app/Models/contact.dart';
import 'package:contacts_app/Screens/Contact_Details.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ContactsGrid extends StatelessWidget {
  final List<Contact> contacts;

  const ContactsGrid({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 2,
      ),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        Contact contact = contacts[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => UpdateDelete(contact: contact),
              ),
              (route) => false,
            );
          },
          child: Container(
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 130,
                    width: 130,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: contact.imgUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    contact.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    contact.phone,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
