import 'dart:async';

import 'package:flutter_member_app02/model/member.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Database_Helper {
  static final Database_Helper instance = Database_Helper._init();
  static Database? _database;

  Database_Helper._init();

  // 데이터베이스 객체 가져오기
  Future<Database> get database async {
    if (_database != null) return _database!;
    // 데이터베이스 객체가 없다면 새로 생성
    _database = await _initDB('member.db');

    return _database!;
  }

  // 데이터베이스 초기화
  Future<Database> _initDB(String filePath) async {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(path, version: 1, onCreate: _createDB,);
  }

  // 테이블 생성
  FutureOr<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE member (
        mno INTEGER PRIMARY KEY AUTOINCREMENT,
        userid TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  // 회원정보 저장
  Future<int> insertMember(Member m) async {
    final db = await instance.database;
    return await db.insert('member', m.toMap());
  }
}
