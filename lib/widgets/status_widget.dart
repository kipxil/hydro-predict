class SystemStatus {
  final double cpuTemperature;
  final double cpuUsage;
  final double ramUsage;
  final double diskUsage;
  final String uptime;
  final String raspberryPiStatus;

  SystemStatus({
    required this.cpuTemperature,
    required this.cpuUsage,
    required this.ramUsage,
    required this.diskUsage,
    required this.uptime,
    required this.raspberryPiStatus,
  });

  factory SystemStatus.offline() => SystemStatus(
    cpuTemperature: 0.0,
    cpuUsage: 0.0,
    ramUsage: 0.0,
    diskUsage: 0.0,
    uptime: '0',
    raspberryPiStatus: 'Offline',
  );

  factory SystemStatus.fromJson(Map<String, dynamic> json) {
    return SystemStatus(
      cpuTemperature: _tryParseDouble(json["cpu_temperature"]) ?? 0.0,
      cpuUsage: _tryParseDouble(json["cpu_usage"]) ?? 0.0,
      ramUsage: _tryParseDouble(json["ram_usage"]) ?? 0.0,
      diskUsage: _tryParseDouble(json["disk_usage"]) ?? 0.0,
      uptime: json["uptime"]?.toString() ?? 'Unknown',
      raspberryPiStatus: json["raspberry_pi_status"]?.toString() ?? 'Offline',
    );
  }

  static double? _tryParseDouble(dynamic value) {
    if (value == null) return null;
    return double.tryParse(value.toString());
  }
}