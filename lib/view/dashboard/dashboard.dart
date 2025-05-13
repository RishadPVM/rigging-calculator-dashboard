import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/model/dashboard_data_model.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/dashboard/controller/dasboard_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../utils/country_decode.dart';
import '../../widget/header.dart';
import 'widget/data_count_box.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final DasboardController controller = Get.put(DasboardController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              const Header(title: "Dashboard"),
              const SizedBox(height: 16),
              DashboardCountBox(
                dataCount: controller.dashboardData.value.dataCounts!,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 208, 208, 208),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InteractiveViewer(
                            child: MapScreen(
                              mapData:
                                  controller
                                      .dashboardData
                                      .value
                                      .countryMapsDatas!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 208, 208, 208),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DoughnutChart(
                            user: controller.dashboardData.value.users!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class DoughnutChart extends StatelessWidget {
  final UserStats user;
  const DoughnutChart({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('iPhone', user.iso.toDouble(), const Color(0xffFFA29D)),
      ChartData('Android', user.android.toDouble(), AppColors.cPrimary),
    ];

    return SfCircularChart(
      tooltipBehavior: TooltipBehavior(enable: true),

      title: ChartTitle(text: 'Users by device'),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
        textStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: AppColors.cGrey),
      ),
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          pointColorMapper: (ChartData data, _) => data.color,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            //textStyle: Theme.of(context).textTheme.headlineSmall!,
          ),
          dataLabelMapper: (ChartData data, _) => '${data.value.toInt()}',
          innerRadius: '60%',
          enableTooltip: true,
        ),
      ],
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.totalUser.toString(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text('Total Users', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.category, this.value, this.color);
  final String category;
  final double value;
  final Color color;
}

class MapScreen extends StatefulWidget {
  final List<CountryMapData> mapData;
  const MapScreen({super.key, required this.mapData});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapShapeSource _mapSource;

  @override
  void initState() {
    super.initState();
    _mapSource = MapShapeSource.asset(
      'assets/jsons/world_map.json',
      shapeDataField: 'gu_a3',
      dataCount: widget.mapData.length,
      primaryValueMapper: (int index) => widget.mapData[index].country,
      shapeColorValueMapper: (int index) => AppColors.cPrimary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfMaps(
      layers: [
        MapShapeLayer(
          source: _mapSource,
          shapeTooltipBuilder: (BuildContext context, int index) {
            final data = widget.mapData[index];
            return Container(
              padding: const EdgeInsets.all(8),
              color: AppColors.cBlack,
              child: Text(
                '${countryMap[data.country]}: ${data.usersCount} Downloads',
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
          strokeColor: Colors.white,
          strokeWidth: 0.5,
        ),
      ],
    );
  }
}
