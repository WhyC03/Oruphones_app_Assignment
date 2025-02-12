import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:oruphones_app/auth/screens/auth_screen.dart';
import 'package:oruphones_app/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<String> imgList = [
      'assets/images/Banner-1.png',
      'assets/images/Banner-2.png',
      'assets/images/Banner-3.png',
      'assets/images/Banner-4.png',
      'assets/images/Banner-5.png',
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu_outlined),
        ),
        title: Image.asset(
          'assets/images/Logo.png',
          width: 70,
        ),
        actions: [
          Text('India'),
          Icon(Icons.location_on_outlined),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthScreen(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: color2,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 80,
              height: 40,
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.search,
                    color: color2,
                  ),
                  SizedBox(
                    width: size.width * 0.75,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search phones with make, model...',
                        hintStyle: TextStyle(fontSize: 13),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '|',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(Icons.mic_none_outlined, color: Colors.grey),
                ],
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 140,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text('Sell Used Phones'),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text('Buy Used Phones'),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text('Compare Prices'),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text('My Profile'),
                    ),
                  ),
                  Container(
                    width: 105,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text('My Listings'),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text('Services'),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Frame.png',
                            width: 30,
                          ),
                          SizedBox(width: 5),
                          Text('Register your Store'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text('Get the App'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            CarouselSlider(
              items: imgList
                  .map((item) => Container(
                        child: Center(
                          child:
                              Image.asset(item, fit: BoxFit.cover, width: 1000),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: Duration(seconds: 3),
              ),
            ), 
          ],
        ),
      ),
    );
  }
}
