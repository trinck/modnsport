abstract class DemoRepositoryFirebase{

 Future<List<String>> getDemo();
  Future<void> setDemo({required String imageDemoUrl});
}