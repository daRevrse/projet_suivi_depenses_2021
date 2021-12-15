import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'project.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          nom STRING NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE transactions (
          id INTEGER PRIMARY KEY,
          titre TEXT,
          description TEXT,
          montant NUMERIC,
          type TEXT
      )
      ''');

    await db.execute('''
      CREATE TABLE comptes (
          id INTEGER PRIMARY KEY,
          nom TEXT,
          description TEXT,
          montant NUMERIC
      )
      ''');
  }


}