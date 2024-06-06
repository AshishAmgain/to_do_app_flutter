import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/failure/failure.dart';
import 'package:todo_app/domain/entity/todo_entity.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';

final getAllTodoUsecaseProvider = Provider<GetAllTodoUseCase>((ref) {
  return GetAllTodoUseCase(ref.read(todoRepositoryProvider));
});

class GetAllTodoUseCase {
  final ITodoRepository _todoRepository;

  GetAllTodoUseCase(this._todoRepository);

  Future<Either<Failure, List<TodoEntity>>> execute() async {
    return await _todoRepository.getTodoList();
  }
}
