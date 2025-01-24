import 'package:sdp_1/chart.dart';
import 'package:sdp_1/main_page_socket.dart';
import 'package:sdp_1/pages/data.dart';
import 'package:sdp_1/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



final totalProvider = Provider((ref) {
  final list = ref.watch(dataList);
  double device1CostTotal = 0;
  double device2CostTotal = 0;
  double totalCostSum = 0;

  for (DataModel data in list) {
    device1CostTotal += data.device1Cost;
    device2CostTotal += data.device2Cost;
    totalCostSum += data.total;
  }

  return {
    'device1CostTotal': device1CostTotal,
    'device2CostTotal': device2CostTotal,
    'totalCostSum': totalCostSum,
  };
});


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {



  @override
  Widget build(BuildContext context) {
    final totals = ref.watch(totalProvider);

  final device1CostTotal = totals['device1CostTotal']!;
  final device2CostTotal = totals['device2CostTotal']!;
  final totalCostSum = totals['totalCostSum']!;

    return Padding(
      padding: EdgeInsets.all(1.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CurrentChart(),
            Container(
                padding: EdgeInsets.only(left:3.w,right: 3.w,bottom: 3.w,top:4.h),
                height: 27.h,
                margin: EdgeInsets.only(bottom: 1.h),
                decoration: BoxDecoration(
                  color: AppColors.listViewContainerBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.containerBorder),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: [
                       Text(
                        "Device 1",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                       SizedBox(height: 1.h),
                      Text(
                        "${device1CostTotal.toStringAsFixed(2)} ₺",
                        style:  TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                       SizedBox(height: 1.5.h),
                       Text(
                        "Device 2",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                       SizedBox(height: 1.h),
                      Text(
                        "${device2CostTotal.toStringAsFixed(2)} ₺", 
                        style:  TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      const Divider(
                          color: Colors.blueAccent,
                          thickness: 1), 
                       SizedBox(height: 1.h),
                      Text(
                        "Total Cost: ${totalCostSum.toStringAsFixed(2)} ₺",
                        style:  TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ])),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Data()),
                );
              },
              child: const Text('All Datas'),
            )
          ],
        ),
      ),
    );
  }
}
