class User {
  final String username;
  String password;
  String nama;
  String alamat;
    
  User({
    required this.username,
    required this.password,
    this.nama = "",
    this.alamat = "",
  });
}

// Password 123
List<User> users = [
  User(username: 'yusril', password: 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', nama: 'Yusril Fauzi', alamat: 'Ciparay')
];