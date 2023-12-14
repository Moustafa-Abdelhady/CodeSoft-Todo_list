class Todo {
  late String title;
  late String description;
  late String user;
  late String id;
  late bool state;

  Todo.fromJson(Map<String, dynamic> json, {String? elementId}) {
    title = json['title'];
    description = json['description'];
    user = json['user'];
    state = json['state'] ?? false;
    if (elementId != null) {
      id = elementId;
    }
  }


  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'title': title,
      'description': description,
      'user': user,
      'state': state
    };
  }
}
