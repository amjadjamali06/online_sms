class User {
  int id=-1;
  String name='';
  String avatar='';

  User({
    required this.id,
    required this.name,
    required this.avatar,
  });

  @override
  String toString() {
    return 'User{id: $id, name: $name, avatar: $avatar}';
  }
}

