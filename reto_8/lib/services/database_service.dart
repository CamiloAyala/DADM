import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:reto_8/models/company_model.dart';
import 'package:reto_8/models/company_type.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService 
{

  Database? _database;

  Future init() async{
    _database = await getDatabase();
  }

  Future<Database> getDatabase() async{

    final database = await openDatabase(
      join(await getDatabasesPath(), 'company_database_2.db'),
      onCreate: (db, version) {
        return db.execute(
          """
          CREATE TABLE companies(
            id INTEGER PRIMARY KEY, 
            name TEXT, 
            website TEXT, 
            phone TEXT, 
            email TEXT,
            products TEXT,
            type TEXT
          );
          """,
        );
      },
      version: 1,
    );


    return database;

  }


  Future<List<Company>> getCompanies() async {
    try {
      if(_database == null) {
        await init();
      }

      final List<Map<String, dynamic>> maps = await _database!.query('companies');

      if(maps.isEmpty) {
        return [];
      }

      return List.generate(maps.length, (i) {

        return Company(
          id: maps[i]['id'] as int,
          name: maps[i]['name'] as String,
          website: maps[i]['website'] as String,
          phone: maps[i]['phone'] as String,
          email: maps[i]['email'] as String,
          products: maps[i]['products'] as String,
          type: maps[i]['type'] == 'Consultoría' ? CompanyType.consulting : CompanyType.software,
        );
      });

    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }


  Future<int> addCompany({required Company company}) async{
    try {

      if(_database == null) {
        await init();
      }

      final companyInfo = company.toMap();
      int id = await _database!.insert(
        'companies', 
        companyInfo,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      debugPrint('Company added with id: $id');

      return id;
    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }


  Future<int> updateCompany({required int companyId, required Company company}) async {
    try {
      if(_database == null) {
        await init();
      }

      final companyInfo = company.toMap();
      int count = await _database!.update(
        'companies', 
        companyInfo,
        where: 'id = ?',
        whereArgs: [companyId],
      );

      debugPrint('Number of updated companies: $count');

      return count;

    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }


  Future<int> deleteCompany(int companyId) async {
    try {
      if(_database == null) {
        await init();
      }

      int deleteCount = await _database!.delete(
        'companies', 
        where: 'id = ?',
        whereArgs: [companyId],
      );

      debugPrint('Number of deleted companies: $deleteCount');
      return deleteCount;

    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }
}