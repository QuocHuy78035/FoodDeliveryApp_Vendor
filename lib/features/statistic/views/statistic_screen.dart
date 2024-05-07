import 'package:ddnangcao_project/models/revenue_by_year.dart';
import 'package:ddnangcao_project/models/stastic.dart';
import 'package:ddnangcao_project/providers/statistic_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../utils/color_lib.dart';

class _BarChart extends StatefulWidget {
  final double jan;
  final double feb;
  final double mar;
  final double apr;
  final double may;
  final double jun;
  final double jul;
  final double aug;
  final double sep;
  final double oct;
  final double nov;
  final double dec;

  const _BarChart(
    this.jan,
    this.feb,
    this.mar,
    this.apr,
    this.may,
    this.jun,
    this.jul,
    this.aug,
    this.sep,
    this.oct,
    this.nov,
    this.dec,
  );

  @override
  State<_BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<_BarChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: ColorLib.contentColorCyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: ColorLib.contentColorBlue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          ColorLib.contentColorBlue,
          ColorLib.contentColorCyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: widget.jan,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: widget.feb,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: widget.mar,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: widget.apr,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: widget.may,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: widget.jun,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: widget.jul,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: widget.aug,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              toY: widget.sep,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              toY: widget.oct,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              toY: widget.nov,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              toY: widget.dec,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartSample3 extends StatefulWidget {
  final String storeId;

  const BarChartSample3({super.key, required this.storeId});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  List<Statistic> statistic = [];
  late Future<List<StoreRevenue>> _futureStoreRevenueByYear;
  List<StoreRevenue> storeRevenue = [];
  double jan = 0.0;
  double feb = 0.0;
  double mar = 0.0;
  double apr = 0.0;
  double may = 0.0;
  double jun = 0.0;
  double jul = 0.0;
  double aug = 0.0;
  double sep = 0.0;
  double oct = 0.0;
  double nov = 0.0;
  double dec = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<StatisticProvider>(context, listen: false)
        .getStatistic(widget.storeId)
        .then((value) {
      setState(() {
        statistic = value;
      });
    });
    Provider.of<StatisticProvider>(context, listen: false)
        .getStatisticByStoreIdAndMonth(widget.storeId, 2024)
        .then((value) {
      setState(() {
        storeRevenue = value;
      });
    });
    _futureStoreRevenueByYear =
        Provider.of<StatisticProvider>(context, listen: false)
            .getStatisticByStoreIdAndMonth(widget.storeId, 2024);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 70,
        ),
        Column(
          children: [
            statistic.isNotEmpty
                ? Text(
                    "Number Of Successful Orders: ${statistic[0].numberOfSuccessfulOrders}",
                    style: const TextStyle(fontSize: 20),
                  )
                : const Text(
                    "Number Of Successful Orders: 0",
                    style: TextStyle(fontSize: 20),
                  ),
            statistic.isNotEmpty
                ? Text(
                    "Revenue: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(statistic[0].revenue)}",
                    style: const TextStyle(fontSize: 20),
                  )
                : Text(
                    "Revenue: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(0)}",
                    style: const TextStyle(fontSize: 20),
                  ),
          ],
        ),
        AspectRatio(
          aspectRatio: 1.6,
          child: FutureBuilder<List<StoreRevenue>>(
            future: _futureStoreRevenueByYear,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (storeRevenue.isEmpty) {
                return const _BarChart(
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final storeRevenueByYear = snapshot.data!;
                return _BarChart(
                  (storeRevenueByYear[0]
                              .months?['1']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                  (storeRevenueByYear[0]
                              .months?['2']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                  (storeRevenueByYear[0]
                              .months?['3']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                  (storeRevenueByYear[0]
                              .months?['4']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                  (storeRevenueByYear[0]
                              .months?['5']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                  (storeRevenueByYear[0]
                              .months?['6']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                  (storeRevenueByYear[0]
                              .months?['7']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                  (storeRevenueByYear[0]
                              .months?['8']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                  (storeRevenueByYear[0]
                              .months?['9']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                  (storeRevenueByYear[0]
                              .months?['10']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                  (storeRevenueByYear[0]
                              .months?['11']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                  (storeRevenueByYear[0]
                              .months?['12']
                              ?.numberOfSuccessfulOrders ??
                          0)
                      .toDouble(),
                );
              }
            },
          ),
          // child: storeRevenue.isNotEmpty
          //     ? _BarChart(
          //   (storeRevenue[0].months?['1']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          //   (storeRevenue[0].months?['2']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          //   (storeRevenue[0].months?['3']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          //   (storeRevenue[0].months?['4']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          //   (storeRevenue[0].months?['5']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          //   (storeRevenue[0].months?['6']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          //   (storeRevenue[0].months?['7']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          //   (storeRevenue[0].months?['8']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          //   (storeRevenue[0].months?['9']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          //   (storeRevenue[0].months?['10']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          //   (storeRevenue[0].months?['11']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          //   (storeRevenue[0].months?['12']?.numberOfSuccessfulOrders ?? 0).toDouble(),
          // )
          //     : const _BarChart(
          //   0,
          //   0,
          //   0,
          //   0,
          //   0,
          //   0,
          //   0,
          //   0,
          //   0,
          //   0,
          //   0,
          //   0,
          // ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text("Number Of Successful Orders Of 2024 By Month")
      ],
    );
  }
}
