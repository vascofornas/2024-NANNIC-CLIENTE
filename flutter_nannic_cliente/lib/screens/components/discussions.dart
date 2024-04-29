import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/data/data.dart';



import 'discussion_info_detail.dart';

class Discussions extends StatelessWidget {
  const Discussions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540,
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
                'Discussions',
                style: AppFonts.nannic(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
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
              itemCount: discussionData.length,
              itemBuilder: (context, index) => DiscussionInfoDetail(info: discussionData[index],),
            ),
          )
        ],
      ),
    );
  }
}
