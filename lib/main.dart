import 'package:flutter/material.dart';
import 'package:flutter_member_app02/helper/database_helper.dart';
import 'package:flutter_member_app02/model/member.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Window, Linux 앱 실행시
  // databaseFactory = databaseFactoryFfi;
  // sqfliteFfiInit();

  // web앱 실행시
  // dart run sqflite_common_ffi_web:setup (터미널)
  databaseFactory = databaseFactoryFfiWeb;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '플러터 회원가입 앱',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainActivity(title: ' cOwO7 '),
    );
  }
}

class MainActivity extends StatefulWidget {
  const MainActivity({super.key, required this.title});


  final String title;

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {

  // 변수 정의
  final Database_Helper _dbHelper = Database_Helper.instance;
  final TextEditingController _useridController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Text('회원가입 앱', style: TextStyle(fontSize: 34), textAlign: TextAlign.center,),
              SizedBox(height: 150,),
              TextField(controller: _useridController, decoration: const InputDecoration(hintText: '아이디 입력'),),
              TextField(controller: _passwordController, decoration: const InputDecoration(hintText: '비밀번호 입력'),),
              TextField(controller: _nameController, decoration: const InputDecoration(hintText: '이름 입력'),),
              TextField(controller: _emailController, decoration: const InputDecoration(hintText: '이메일 입력'),),
              SizedBox(height: 16,),
              ElevatedButton(onPressed: _registerUser, child: Container(
                width: double.infinity, child: Text('회원 가입', textAlign: TextAlign.center,),
              )),
              SizedBox(height: 16,),
              ElevatedButton(onPressed: _listUsers, child: Container(
                width: double.infinity, child: Text('회원 조회', textAlign: TextAlign.center,),
              ))
          ],
        ),
      ), // SingleChildScrollView
    ),
    );
  } // build

 // 회원가입 처리
  Future<void> _registerUser() async {
    // 입력한 회원 정보 가져오기
    String userid = _useridController.text.trim();
    String password = _passwordController.text.trim();
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();

    // showSnackBar : 간단한 메세지 출력
    // 입력 내용 확인
    if (userid.isEmpty || password.isEmpty || name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
              '모든 필드를 입력하라!!!!!!!!!!!!!!! 모든 필드를 한놈도 빠짐없이 입력하.라!!!!!!!!!!!!!ㅇㅅㅇd'))
      );
    }
    // 저장할 회원 객체 생성
    final member = Member(
        userid: userid, password: password, name: name, email: email
    );

    // 회원 정보 저장 처리
    final result = await _dbHelper.insertMember(member);

    if (result > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입에 성공했다!!!!!!!!!!'))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('회원가입 까비알론소~~'))
      );
    }
  } // _registerUser

  // 회원조회 처리
  Future<void> _listUsers() async {
    // showSnackBar : 간단한 메세지 출력
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원조회 기능 구현중...'))
    );
  } // _listUsers
} // _MainActivityState

