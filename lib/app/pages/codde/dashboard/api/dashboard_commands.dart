import 'dart:convert';

import 'package:codde_backend/codde_backend.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../views/cards.dart';
import 'dashboard_data.dart';

class DashboardCommands {
  List tempData = [];
  int counter = 0;
  DashboardCommands();
  // static const String command = "";
  String starter = ">>cmd";
  String temp = "vcgencmd measure_temp | tr -dc '[0-9].\n\r'";
  // echo $(($(</sys/class/thermal/thermal_zone0/temp) / 1000))
  // mem
  String mem = """free -m | grep Mem | awk '{ print (\$3/\$2)*100 }'""";
  // cpu
  //  String data = "lscpu | awk '/CPU MHz/{if($NF+0>1000)printf \"%.3f GHz\\n\",$NF/1000; else "
  //                                  "printf \"%.3f MHz\\n\",$NF}'").read()

  String cpu =
      """vcgencmd measure_clock arm | awk ' BEGIN { FS="=" } ; { print \$2 / 1000000000 } '""";

  String maxCpu =
      """lscpu | grep -i 'CPU max MHZ' | tr -dc '[0-9],\n\r' | awk '{ print \$1 / 1000 }'""";

  String data =
      """lscpu | grep -i 'CPU max MHZ' | tr -dc '[0-9],\n\r' | awk '{ print \$1 / 1000 }'""";
  // disk
  String disk =
      "df -h | grep /dev/root | awk '{ print \$3 \"/\" \$2 }' | tr -d 'G'";
  // voltage
  String voltage = "vcgencmd measure_volts core | tr -dc '[0-9].\n\r'";
  // "sudo dmidecode --type processor | grep Voltage | awk '{print $2 $3}'"
  // tasks
  // True).stdout))
  /* tab_to_space(
        subprocess.run("ps -o pid,user,time,%cpu,%mem,command ax | sort -b -k3 -r | sed -n -e 2,22p", shell=True,
                       capture_True).stdout) */
  // TODO: benchmark top vs ps command

  String terminator = ">>end";

  String get command =>
      "echo $starter ; $temp ; $mem ; $cpu ; $data ; $disk ; $voltage ; echo $terminator";
  CoddeBackend get backend => GetIt.I<CoddeBackend>();

  Stream<DashboardData?> streamCommands() async* {
    // Create while loop each second
    Stream.periodic(const Duration(seconds: 1), (i) async {
      counter++;
      parse(await backend.client?.run(command));
    });
  }

  DashboardData? parse(Uint8List? data) {
    if (data == null) return null;

    final String strData = utf8.decode(data);
    final List<String> listData = strData.split("\n");
    if (listData.isNotEmpty) {
      if (listData.first != starter) {
        return null;
      }
      if (listData.last != terminator) {
        return null;
      }
      if (listData.length != 8) {
        return null;
      }
      return DashboardData(
        voltage: listData[1],
        mem: _parseMem(listData[2]),
        cpu: _parseCpu(listData[3], listData[4]),
        temp: _parseTemp(listData[5]),
        disk: _parseDisk(listData[6]),
        tasks: listData[7],
      );
    } else {
      return null;
    }
  }

  (double, double)? _parseCpu(String cpu, String maxCpu) {
    if (int.tryParse(maxCpu) == null) {
      return null;
    }
    double maxCpuCapacity =
        int.parse(maxCpu) / 10000; //todo: est-ce que c'est normal le "/10000" ?
    double cpuUsage = double.parse(cpu.toString() /*.replaceAll('%', '')*/);
    var cpuFree = maxCpuCapacity - cpuUsage;
    return (cpuUsage, cpuFree);
  }

  (double, double)? _parseMem(String mem) {
    //MEM
    if (int.tryParse(mem) == null) {
      return null;
    }
    var memUsage = roundDouble(double.parse(mem.toString()), 2);
    var memFree = 100 - memUsage;
    return (memUsage, memFree);
  }

  (double, double)? _parseDisk(String disk) {
    // DISK
    String d = disk.toString().replaceAll(',', '.');
    if (d.split('/').length != 2) {
      return null;
    }
    if (double.tryParse(d.split('/')[1]) == null ||
        double.tryParse(d.split('/')[0]) == null) {
      return null;
    }
    double dSize = double.parse(d.split('/')[1]);
    double dUsage = double.parse(d.split('/')[0]);
    var dFree = dSize - dUsage;
    return (dUsage, dFree);
  }

  List _parseTemp(String temp) {
    if (double.tryParse(data) == null) {
      Map temp = {'temp': double.nan, 'time': counter.toString()};
      tempData.add(temp);
    }
    final dataTemp = double.parse(data);
    Map temp = {'temp': dataTemp, 'time': counter.toString()};
    tempData.add(temp);
    return tempData;
  }
}
