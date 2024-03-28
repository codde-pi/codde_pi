import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_data.freezed.dart';

@freezed
class DashboardData with _$DashboardData {
  const factory DashboardData(
      {required String voltage,
      required (double, double)? mem,
      required (double, double)? cpu,
      required List temp,
      required (double, double)? disk,
      required String tasks}) = _DashboardData;
}
