
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../../core/country_decode.dart';
import '../../../model/dashboard_data_model.dart';
import '../../../utils/appcolors.dart';

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
