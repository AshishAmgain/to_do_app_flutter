import 'package:dartz/dartz.dart';
import 'package:todo_app/core/failure/failure.dart';
import 'package:todo_app/domain/entity/todo_entity.dart';

abstract class MainDataSource {
  Future<Either<Failure, List<TodoEntity>>> getTodoList();
  Future<Either<Failure, bool>> createTodo(
      {required String title, required String description});

  Future<Either<Failure, bool>> updateTodo(TodoEntity todoEntity);
}
