import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/screens/components/radial_painter.dart';



class UsersByDevice extends StatelessWidget {
  const UsersByDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: appPadding),
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Users by device',
              style:  AppFonts.nannic(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey

              ),
            ),
            Container(
              margin: EdgeInsets.all(appPadding),
              padding: EdgeInsets.all(appPadding),
              height: 230,
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: textColor.withOpacity(0.1),
                  lineColor: primaryColor,
                  percent: 0.7,
                  width: 18.0,
                ),
                child: Center(
                  child: Text(
                    '70%',
                    style: AppFonts.nannic(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey

                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: appPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: primaryColor,
                        size: 10,
                      ),
                      SizedBox(width: appPadding /2,),
                      Text('Desktop',style: AppFonts.nannic(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey

                      ),)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: textColor.withOpacity(0.2),
                        size: 10,
                      ),
                      SizedBox(width: appPadding /2,),
                      Text('Mobile',style: AppFonts.nannic(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey

                      ),)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
