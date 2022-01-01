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
          id INTEGER PRIMARY KEY NOT NULL,
          datetime TEXT,
          description TEXT,
          montant NUMERIC,
          type TEXT,
          user_id INTEGER NOT NULL,
          compte_id INTEGER NOT NULL,
          cat_id INTEGER NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
          FOREIGN KEY (compte_id) REFERENCES comptes (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
          FOREIGN KEY (cat_id) REFERENCES categories (id) ON DELETE NO ACTION ON UPDATE NO ACTION
      )
      ''');

    await db.execute('''
      CREATE TABLE remboursements (
          id INTEGER PRIMARY KEY NOT NULL,
          datetime TEXT,
          montant NUMERIC,
          user_id INTEGER NOT NULL,
          compte_id INTEGER NOT NULL,
          dette_id INTEGER NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
          FOREIGN KEY (compte_id) REFERENCES comptes (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
          FOREIGN KEY (dette_id) REFERENCES dettes (id) ON DELETE NO ACTION ON UPDATE NO ACTION
      )
      ''');

    await db.execute('''
      CREATE TABLE comptes (
          id INTEGER PRIMARY KEY NOT NULL,
          nom TEXT,
          description TEXT,
          montant NUMERIC,
          color INTEGER,
          user_id INTEGER NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users (id)
      )
      ''');

    await db.execute('''
      CREATE TABLE dettes (
          id INTEGER PRIMARY KEY NOT NULL,
          creancier TEXT,
          description TEXT,
          montant NUMERIC,
          restant NUMERIC,
          datetime TEXT,
          user_id INTEGER NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users (id)
      )
      ''');

    await db.execute('''
      CREATE TABLE budgets (
          id INTEGER PRIMARY KEY NOT NULL,
          titre TEXT,
          description TEXT,
          montant NUMERIC,
          restant NUMERIC,
          date_debut TEXT,
          date_fin TEXT,
          user_id INTEGER NOT NULL,
          cat_id INTEGER NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
          FOREIGN KEY (cat_id) REFERENCES categories (id) ON DELETE NO ACTION ON UPDATE NO ACTION
      )
      ''');

    await db.execute('''
      CREATE TABLE categories (
          id INTEGER PRIMARY KEY NOT NULL,
          nom TEXT,
          type TEXT,
          color INTEGER,
          user_id INTEGER NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users (id)
      )
      ''');
  }


}