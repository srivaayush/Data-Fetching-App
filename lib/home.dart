import 'package:flutter/material.dart';
import 'package:flutter_application_1/services.dart';

import 'data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  List<Data> data = [];

  bool loading = false;
  getData() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    data = await Service.getAllData();
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text('Data Fetched'),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: individualData(context, index),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
          );
  }

  Container individualData(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent,
        border: Border.all(
          width: 2,
          color: Colors.black,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'UserId:',
                ),
                Text(data[index].userId.toString()),
              ],
            ),
            Row(
              children: [
                const Text('Id:'),
                Text(data[index].id.toString()),
              ],
            ),
            Text('Body: ${data[index].body}'),
            // Text(data[index].body),
          ],
        ),
      ),
    );
  }
}
