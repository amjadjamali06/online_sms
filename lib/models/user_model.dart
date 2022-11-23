class User {
  int id=-1;
  String name='';
  String avatar='';
  String phoneNUm='';

  User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.phoneNUm
  });

  @override
  String toString() {
    return 'User{id: $id, name: $name, avatar: $avatar}';
  }
}

