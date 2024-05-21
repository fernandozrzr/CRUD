import 'package:firstly/home.dart';
import 'package:flutter/material.dart';
import 'package:firstly/model/product_model.dart';
import 'services/api.dart';

class EditScreen extends StatefulWidget {
  final Product data;
  const EditScreen({super.key, required this.data});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.data.pname;
    priceController.text = widget.data.pprice.toString();
    descController.text = widget.data.pdescription;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  "pdescription": descController.text,
                  "id": widget.data.id
                };

                Api.updateProduct(widget.data.id, data);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text("Update Data")),
        ],
      ),
    );
  }
}
