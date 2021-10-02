import ' entities.dart';

List<UserAccount> userListTest = [
  UserAccount(
      id: 1,
      name: 'Sajad Ziaee',
      userName: 'Sajad',
      email: 's@gmail.com',
      password: '123456',
      roleId: 1,
      roleValidity: DateTime.utc(2500)),
  UserAccount(
      id: 2,
      name: 'Iman Havangi',
      userName: 'Iman',
      email: 'i@gmail.com',
      password: '654321',
      roleId: 2,
      roleValidity: DateTime.now().add(Duration(days: 3)))
];

bool checkValidity(String username, String password) {
  for (UserAccount ua in userListTest) {
    if (ua.userName == username || ua.email == username) {
      if (ua.password == password) {
        thisUser = ua;
        return true;
      } else
        return false;
    }
  }
  return false;
}
