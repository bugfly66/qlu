import 'package:flutter/material.dart';
import 'jwxt.dart';
import 'query_room.dart';
import 'storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final pwdController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    pwdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Storage.getData("userid").then((value) {
      idController.text = value!;
    });
    Storage.getData("userpwd").then((value) {
      pwdController.text = value!;
    });
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Logo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const Text(
              '登录',
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
              controller: idController,
              decoration: const InputDecoration(
                hintText: '教务系统学号',
                labelText: '学号',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 30,
            ),
            child: TextField(
              controller: pwdController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: '请输入你的密码',
                labelText: '密码',
              ),
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
                '登录',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Jwxt Q = Jwxt(idController.text, pwdController.text);
                try {
                  await Q.connect();
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("错误"),
                      content: Text("$e"),
                    ),
                  );
                  return;
                }

                Storage.setData("userid", idController.text);
                Storage.setData("userpwd", pwdController.text);
                // Navigator.pushNamedAndRemoveUntil(context, "/queryRoom", (route) => false,arguments: Q);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => QueryRoom(Q: Q)),
                    (route) => false);
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
                      child: const Text("好好学习"),
                      onPressed: () {}),
                ),
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text("天天向上"),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
