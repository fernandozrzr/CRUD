import 'package:flutter/material.dart';
import '/services/api.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Name"),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(hintText: "Price"),
          ),
          TextField(
            controller: descController,
            decoration: const InputDecoration(hintText: "Description"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                var data = {
                  "pname": nameController.text,
                  "pprice": priceController.text,
                  "pdescription": descController.text
                };

                Api.addProduct(data);
              },
              child: const Text("Create Data")),
        ],
      ),
    );
  }
}
