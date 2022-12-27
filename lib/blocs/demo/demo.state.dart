abstract class DemoManagementState{}

class InitDemos extends DemoManagementState{}
class ViewedDemo extends DemoManagementState{
  List<String> illustration;
  int currentIllustration;
  ViewedDemo({required this.illustration, required this.currentIllustration});
}