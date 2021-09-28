class Field {
  // this class is a field in UserAccount class.
  String fieldName;
  String value;
  bool optional;
  Field({
    required this.fieldName,
    required this.value,
    this.optional = true,
  });
  void editField(String newFieldName, bool newOptional) {
    this.fieldName = newFieldName;
    this.optional = newOptional;
  }
}

class UserAccount {
  int id;
  String name;
  String userName;
  String password;
  List<Field>? fieldList;
  int roleId;
  UserAccount({
    required this.id,
    required this.name,
    required this.userName,
    required this.password,
    this.fieldList,
    this.roleId = 0,
  });
  void changeRole(int roleId) {
    this.roleId = roleId;
  }

  void editUserAccount(String newName, String newUserName, String newPassword,
      List<Field>? newFieldList) {
    this.name = newName;
    this.userName = newUserName;
    this.password = newPassword;
    this.fieldList = newFieldList;
  }
}

class Role {
  int id;
  String roleName;
  Role({required this.id, required this.roleName});
  void editRole(String newRoleName) {
    this.roleName = newRoleName;
  }

  
}
