import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/utils/assets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../widget/header.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Header(title: "Dashboard"),
            const SizedBox(height: 16),
            Row(
              children: List.generate(
                4,
                (index) => Flexible(
                  child: Container(
                    margin: EdgeInsets.only(right: index < 3 ? 16.0 : 0),
                    padding: const EdgeInsets.only(top: 8),
                    height: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 208, 208, 208),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Total Users",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(color: AppColors.cGrey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "1000",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(Assets.graph2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Row(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding: const EdgeInsets.all(8.0),
                        child: MapScreen(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 208, 208, 208),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [DoughnutChart()],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('iPhone', 10000, Color(0xffFFA29D)),
      ChartData('Android', 6000, AppColors.cPrimary),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SfCircularChart(
          tooltipBehavior: TooltipBehavior(enable: true),

          title: ChartTitle(text: 'Users by device '),

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
                textStyle: Theme.of(context).textTheme.headlineSmall!,
              ),
              // Changed to show counts instead of percentages
              dataLabelMapper: (ChartData data, _) => '${data.value.toInt()}',
              innerRadius: '70%',
              // Enable animation like in the chart
              enableTooltip: true,
            ),
          ],
          // Center text
          centerX: '50%',
          centerY: '50%',
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '16000',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    'Total Users',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Data class for chart data
class ChartData {
  ChartData(this.category, this.value, this.color);
  final String category;
  final double value;
  final Color color;
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late List<MapData> _mapData;
  late MapShapeSource _mapSource;

  @override
  void initState() {
    super.initState();

    _mapData = [
      MapData(name: 'Russia', users: 8),
      MapData(name: 'China', users: 148),
      MapData(name: 'India', users: 464),
      MapData(name: 'United States', users: 36),
      MapData(name: 'Brazil', users: 25),
      MapData(name: 'Australia', users: 3),
      MapData(name: 'South Africa', users: 49),
      MapData(name: 'Germany', users: 240),
      MapData(name: 'Japan', users: 335),
    ];

    _mapSource = MapShapeSource.asset(
      'assets/jsons/world_map.json',
      shapeDataField: 'name',
      dataCount: _mapData.length,
      primaryValueMapper: (int index) => _mapData[index].name,
      shapeColorValueMapper: (index) => AppColors.cPrimary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString('assets/jsons/world_map.json'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return SfMaps(
            layers: [
              MapShapeLayer(
                source: _mapSource,
                shapeTooltipBuilder: (BuildContext context, int index) {
                  final data = _mapData[index];
                  return Container(
                    padding: EdgeInsets.all(8),
                    color: AppColors.cBlack,
                    child: Text(
                      '${data.name}: ${data.users} Downloads',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },

                strokeColor: Colors.white,
                strokeWidth: 0.5,
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MapData {
  final String name;
  final double users;

  MapData({required this.name, required this.users});
}
