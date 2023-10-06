import 'package:flutter/material.dart';
import 'package:fyp/utils/app_colors.dart';
import 'package:fyp/widgets/search_bar.dart';

class WorkOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    // return Scaffold(
    // backgroundColor: Colors.white,
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),
          Text(
            'Workout',
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
            ),
          ),
          Image.asset('images/workout.PNG'),
          SizedBox(height: 10),
          SizedBox(
            child: SearchBar('What do you want to do today? Cardio?'),
          ),
          SizedBox(height: 10),
          SizedBox(
            //width: screen.width,
            height: 350,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  height: 200,
                  width: screen.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF953CE6),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cardio',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              '30 minutes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Medium activity',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Image.asset('images/cardio.PNG')),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  width: screen.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF00b87c),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pilates',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              '45 minutes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Heavy activity',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Image.asset('images/pilates.PNG')),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  width: screen.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF353491),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yoga',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              '20 minutes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Light activity',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Image.asset('images/yoga.PNG')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // );
  }
}
