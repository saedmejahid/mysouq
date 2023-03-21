import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:my_souaq/app/models/sales_model.dart';

class AnalyticsCharts extends StatelessWidget {
  const AnalyticsCharts({Key? key, required this.seriesList}) : super(key: key);

  final List<charts.Series<Sales, String>> seriesList;

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
