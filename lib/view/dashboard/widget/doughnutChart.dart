import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/dashboard_data_model.dart';
import '../../../utils/appcolors.dart';

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
