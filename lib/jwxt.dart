import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class Jwxt {
  /**
   * 强智教务系统
   */
  ////////////////////////////////////////////////////////
  String account = "";
  String password = "";
  String url = "http://jwxt.qlu.edu.cn/app.do";

  ////////////////////////////////////////////////////////

  /**
   * 注意：由于处理Json需要引入Json包，所以暂时不处理Json数据，假设当前学期是2018-2019-2，当前周次是18周
   * 引入Json包后可以直接调用getCurrentTime()方法得到字符串再转化为Json获取数据
   * 其实学期与当前周次是可以自行计算的，还可以减少对强智服务器的请求
   */
  ////////////////////////////////////////////////////////
  String curWeek = "10";
  String curTerm = "2021-2022-2";

  ////////////////////////////////////////////////////////

  Map<String, String>? params = <String, String>{};
  Map<String, String>? headers = <String, String>{};

  Jwxt(this.account, this.password) {
    params!.addAll({"method": "authUser"});
    params!.addAll({"xh": account});
    params!.addAll({"pwd": password});
  }

  Future<Jwxt> connect() async {
    await Dio()
        .get(
      url,
      queryParameters: params,
      options: Options(method: 'GET', headers: headers),
    )
        .then((value) {
      Map jsonMap = json.decode(value.data);
      Map<String, String> reqResultMap = jsonMap.cast<String, String>();
      // print(reqResultMap.toString());
      if (reqResultMap["flag"] == "0") {
        // print("登录失败");
        // exit(0);
        throw "登录失败,请检查密码学号！";
      } else {

        // print("setheader"+reqResultMap["token"]!);
        headers!.addAll({"token": reqResultMap["token"]!});
      }
    });
    return this;
  }

  Jwxt getStudentInfo() {
    params!.addAll({"method": "getUserInfo"});
    params!.addAll({"xh": account});
    return this;
  }

  Jwxt getCurrentTime() {
    DateFormat df = DateFormat("yyyy-MM-dd");
    params!.addAll({"method": "getCurrentTime"});
    params!.addAll({"currDate": df.format(DateTime.now())});
    return this;
  }

  Jwxt getTable() {
    params!.addAll({"method": "getKbcxAzc"});
    params!.addAll({"xh": account});
    params!.addAll({"xnxqid": curTerm});
    params!.addAll({"zc": curWeek});
    return this;
  }

  Jwxt setWeek(String week) {
    params!.addAll({"zc": week});
    return this;
  }

  Jwxt getGrade() {
    params!.addAll({"method": "getCjcx"});
    params!.addAll({"xh": account});
    params!.addAll({"xnxqid": ""});
    return this;
  }

  Jwxt setTerm(String term) {
    params!.addAll({"xnxqid": term});
    return this;
  }

  Jwxt getXqid() {
    params!.addAll({"method": "getXqcx"});
    return this;
  }

  Jwxt getClassroom(String idleTime, String date, String xqid) {
    DateFormat df = DateFormat("yyyy-MM-dd");
    String time = date == "" ? df.format(DateTime.now()) : date;
    params!.addAll({"method": "getKxJscx"});
    params!.addAll({"xqid": xqid});
    params!.addAll({"time": time});
    params!.addAll({"idleTime": idleTime});
    return this;
  }

  Jwxt getExamInfo() {
    params!.addAll({"method": "getKscx"});
    params!.addAll({"xh": account});
    return this;
  }

  Future<List<Map<String, dynamic>>> exec() async {
    List<Map<String, dynamic>> resultList = [];
    // print("head"+headers.toString());
    await Dio()
        .get(url,
            queryParameters: params,
            options: Options(
              method: 'GET',
              headers: headers,
            ))
        .then((value) {
      // print("exec:"+value.data);
      List jsonList = json.decode(value.data);
      resultList = jsonList.cast<Map<String, dynamic>>();
      // print("exec:"+jsonList.toString());
      params!.clear();
    });

    return resultList;
  }
}
