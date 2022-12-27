import 'package:modnsport/models/programs.model.dart';

class ProgramsEvent{}


class OnProgramsEvent extends ProgramsEvent{
  /*******************************************************
   *   event when actioneventserver araised ****************
   * ******* actions : removed, added or updated *********
   * ***************************************** **********/

  String action;
  Programs event;
  OnProgramsEvent({required this.action, required this.event});
}