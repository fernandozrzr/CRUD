import 'package:firstly/services/api.dart';
import 'package:flutter/material.dart';
import 'package:firstly/model/product_model.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Products"),
      ),
      body: FutureBuilder(
        future: Api.getProduct(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print("No data found");
            return const Center(
              child: Text("No products available"),
            );
          } else {
            List<Product> pdata = snapshot.data!;

            return ListView.builder(
              itemCount: pdata.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.storage),
                  title: Text(pdata[index].pname),
                  subtitle: Text(pdata[index].pdescription),
                  trailing: IconButton(
                    onPressed: () {
                      Api.deleteProduct(pdata[index].id);
                      pdata.removeAt(index);
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
