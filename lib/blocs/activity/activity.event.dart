import 'package:modnsport/models/activity.model.dart';

class ActivityEvent{}



class OnActivityEvent extends ActivityEvent{
  /*******************************************************
   *   event when actioneventserver araised ****************
   * ******* actions : removed, added or updated *********
   * ***************************************** **********/

  String action;
  Activity event;
  OnActivityEvent({required this.action, required this.event});
}