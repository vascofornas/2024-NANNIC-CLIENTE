import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/data/data.dart';
import 'package:flutter_nannic_cliente/screens/components/referal_info_detail.dart';



class TopReferals extends StatelessWidget {
  const TopReferals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TopReferals',
                style: AppFonts.nannic(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey

                ),
              ),
              Text(
                'View All',
                style: AppFonts.nannic(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey

                ),
              ),
            ],
          ),
          SizedBox(
            height: appPadding,
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: referalData.length,
              itemBuilder: (context, index) => ReferalInfoDetail(
                info: referalData[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}
