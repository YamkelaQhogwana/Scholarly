import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import 'calendar.dart';
import 'home.dart';
import 'info.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class ClassesPage extends StatelessWidget {
  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 65, left: 25),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/avatars/black-wn-av.png',
                                    width: 55,
                                    height: 55,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Jane Doe',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25,
                                          color: Color(0xFF1D1D1D),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'You have 3 modules this block',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color(0xFF8D8F9D),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print('Menu button clicked');
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 80.0),
                                      // Adjust the right padding as needed
                                      child: SvgPicture.string(
                                        '''
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
          <path fill="none" stroke="#000000" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 17h8m-8-5h14m-8-5h8"/>
        </svg>
      ''',
                                        color: Colors.black,
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 25, right: 25),
                                child: ListView(
                                  children: [
                                    Container(
                                      width: 350,
                                      height: 170,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEAF5E6),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              'Module Name',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Color(0xFF87C782),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              'Web Development and e-Commerce',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Color(0xFF1D1D1D),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              'Module Code',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Color(0xFF87C782),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              'ITECA3 - B12',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Color(0xFF1D1D1D),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.string(
                                                      '''
  <svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512">
    <path fill="#8F76C9" d="M286.883 449.302c-32.074-5.598-44.248-61.722-57.684-141.257c-35.493 5.57-84.224 15.62-136.646 26.918c-8.547 22.392-23.16 55.117-43.838 98.189C37.15 458.017-.483 447.932.005 421.615c0-8.204 12.902-39.392 38.711-93.573c-10.963-19.661-1.16-37.43 20.766-42.046c44.515-79.694 125.23-218.94 149.464-223.298c34.272.02 27.712 46.153 43.839 114.341l38.2 178.177c16.024 46.692 41.436 85.73-4.102 94.086zm-90.5-293.03l-73.32 118.188c20.678-5.295 52.043-11.705 94.088-19.227l-20.766-98.96zm224.6-39.731c-1.207 16.875-2.378 36.667-1.537 57.427c47.449 1.985 91.73-8.746 92.549 23.585c.268 12.222-9.834 24.105-22.047 23.586c-22.209-3.485-45.74-.7-69.99-1.539v60.247c2.12 31.834-48.317 30.886-45.633 0l-.513-59.221c-52.638 3.635-83.997 3.46-83.576-21.79c1.267-29.974 19.67-18.519 83.576-23.844c-.739-23.628-.75-45.79 2.052-62.297c6-28.701 44.984-21.366 45.119 3.846z"/>
  </svg>
  ''',
                                                      width: 12,
                                                      height: 12,
                                                      color: Color(0xFF87C782),
                                                    ),

                                                    SizedBox(height: 5),
                                                    Text(
                                                      '75%',
                                                      style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16,
                                                        color: Color(0xFF1D1D1D),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left:65),
                                                      child: SvgPicture.string(
                                                        '''
  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
    <path fill="#E66A64" d="M8 8a3 3 0 1 0 0-6a3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0a2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1s1-4 6-4s6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664h10Z"/>
  </svg>
  ''',
                                                        color: Color(0xFF87C782),
                                                        width: 12,
                                                        height: 12,
                                                      ),
                                                    ),
                                                      SizedBox(height: 5),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 65),
                                                      child: Text(
                                                        'Mr. Idowu Aruleba',
                                                        style: TextStyle(
                                                          fontFamily: 'Montserrat',
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 16,
                                                          color: Color(0xFF1D1D1D),
                                                        ),
                                                      ),
                                                    ),

                                              ],
                                            ),
                                            ],
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Container(
                                        width: 350,
                                        height: 170,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEDE4F9),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Text(
                                                'Module Name',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFF8F76C9),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Text(
                                                'Mobile Application and Web Services',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Color(0xFF1D1D1D),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Text(
                                                'Module Code',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFF8F76C9),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Text(
                                                'ITMDA3 - B12',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Color(0xFF1D1D1D),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SvgPicture.string(
                                                        '''
  <svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512">
    <path fill="#8F76C9" d="M286.883 449.302c-32.074-5.598-44.248-61.722-57.684-141.257c-35.493 5.57-84.224 15.62-136.646 26.918c-8.547 22.392-23.16 55.117-43.838 98.189C37.15 458.017-.483 447.932.005 421.615c0-8.204 12.902-39.392 38.711-93.573c-10.963-19.661-1.16-37.43 20.766-42.046c44.515-79.694 125.23-218.94 149.464-223.298c34.272.02 27.712 46.153 43.839 114.341l38.2 178.177c16.024 46.692 41.436 85.73-4.102 94.086zm-90.5-293.03l-73.32 118.188c20.678-5.295 52.043-11.705 94.088-19.227l-20.766-98.96zm224.6-39.731c-1.207 16.875-2.378 36.667-1.537 57.427c47.449 1.985 91.73-8.746 92.549 23.585c.268 12.222-9.834 24.105-22.047 23.586c-22.209-3.485-45.74-.7-69.99-1.539v60.247c2.12 31.834-48.317 30.886-45.633 0l-.513-59.221c-52.638 3.635-83.997 3.46-83.576-21.79c1.267-29.974 19.67-18.519 83.576-23.844c-.739-23.628-.75-45.79 2.052-62.297c6-28.701 44.984-21.366 45.119 3.846z"/>
  </svg>
  ''',
                                                        width: 12,
                                                        height: 12,
                                                        color: Color(0xFF8F76C9),
                                                      ),

                                                      SizedBox(height: 5),
                                                      Text(
                                                        '75%',
                                                        style: TextStyle(
                                                          fontFamily: 'Montserrat',
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 16,
                                                          color: Color(0xFF1D1D1D),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 20),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 50),
                                                        child: SvgPicture.string(
                                                          '''
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
      <path fill="#8F76C9" d="M8 8a3 3 0 1 0 0-6a3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0a2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1s1-4 6-4s6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664h10Z"/>
    </svg>
    ''',
                                                          width: 12,
                                                          height: 12,
                                                        ),
                                                      ),

                                                      SizedBox(height: 5),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 50),
                                                        child: Text(
                                                          'Mr. Ian Masaga',
                                                          style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 16,
                                                            color: Color(0xFF1D1D1D),
                                                          ),
                                                        ),
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

                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Container(
                                        width: 350,
                                        height: 170,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFCECEB),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Text(
                                                'Module Name',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFE66A64),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Text(
                                                'Industry 4.0',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Color(0xFF1D1D1D),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Text(
                                                'Module Code',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: Color(0xFFE66A64),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Text(
                                                'ITIRA3 - B22',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Color(0xFF1D1D1D),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SvgPicture.string(
                                                        '''
                    <svg xmlns="http://www.w3.org/2000/svg" width="512" height="512" viewBox="0 0 512 512">
                      <path fill="#E66A64" d="M286.883 449.302c-32.074-5.598-44.248-61.722-57.684-141.257c-35.493 5.57-84.224 15.62-136.646 26.918c-8.547 22.392-23.16 55.117-43.838 98.189C37.15 458.017-.483 447.932.005 421.615c0-8.204 12.902-39.392 38.711-93.573c-10.963-19.661-1.16-37.43 20.766-42.046c44.515-79.694 125.23-218.94 149.464-223.298c34.272.02 27.712 46.153 43.839 114.341l38.2 178.177c16.024 46.692 41.436 85.73-4.102 94.086zm-90.5-293.03l-73.32 118.188c20.678-5.295 52.043-11.705 94.088-19.227l-20.766-98.96zm224.6-39.731c-1.207 16.875-2.378 36.667-1.537 57.427c47.449 1.985 91.73-8.746 92.549 23.585c.268 12.222-9.834 24.105-22.047 23.586c-22.209-3.485-45.74-.7-69.99-1.539v60.247c2.12 31.834-48.317 30.886-45.633 0l-.513-59.221c-52.638 3.635-83.997 3.46-83.576-21.79c1.267-29.974 19.67-18.519 83.576-23.844c-.739-23.628-.75-45.79 2.052-62.297c6-28.701 44.984-21.366 45.119 3.846z"/>
                    </svg>
                    ''',
                                                        width: 12,
                                                        height: 12,
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        '92%',
                                                        style: TextStyle(
                                                          fontFamily: 'Montserrat',
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 16,
                                                          color: Color(0xFF1D1D1D),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 20),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left:50),
                                                    child: SvgPicture.string(
                                                      '''
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
          <path fill="#E66A64" d="M8 8a3 3 0 1 0 0-6a3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0a2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1s1-4 6-4s6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664h10Z"/>
        </svg>
        ''',
                                                      width: 12,
                                                      height: 12,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 50),
                                                    child: Text(
                                                      'Mr. Bongumusa Mkungo',
                                                      style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16,
                                                        color: Color(0xFF1D1D1D),
                                                      ),
                                                    ),
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



                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(

                                          child: Padding(
                                            padding: EdgeInsets.only(top: 22, bottom: 90),
                                            child: Image.asset(
                                              'assets/images/classespage/bottom.png',
                                              width: 365,
                                            ),
                                          ),
                                        ),


                                            Positioned(
                                              top: 90,
                                              child: GestureDetector(
                                                onTap: () {

                                                  print('Add module button clicked');
                                                },
                                                child: SvgPicture.string(
                                                  '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M19 12.998h-6v6h-2v-6H5v-2h6v-6h2v6h6z"/></svg>''',
                                                  width: 50,
                                                  height: 50,
                                                  color: Color(0xFF8D8F9D),
                                                ),
                                              ),
                                            ),






                                      ],
                                ),
                                ],
                              ),

                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),



        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: kBottomNavigationBarHeight / 2,
              left: (MediaQuery.of(context).size.width - 56) / 2, // Adjust the left position
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.kPrimary400, // Set your desired button color here
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: IconButton(
                  onPressed: () {
                    // Placeholder code for add button
                    print('Add button pressed');
                  },
                  icon: Icon(Icons.add, color: Colors.white), // Set the icon color
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                color: AppColors.kMainText,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.calendar_month),
                color: AppColors.kMainText,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarPage()),
                  );
                },
              ),
              SizedBox(width: 56), // Empty space for the float button
              IconButton(
                icon: Icon(Icons.school),
                color: AppColors.kPrimary400,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClassesPage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.newspaper),
                color: AppColors.kMainText,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InfoPage()),
                  );
                },
              ),
            ],
          ),
        )






    );
  }
}