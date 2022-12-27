import 'dart:async';

import 'package:modnsport/models/activity.model.dart';

import '../../models/stats.model.dart';

abstract class StatsRepositoryFirebase{

  Future<void> updateStatActivity ({required Stream<int> stream,required StatsModel stats});
  Future<List<StatsModel>> getMyStats();
  Future<List<StatsModel>> getUserStats({required String uid});
  Future<Map<String, dynamic>> getStats();

}