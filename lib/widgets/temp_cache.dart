class TempCache {
  static final TempCache _instance = TempCache._internal();

  factory TempCache() => _instance;

  TempCache._internal();

  List<double> cpuTempHistory = [];
  List<double> cpuUsage = [];

  int xStartTemp = 0;
  int xStartUsage = 0;
}