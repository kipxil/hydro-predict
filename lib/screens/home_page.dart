// ignore_for_file: library_private_types_in_public_api

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../widgets/temp_cache.dart';
import '../widgets/status_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  SystemStatus? systemStatus;
  Timer? _timer;
  bool _isFetching = false;
  final cache = TempCache();

  @override
  void initState() {
    super.initState();
    fetchSystemStatus();
    _startUpdating();
  }

  void _startUpdating() {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      // Simulasi data baru
      fetchSystemStatus();
    });
  }

  Future<void> fetchSystemStatus() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final response = await Dio().get("http://192.168.215.168:5000/system_status").timeout(const Duration(seconds: 7));

      if (response.data is Map<String, dynamic> && response.data.containsKey("error")) {
        throw Exception(response.data["error"]);
      }

      final newStatus = SystemStatus.fromJson(response.data);
      final newTemp = newStatus.cpuTemperature;
      final newCpu = newStatus.cpuUsage;

      setState(() {
        systemStatus = newStatus;

        //CPU Temp
        cache.cpuTempHistory.add(newTemp);
        if (cache.cpuTempHistory.length > 10) {
          cache.cpuTempHistory.removeAt(0); // biar list tidak terus bertambah
          cache.xStartTemp++;
        }

        //CPU Usage
        cache.cpuUsage.add(newCpu);
        if (cache.cpuUsage.length > 10) {
          cache.cpuUsage.removeAt(0);
          cache.xStartUsage++;
        }
      });
    } catch (e) {
      setState(() {
        systemStatus = null;
      });
    } finally {
      _isFetching = false;
    }
  }

  @override
  void dispose() {
    // Cancel timer saat widget di dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat("EEEE, d MMMM yyyy", 'id_ID').format(now);
    final formattedTime = DateFormat('hh:mm a').format(now);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildHeader(formattedDate, formattedTime),
              const SizedBox(height: 16),
              _buildMainCard(),
              const SizedBox(height: 16),
              _buildLastUpdated("12:16 WIB"),
              const SizedBox(height: 16),
              _buildCpuTempChart(cache.cpuTempHistory),
              const SizedBox(height: 16),
              _buildCpuUsageChart(cache.cpuUsage)
            ],
          )
        ),
      ),
    );
  }

  Widget _buildHeader(String date, String time) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: const TextStyle(color: Colors.white)),
          Text(time, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildMainCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[600],
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.thermostat, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "CPU Temperature",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "${systemStatus?.cpuTemperature ?? 'N/A'}°C",
            style: const TextStyle(
              fontSize: 36,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 32, color: Colors.white30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MiniStat(title: "CPU Usage", value: "${systemStatus?.cpuUsage.toStringAsFixed(2) ?? 'N/A'}%"),
              _MiniStat(title: "RAM Usage", value: "${systemStatus?.ramUsage.toStringAsFixed(2) ?? 'N/A'}%"),
              _MiniStat(title: "Uptime", value: systemStatus?.uptime ?? 'N/A'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLastUpdated(String time) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          "Raspberry Pi Status: ${systemStatus?.raspberryPiStatus ?? 'OFF'}",
          style: TextStyle(color: systemStatus?.raspberryPiStatus == 'ON' ? Colors.green : Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildCpuTempChart(List<double> data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "CPU Temp",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 9,
                minY: _getMinY(data),
                maxY: _getMaxY(data),
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.teal.shade700, // 🎨 ubah warna tooltip
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(1)}°C',
                          const TextStyle(
                            color: Colors.white, // 🎨 ubah warna teks tooltip
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 40,
                      getTitlesWidget: (value, _) =>
                          Text(value.toStringAsFixed(1), style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, _) {
                        int realIndex = cache.xStartTemp + value.toInt(); // Hitung iterasi sebenarnya
                        return Text(realIndex.toString(), style: const TextStyle(fontSize: 12));
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false))
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(data.length, (i) => FlSpot(i.toDouble(), data[i])),
                    isCurved: true,
                    color: Colors.teal,
                    dotData: const FlDotData(show: true),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCpuUsageChart(List<double> data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "CPU Usage",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 9,
                minY: _getMinY(data),
                maxY: _getMaxY(data),
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.teal.shade700, // 🎨 ubah warna tooltip
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(1)}%',
                          const TextStyle(
                            color: Colors.white, // 🎨 ubah warna teks tooltip
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 40,
                      getTitlesWidget: (value, _) =>
                          Text(value.toStringAsFixed(1), style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, _) {
                        int realIndex = cache.xStartUsage + value.toInt(); // Hitung iterasi sebenarnya
                        return Text(realIndex.toString(), style: const TextStyle(fontSize: 12));
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false))
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(data.length, (i) => FlSpot(i.toDouble(), data[i])),
                    isCurved: true,
                    color: Colors.teal,
                    dotData: const FlDotData(show: true),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String title;
  final String value;

  const _MiniStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }
}

double _getMinY(List<double> data) {
  if (data.length < 2) return 0; // default minimal saat data belum ada
  double min = data.reduce((a, b) => a < b ? a : b).floorToDouble();
  double max = data.reduce((a, b) => a > b ? a : b).ceilToDouble();
  if ((max - min) < 5) min = max - 5; // pastikan jarak min ke max cukup
  return min;
}

double _getMaxY(List<double> data) {
  if (data.length < 2) return 5; // default maksimal saat data belum ada
  double min = data.reduce((a, b) => a < b ? a : b).floorToDouble();
  double max = data.reduce((a, b) => a > b ? a : b).ceilToDouble();
  if ((max - min) < 5) max = min + 5; // pastikan grafik tidak terlalu rapat
  return max;
}