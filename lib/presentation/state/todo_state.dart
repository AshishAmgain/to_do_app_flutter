import 'package:todo_app/domain/entity/todo_entity.dart';

class TodoState {
  final List<TodoEntity> todos;
  final bool isLoading;
  final String? error;

  TodoState({
    required this.todos,
    required this.isLoading,
    this.error,
  });

  factory TodoState.initial() {
    return TodoState(
      todos: [],
      isLoading: false,
    );
  }

  TodoState copyWith({
    List<TodoEntity>? todos,
    bool? isLoading,
    String? error,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
