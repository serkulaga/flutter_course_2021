import 'package:todo_list/models/todoListItem.dart';

class ItemsLoading {
  final bool isLoading;

  ItemsLoading(this.isLoading);
}

class ItemsLoaded {
  final List<TodoListItem> items;

  ItemsLoaded(this.items);
}

class UpdateItems {
  final List<TodoListItem> items;

  UpdateItems(this.items);
}
