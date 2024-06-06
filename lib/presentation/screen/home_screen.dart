import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/providers/remainng_todo_provider.dart';
import 'package:todo_app/presentation/controller/todo_controller.dart';
import 'package:todo_app/presentation/widgets/header_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var todos = ref.watch(todoControllerProvider);

    if (todos.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SizedBox.expand(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 40),
            const HeaderWidget(),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const TopRow(),
                      const Header(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            labelText: 'Search your tasks...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: '${ref.watch(remianingTodoProvider)} of ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            children: [
                              TextSpan(
                                text: ref
                                    .watch(todoControllerProvider)
                                    .todos
                                    .length
                                    .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text: ' tasks left',
                                style: TextStyle(),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TabBar(
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.teal,
                        ),
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(text: 'All Tasks'),
                          Tab(text: 'In Progress'),
                          Tab(text: 'Important'),
                          Tab(text: 'Completed'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            CommonTodo(
                              allTodoProvider,
                              color: const Color.fromARGB(255, 207, 96, 96),
                              iconColor: Colors.teal,
                            ),
                            CommonTodo(
                              activeTodoProvider,
                              color: Colors.blue[50],
                              iconColor: Colors.blue,
                            ),
                            CommonTodo(
                              pinnedTodoProvider,
                              color: Colors.yellow[50],
                              iconColor: Colors.orange,
                            ),
                            CommonTodo(
                              completedTodoProvider,
                              color: Colors.green[50],
                              iconColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class CommonTodo extends ConsumerWidget {
  const CommonTodo(this.todoProvider,
      {super.key, required this.color, required this.iconColor});

  final StateProvider todoProvider;
  final Color? color;
  final Color iconColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: todos.todos.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 70,
          child: InkWell(
            onTap: () {
              ref
                  .read(todoControllerProvider.notifier)
                  .updateTodo(todos.todos[index]);
            },
            child: ListTile(
              leading: Radio(
                value: todos.todos[index].isCompleted,
                groupValue: true,
                onChanged: (value) {},
                activeColor: iconColor,
              ),
              title: Text(todos.todos[index].title),
              trailing: IconButton(
                onPressed: () {
                  ref
                      .read(todoControllerProvider.notifier)
                      .updatePinned(todos.todos[index]);
                },
                icon: Icon(
                  Icons.star,
                  color: todos.todos[index].isPinned
                      ? iconColor
                      : Color.fromARGB(255, 218, 102, 102),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: RichText(
          text: const TextSpan(
            text: 'Task',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
            children: [
              TextSpan(
                text: ' Manager',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopRow extends StatelessWidget {
  const TopRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.refresh),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ],
    );
  }
}
