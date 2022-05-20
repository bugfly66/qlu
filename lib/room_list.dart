import 'package:flutter/material.dart';

class Data extends StatefulWidget {
  final List data;

  const Data({Key? key, required this.data}) : super(key: key);

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  List rooms = [];

  @override
  void initState() {
    for (var element in widget.data) {
      rooms.add({"jxl": element["jxl"]});

      element["jsList"].forEach((ele) {
        if (!ele["jsmc"].contains(RegExp(r"室|实验|技术|化学")) &&
            !ele["jzwmc"].contains(RegExp(r"工程|操场|实验"))) {
          Map js = {
            "jsmc": ele["jsmc"], //教室名称
            "yxzws": ele["yxzws"], //有效座位数
            "jzwmc": ele["jzwmc"], //建筑物名称
          };
          rooms.add(js);
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            if (rooms[index]["jxl"] != null) {
              return ListTile(
                tileColor: Colors.lightBlueAccent,
                title: Text("${rooms[index]["jxl"]}"),
              );
            } else {
              return ListTile(
                title: Text("${rooms[index]["jsmc"]}"),
                subtitle: Text("${rooms[index]["jzwmc"]}"),
                trailing: Text("座位数:${rooms[index]["yxzws"]}"),
              );
            }
          }),
    );
  }
}
