import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/model/ad_model.dart';

import '../../../utils/appcolors.dart';
import '../../../widget/count_card.dart';
import '../../../widget/header.dart';
import '../../nav/controller/navcontroller.dart';

class AdDetails extends StatelessWidget {
  final AdModel ad;
  const AdDetails({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    final Navcontroller controller = Get.find<Navcontroller>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.overlappingNavClose();
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Header(title: "Advertisment Details")),
                ],
              ),
              const SizedBox(width: 16),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          spacing: 16,
                          children: [
                            AspectRatio(
                              aspectRatio: 1.9 / 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  ad.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            // Container(
                            //   height: 340,
                            //   color: AppColors.cGrey100,
                            //   width: double.infinity,
                            //   child: CustomLineChart(
                            //     greenLineData: [
                            //       Offset(0, 0),
                            //       Offset(1, 1000),
                            //       Offset(2, 2000),
                            //       Offset(3, 1500),
                            //       Offset(4, 2500),
                            //       Offset(5, 3000),
                            //       Offset(6, 2000),
                            //       Offset(7, 2500),
                            //       Offset(8, 1500),
                            //       Offset(9, 2000),
                            //       Offset(10, 1000),
                            //       Offset(11, 3000),
                            //     ],
                            //     orangeLineData: [
                            //       Offset(0, 0),
                            //       Offset(1, 1000),
                            //       Offset(2, 2000),
                            //       Offset(3, 1500),
                            //       Offset(4, 2500),
                            //       Offset(5, 3000),
                            //       Offset(6, 2000),
                            //       Offset(7, 2500),
                            //       Offset(8, 1500),
                            //       Offset(9, 2000),
                            //       Offset(10, 1000),
                            //       Offset(11, 3000),
                            //     ],
                            //     minX: 0,
                            //     maxX: 11,
                            //     minY: 0,
                            //     maxY: 3000,
                            //     xLabels: const [
                            //       'Jan',
                            //       'Feb',
                            //       'Mar',
                            //       'Apr',
                            //       'May',
                            //       'Jun',
                            //       'Jul',
                            //       'Aug',
                            //       'Sep',
                            //       'Oct',
                            //       'Nov',
                            //       'Dec',
                            //     ],
                            //     yLabels: [500, 1000, 1500, 2000, 2500, 3000],
                            //     greenLineColor: Colors.green,
                            //     orangeLineColor: Colors.orange,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Row(
                              children: [
                                CountCard(
                                  count: ad.readUsers.length.toString(),
                                  title: "Total Views",
                                ),
                                SizedBox(width: 16),
                                CountCard(
                                  count: ad.clickUsers.length.toString(),
                                  title: "Website Views",
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ad.title,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  ad.webUrl,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: AppColors.cPrimary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomLineChart extends StatelessWidget {
  final List<Offset> greenLineData;
  final List<Offset> orangeLineData;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final List<String> xLabels;
  final List<int> yLabels;
  final Color greenLineColor;
  final Color orangeLineColor;

  const CustomLineChart({
    super.key,
    required this.greenLineData,
    required this.orangeLineData,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.xLabels,
    required this.yLabels,
    this.greenLineColor = Colors.green,
    this.orangeLineColor = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LineChartPainter(
        greenLineData: greenLineData,
        orangeLineData: orangeLineData,
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        xLabels: xLabels,
        yLabels: yLabels,
        greenLineColor: greenLineColor,
        orangeLineColor: orangeLineColor,
      ),
      child: Container(),
    );
  }
}

// Custom Painter for the Line Chart
class LineChartPainter extends CustomPainter {
  final List<Offset> greenLineData;
  final List<Offset> orangeLineData;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final List<String> xLabels;
  final List<int> yLabels;
  final Color greenLineColor;
  final Color orangeLineColor;

  LineChartPainter({
    required this.greenLineData,
    required this.orangeLineData,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.xLabels,
    required this.yLabels,
    required this.greenLineColor,
    required this.orangeLineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPadding = 30; // Space for y-axis labels
    const double bottomPadding = 30; // Space for x-axis labels
    final double chartWidth = size.width - leftPadding;
    final double chartHeight = size.height - bottomPadding;

    final greenLinePaint =
        Paint()
          ..color = greenLineColor
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;

    final orangeLinePaint =
        Paint()
          ..color = orangeLineColor
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Draw Y-axis labels
    for (int yValue in yLabels) {
      double yPos =
          chartHeight - ((yValue - minY) / (maxY - minY)) * chartHeight;

      textPainter.text = TextSpan(
        text: yValue.toString(),
        style: const TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          leftPadding - textPainter.width - 10,
          yPos - textPainter.height / 2,
        ),
      );
    }

    // Draw X-axis labels
    for (int i = 0; i < xLabels.length; i++) {
      double xPos = leftPadding + (i / (maxX - minX)) * chartWidth - 10;

      textPainter.text = TextSpan(
        text: xLabels[i],
        style: const TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(xPos - textPainter.width / 2, chartHeight + 10),
      );
    }

    // Draw the lines
    _drawLine(
      canvas,
      greenLineData,
      greenLinePaint,
      chartWidth,
      chartHeight,
      leftPadding,
    );
    _drawLine(
      canvas,
      orangeLineData,
      orangeLinePaint,
      chartWidth,
      chartHeight,
      leftPadding,
    );
  }

  void _drawLine(
    Canvas canvas,
    List<Offset> data,
    Paint paint,
    double chartWidth,
    double chartHeight,
    double leftPadding,
  ) {
    final path = Path();

    for (int i = 0; i < data.length; i++) {
      double x =
          leftPadding + ((data[i].dx - minX) / (maxX - minX)) * chartWidth;
      double y =
          chartHeight - ((data[i].dy - minY) / (maxY - minY)) * chartHeight;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
