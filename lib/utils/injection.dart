



import 'package:get_it/get_it.dart';
import 'package:modnsport/repositories/activity/activity.repository.dart';
import 'package:modnsport/repositories/activity/activity.repository.firebase.dart';
import 'package:modnsport/repositories/chat/chat.repository.dart';
import 'package:modnsport/repositories/chat/chat.repository.firebase.dart';
import 'package:modnsport/repositories/comments/comments.repository.dart';
import 'package:modnsport/repositories/comments/comments.repository.firebase.dart';
import 'package:modnsport/repositories/counter/counter.repository.dart';
import 'package:modnsport/repositories/counter/counter.repository.firebase.dart';
import 'package:modnsport/repositories/demo/demo.repository.dart';
import 'package:modnsport/repositories/demo/demo.repository.firebase.dart';
import 'package:modnsport/repositories/discipline/discipline.repository.dart';
import 'package:modnsport/repositories/discipline/discipline.repository.firebase.dart';
import 'package:modnsport/repositories/messages/message.repository.dart';
import 'package:modnsport/repositories/messages/message.repository.firebase.dart';
import 'package:modnsport/repositories/programs/programs.repository.dart';
import 'package:modnsport/repositories/programs/programs.repository.firebase.dart';
import 'package:modnsport/repositories/stats/stats.repository.dart';
import 'package:modnsport/repositories/stats/stats.repository.firebase.dart';
import 'package:modnsport/repositories/storage/storage.repository.dart';
import 'package:modnsport/repositories/storage/storage.repository.firebase.dart';
import 'package:modnsport/repositories/user/user.repository.dart';
import 'package:modnsport/repositories/user/user.repository.firebase.dart';
import 'package:modnsport/repositories/videos/videos.repository.dart';
import 'package:modnsport/repositories/videos/videos.repository.firebase.dart';

var getIt = GetIt.instance;

Future<void> registerDependence()async
{

   getIt.registerSingleton<UserRepositoryFirebase>(UserRepository());
   getIt.registerSingleton<ChatRepositoryFirebase>(ChatRepository());
   getIt.registerSingleton<VideosRepositoryFirebase>(VideosRepository());
   getIt.registerSingleton<StorageRepositoryFirebase>(StorageRepository());
   getIt.registerSingleton<StatsRepositoryFirebase>(StatsRepository());
   getIt.registerSingleton<ProgramsRepositoryFirebase>(ProgramRepository());
   getIt.registerSingleton<MessageRepositoryFirebase>(MessageRepository());
   getIt.registerSingleton<DisciplineRepositoryFirebase>(DisciplineRepository());
   getIt.registerSingleton<DemoRepositoryFirebase>(DemoRepository());
   getIt.registerSingleton<CounterRepositoryFirebase>(CounterRepository());
   getIt.registerSingleton<CommentsRepositoryFirebase>(CommentsRepository());
   getIt.registerSingleton<ActivityRepositoryFirebase>(ActivityRepository());

   //getit.registerLazySingleton<LocalStorage>(() => LocalStorage("DataJson"));
}