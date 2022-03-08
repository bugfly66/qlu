import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'jwxt.dart';
import 'room_list.dart';

class QueryRoom extends StatefulWidget {
  final Jwxt Q;

  const QueryRoom({Key? key, required this.Q}) : super(key: key);

  @override
  _QueryRoomState createState() => _QueryRoomState();
}

class _QueryRoomState extends State<QueryRoom> {
  final dateController = TextEditingController();
  final idletimeController = TextEditingController();
  final xqidController = TextEditingController();


  @override
  void initState() {
    String date = "";
    String xqid = "1";
    String idleTime = "allday";
    DateFormat df = DateFormat("yyyy-MM-dd");
    date = df.format(DateTime.now());
    idletimeController.text = idleTime;
    dateController.text = date;
    xqidController.text = xqid;
    super.initState();
  }

  @override
  void dispose() {
    idletimeController.clear();
    dateController.clear();
    xqidController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                '校区代码',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                controller: xqidController,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                '查询日期',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 30,
              ),
              child: TextField(
                controller: dateController,
                // obscureText: true,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                '查询时间',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 30,
              ),
              child: TextField(
                controller: idletimeController,
                // obscureText: true,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 30,
              ),
              child: ElevatedButton(
                child: const Text(
                  '查询',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                            widthFactor: 88,
                            heightFactor: 88,
                            child: CircularProgressIndicator());
                      });
                  // if(date)
                  String idleTime = idletimeController.text;
                  String date = dateController.text;
                  String xqid = xqidController.text;
                  if (idleTime == "ad") {
                    idleTime = "allday";
                  } else if (idleTime == "a") {
                    idleTime = "am";
                  } else if (idleTime == "p") {
                    idleTime = "pm";
                  } else if (idleTime == "n") {
                    idleTime = "night";
                  }
                  // List dateTime = date.split("-");
                  //
                  // DateFormat df = DateFormat("yyyy-MM-dd");
                  // DateTime.now();
                  // date = df.format(DateTime(dateTime[0],dateTime[1],dateTime[2]));
                  widget.Q
                      .getClassroom(idleTime, date, xqid)
                      .exec()
                      .then((value) {
                    Navigator.pop(context);
                    // Navigator.pushNamedAndRemoveUntil(context, "/queryRoom", (route) => false,arguments: Q);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Data(data: value)),
                    );
                  });

                  // Q.getStudentInfo().exec(); //获取学生信息
                  // Q.getCurrentTime().exec(); //获取学年信息
                  // Q.getTable().exec(); //当前周次课表
                  // Q.getTable().setWeek("3").exec(); //指定周次课表
                  // Q.getGrade().exec(); //查询全部成绩
                  // Q.getGrade().setTerm("2018-2019-2").exec(); //指定学期成绩查询
                  // Q
                  //     .getClassroom("0102", "1")
                  //     .exec(); //空教室查询 "allday"：全天 "am"：上午 "pm"：下午 "night"：晚上 "0102":1.2节空教室 "0304":3.4节空教室
                  // Q.getExamInfo().exec(); //获取考试信息
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 30,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text("占位按钮"),
                        onPressed: () {}),
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text("占位按钮"),
                        onPressed: () {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
