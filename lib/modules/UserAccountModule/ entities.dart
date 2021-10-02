import 'package:appbesaz/modules/module.dart';

/// [optional] = true indicates that this field must be filled in the registration process.
/// this class is a field in [UserAccount] class.
/// how should we store a new [Field] in database? => solution: Alter Users table each time
/// a new field is inserted, or a field is editted, or a field is deleted.
/// all fields must appear in the [registerPage].
/// a [UserAccount], named [thisUser] is defined globally. His id is 0 until he logins or registers.
/// He can't have access to modules that need payment.
/// his [roleId] is equal to '0'; indicating [unregisteredRole].

UserAccount thisUser = UserAccount(
  id: 0,
  name: 'name',
  userName: 'userName',
  email: 'email',
  password: 'password',
  roleId: 0,
  roleValidity: DateTime.utc(2550, 10, 10),
);
List<Field> fieldList = [];

/// [Field] is only used in Register Page.
/// [Field]s can be added in frontEnd.
/// if a new [Field] is added, the database schema must change (using [ALTER] statement).
class Field {
  int id;
  String fieldName;
  String value;
  bool optional;
  Field({
    required this.id,
    required this.fieldName,
    required this.value,
    this.optional = true,
  }) {
    fieldList.add(this);
  }

  void editField(String newFieldName, bool newOptional) {
    this.fieldName = newFieldName;
    this.optional = newOptional;
  }

  void deleteField() {}
}

/// [roleId] tells which Role is this UserAccount connected to.
/// By default, [roleId] is equal to 0.
/// function [role] returns user's [Role].
/// Each user, will have a [roleValidity]; indicating the date until which the user's [Role] is valid.
/// Every time a [UserAccount] tries to access a module, [roleIsEnded] is called.
/// [roleIsEnded] changes user's [Role] to 'regularRole' if needed.
/// function [purchase] is called every time a user purchases a plan. it changes the [Role] and [roleValidity] of user.
class UserAccount {
  int id;
  String name;
  String userName;
  String email;
  String password;
  int roleId;
  DateTime roleValidity;
  UserAccount({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.password,
    this.roleId = 0,
    required this.roleValidity,
  });
  void changeRole(int roleId) {
    this.roleId = roleId;
  }

  void roleIsEnded() {
    if (roleValidity.isBefore(DateTime.now())) {
      changeRole(1);
    }
  }

  void purchase(int roleId, int daysPurchased) {
    if (roleId == this.roleId) {
      // check if the user currently has the purchased role.
      roleValidity = roleValidity.add(Duration(days: daysPurchased));
    } else {
      changeRole(roleId);
      roleValidity = DateTime.now().add(Duration(days: daysPurchased));
    }
  }

  void editUserAccount(String newName, String newUserName, String newPassword,
      List<Field>? newFieldList) {
    this.name = newName;
    this.userName = newUserName;
    this.password = newPassword;
  }

  Role role() {
    for (Role r in roleList) {
      if (r.id == roleId) return r;
    }
    return unregisteredRole;
  }
}

List<Role> roleList = [];

/// The variable [moduleAccessList] defines which modules this role has access to. [false] for no access and true for having access.
/// Each new module that is defined, all roles should have access to it.
/// if a module does not need registration, All users would have access to it, nonetheless.
/// after each module is created, function [giveAcesstoAllRoles] is called and
/// the created module can be accessed by all roles until changed.
/// Role with [id] = 0 is the first role. this role is created globally.
/// By default, role with [id] = 0, has access to all modules unless changed.
Role unregisteredRole = Role(
  id: 0,
  roleName: 'کاربر ثبت نام نشده',
  moduleAccessList: List.generate(moduleList.length, (index) => true),
);

Role regularRole = Role(
  id: 1,
  roleName: 'کاربر عادی',
  moduleAccessList: List.generate(moduleList.length, (index) => true),
);

Role premium = Role(
    id: 2,
    moduleAccessList: List.generate(
      moduleList.length,
      (index) => true,
    ),
    roleName: 'پرمیوم');

/// How must [moduleAccessList] be stored?
/// Each time a new module is created, a [ALTER] statement is executed and adds a new column to database table.
/// [removeAccessFromRole] removes access from a given [Role].
/// [findRoleById] returns the [Role] with specified [id].
class Role {
  int id;
  String roleName;
  List<bool> moduleAccessList;

  Role({
    required this.id,
    required this.roleName,
    required this.moduleAccessList,
  }) {
    roleList.add(this);
  }

  void editRoleName(String newRoleName) {
    this.roleName = newRoleName;
  }

  void editRoleAccess(List<bool> newModuleAccessList) {
    this.moduleAccessList = newModuleAccessList;
  }

  bool canHaveAccess(int moduleId) {
    if (moduleAccessList.contains(moduleId)) {
      return true;
    } else
      return false;
  }

  static Role? findRoleById(int roleId) {
    for (Role r in roleList) {
      if (r.id == roleId) return r;
    }
  }

  static void removeAccessFromRole(Role role, int moduleId) {
    role.moduleAccessList[moduleId] = false;
  }

  static void giveAccessToAllRoles() {
    for (Role r in roleList) {
      r.moduleAccessList.add(true);
    }
  }
}

List<Plan> planList = [];

Plan premiumPlanMonthly = Plan(
    planId: 1,
    planName: 'پرمیوم',
    amount: 3000,
    days: 30,
    description: 'عضویت پرمیوم ۳۰ روزه',
    roleId: 2);

Plan premiumPlanYearly = Plan(
    planId: 2,
    planName: 'پرمیوم',
    amount: 30000,
    days: 365,
    description: 'عضویت پرمیوم 365 روزه',
    roleId: 2);

/// Each [Role] might appear in many plans.
/// Users can see all plans in Plans page.
class Plan {
  int planId;
  String planName;
  int roleId;
  int days;
  int amount;
  String description;
  Plan({
    required this.planId,
    required this.planName,
    required this.roleId,
    required this.days,
    required this.amount,
    required this.description,
  }) {
    planList.add(this);
  }
  static Plan? findPlanById(int planId) {
    for (Plan p in planList) {
      if (p.planId == planId) {
        return p;
      }
    }
  }
}
