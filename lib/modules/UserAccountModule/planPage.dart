import 'package:appbesaz/modules/UserAccountModule/%20entities.dart';
import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('پلن ها'),
      ),
      body: ListView.builder(
          itemCount: planList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){ // Connect to ZarinPal with amount equal to Plan's amount.
                
                
              },
              child: Container(
              child: Column(children: [
                Text(planList[index].planName),
                Text(planList[index].description),
                Text('نوع حساب خریداری شده: ' + Role.findRoleById(planList[index].roleId)!.roleName),
                Text(planList[index].amount.toString()),
                Text('مدت (روز)' + planList[index].days.toString()),
              ],),
            ),);
          }),
    );
  }
}
