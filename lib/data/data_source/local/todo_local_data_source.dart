import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/failure/failure.dart';
import 'package:todo_app/data/data_source/main_data_source.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/domain/entity/todo_entity.dart';

final todoLocalDataSourceProvider = Provider<TodoLocalDataSource>((ref) {
  return TodoLocalDataSource();
});

class TodoLocalDataSource extends MainDataSource {
  @override
  Future<Either<Failure, bool>> createTodo(
      {required String title, required String description}) {
    // TODO: implement createTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodoList() async {
    try {
      // Start time for 2 seconds
      await Future.delayed(const Duration(seconds: 2));

      final data = await rootBundle.loadString('data/todos.json');
      final jsonData = json.decode(data) as List;
      final todoList =
          jsonData.map((e) => TodoModel.fromJson(e).toEntity()).toList();
      return Right(todoList);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateTodo(TodoEntity todoEntity) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
