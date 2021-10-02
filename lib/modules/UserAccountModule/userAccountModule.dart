import 'package:appbesaz/modules/UserAccountModule/loginPage.dart';
import 'package:appbesaz/modules/UserAccountModule/planPage.dart';
import 'package:appbesaz/modules/module.dart';
import 'package:flutter/material.dart';
import ' entities.dart';

class UserAccountModule extends Module {
  UserAccountModule({required int id, required int index, String title = 'حساب کاربری', String imageName = ''})
      : super(id: id, index: index, type: 13, title: title, imageName: imageName);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserAccountModuleState();
  }
}

class UserAccountModuleState extends State<UserAccountModule> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    switch (thisUser.roleId) {
      case 0: // if user wasn't registered.
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('شما وارد نشده اید.'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('اکنون وارد شوید')),
            ],
          ),
        );
      case 1: // if user was registered but did not have any active plans.
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'حساب کاربری شما از نوع عادی می باشد و به همه بخش های اپلیکیشن دسترسی ندارید..'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PlanPage()));
                  },
                  child: Text('ارتقا دهید.')),
            ],
          ),
        );
      default: // if user had active plan.
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('نوع کاربری شما: ' +
                  Role.findRoleById(thisUser.roleId)!.roleName),
              Text('مدت باقی مانده تا پایان پلن فعلی: '),
              Text(thisUser.roleValidity.toIso8601String()),
            ],
          ),
        );
    }
  }
}
