import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../demo-1-screen/common_layout.dart';
import '../kanban_screen/kanban_scree_1.dart';
import '../Widget_Screen/widget_screen_1.dart';

class InboxController extends GetxController implements GetxService {
  int pageselecter = 0;
  bool drwar = false;

  setvalue(){
    drwar =! drwar;
    update();
  }

  List page12=[
    const laout(),                         //0 - Dashboard
    const laout(),                         //1 - placeholder
    const laout(),                         //2 - placeholder
    const laout(),                         //3 - placeholder
    const laout(),                         //4 - placeholder
    const laout(),                         //5 - placeholder
    const laout(),                         //6 - placeholder
    const laout(),                         //7 - placeholder
    const laout(),                         //8 - placeholder
    const laout(),                         //9 - placeholder
    const laout(),                         //10 - placeholder
    const laout(),                         //11 - placeholder
    const laout(),                         //12 - placeholder
    const laout(),                         //13 - placeholder
    const laout(),                         //14 - placeholder
    const laout(),                         //15 - placeholder
    const laout(),                         //16 - placeholder
    const laout(),                         //17 - placeholder
    const laout(),                         //18 - placeholder
    const laout(),                         //19 - placeholder
    const laout(),                         //20 - placeholder
    const Widget_Screen_1(),               //21 - Add Machine
    const laout(),                         //22 - placeholder
    const laout(),                         //23 - placeholder
    const laout(),                         //24 - placeholder
    const laout(),                         //25 - placeholder
    const laout(),                         //26 - placeholder
    const laout(),                         //27 - placeholder
    const laout(),                         //28 - placeholder
    const laout(),                         //29 - placeholder
    const laout(),                         //30 - placeholder
    const laout(),                         //31 - placeholder
    const laout(),                         //32 - placeholder
    const laout(),                         //33 - placeholder
    const laout(),                         //34 - placeholder
    const laout(),                         //35 - placeholder
    const laout(),                         //36 - placeholder
    const laout(),                         //37 - placeholder
    const kanban_screen_1(),               //38 - Workorder Approve
    const laout(),                         //39 - placeholder
    const laout(),                         //40 - placeholder
    const laout(),                         //41 - placeholder
    const laout(),                         //42 - placeholder
    const laout(),                         //43 - placeholder
    const laout(),                         //44 - placeholder
    const laout(),                         //45 - placeholder
    const laout(),                         //46 - placeholder
    const laout(),                         //47 - placeholder
    const laout(),                         //48 - placeholder
    const laout(),                         //49 - placeholder
    const laout(),                         //50 - placeholder
    const laout(),                         //51 - placeholder
    const laout(),                         //52 - placeholder
    const laout(),                         //53 - placeholder
  ];

  setTextIsTrue(int value) {
    pageselecter = value;
    update();
  }

}