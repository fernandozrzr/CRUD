import 'package:flutter/material.dart';
import 'services/api.dart';
import 'package:firstly/model/product_model.dart';
import 'edit.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Products"),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditScreen(data: pdata[index]),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
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
