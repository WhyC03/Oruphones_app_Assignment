// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:oruphones_app/auth/screens/auth_screen.dart';
import 'package:oruphones_app/constants.dart';
import 'package:oruphones_app/providers/product_provider.dart';
import 'package:oruphones_app/widgets/product_card.dart';
import 'package:oruphones_app/widgets/sidemenu_drawer.dart';
import 'package:provider/provider.dart';
import 'package:oruphones_app/providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch products when the screen initializes
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts(
        brands: ["Apple"], // Fetch Apple products
        conditions: ["Like New"], // Fetch only "Like New" condition
        priceRange: [10000, 50000], // Price between 10,000 and 50,000
        verified: true, // Only verified listings
        sortBy: "price", // Sort by price
        ascending: true, // Sort in ascending order
        page: 1, // First page of results
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<String> imgList = [
      'assets/images/Banner 1.png',
      'assets/images/Banner 2.png',
      'assets/images/Banner 3.png',
      'assets/images/Banner 4.png',
      'assets/images/Banner 5.png',
    ];

    return Scaffold(
      drawer: SideMenuDrawer(),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/images/Logo.png',
          width: 70,
        ),
        actions: [
          Text('India'),
          Icon(Icons.location_on_outlined),
          SizedBox(width: 10),
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) => authProvider.isLoggedIn
                ? Icon(Icons.notifications_on_outlined)
                : GestureDetector(
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
          ),
          SizedBox(width: 10),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Container(
          width: 110,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black,
            border: Border.all(color: Colors.amber, width: 4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sell",
                style: TextStyle(color: Colors.amber, fontSize: 20),
              ),
              Icon(
                Icons.add,
                color: Colors.amber,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    .map(
                      (item) => SizedBox(
                        width: 1300,
                        height: 100,
                        child: Center(
                          child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  autoPlay: true,
                  height: 200.0,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 5),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "What's on your mind?",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-1.png',
                          width: 100,
                        ),
                        Text(
                          "Buy Used \nPhones",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-2.png',
                          width: 100,
                        ),
                        Text(
                          "Sell Used \nPhones",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-3.png',
                          width: 100,
                        ),
                        Text(
                          "Compare \nPrices",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-4.png',
                          width: 120,
                          height: 100,
                        ),
                        Text(
                          "MyProfile",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15)
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-5.png',
                          width: 100,
                        ),
                        Text(
                          "My Listings",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15)
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-6.png',
                          width: 100,
                          height: 85,
                        ),
                        Text(
                          "Open Store",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-7.png',
                          width: 100,
                        ),
                        Text(
                          "Services",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15)
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/Device Health.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "Device Health\nCheck",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/Battery Health.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "Battery Health\nCheck",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/IMEI Check.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "IMEI\nVerification",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-8.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "Device\nDetails",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-9.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "Data Wipe",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-10.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "Under Warranty\nPhones",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-11.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "Premium\nPhones",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-12.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "Like New\nPhones",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/Refurbished Phones.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "Refurbished\nPhones",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-13.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "Verified\nPhones",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-14.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "My Negotiations",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Column(
                      children: [
                        Image.asset(
                          'assets/icons/image-15.png',
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          "My Favourites",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Brands",
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade300,
                      child: Image.asset('assets/brands/Apple.png'),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade300,
                      child: Image.asset('assets/brands/MI.png'),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade300,
                      child: Image.asset('assets/brands/Samsung.png'),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade300,
                      child: Image.asset('assets/brands/Vivo.png'),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade300,
                      child: Image.asset('assets/brands/Realme.png'),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade300,
                      child: Image.asset('assets/brands/Moto.png'),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade300,
                      child: Image.asset('assets/brands/Oppo.png'),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'View all',
                            style: TextStyle(fontSize: 12),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 10,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Best Deals in India",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    width: 100,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.arrow_drop_up),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Icon(Icons.arrow_drop_down),
                            ),
                          ],
                        ),
                        Text('Sort'),
                        Icon(Icons.keyboard_arrow_down_outlined)
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    width: 100,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.filter_list),
                        Text('Filter'),
                        Icon(Icons.keyboard_arrow_down_outlined)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              for (int i = 0; i <= 3; i++)
                Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!productProvider.isLoading &&
                          productProvider.products.isEmpty) {
                        context.read<ProductProvider>().fetchProducts(
                          brands: ["Apple"], // Example filter
                          conditions: ["Like New"],
                          priceRange: [10000, 50000],
                          verified: true,
                          sortBy: "price",
                          ascending: true,
                          page: 1,
                        );
                      }
                    });

                    if (productProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (productProvider.products.isEmpty) {
                      return const Center(
                        child: Text("No products found."),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: productProvider.products.length,
                      itemBuilder: (context, index) {
                        final product = productProvider.products[index];
                        return ProductCard(product: product);
                      },
                    );
                  },
                ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/Sell.png',
                      width: 170,
                    ),
                    SizedBox(width: 12),
                    Image.asset(
                      'assets/images/Compare.png',
                      width: 170,
                    ),
                  ],
                ),
              ),
              for (int i = 0; i <= 3; i++)
                Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!productProvider.isLoading &&
                          productProvider.products.isEmpty) {
                        context.read<ProductProvider>().fetchProducts(
                          brands: ["Apple"], // Example filter
                          conditions: ["Like New"],
                          priceRange: [10000, 50000],
                          verified: true,
                          sortBy: "price",
                          ascending: true,
                          page: 1,
                        );
                      }
                    });

                    if (productProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (productProvider.products.isEmpty) {
                      return const Center(
                        child: Text("No products found."),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: productProvider.products.length,
                      itemBuilder: (context, index) {
                        final product = productProvider.products[index];
                        return ProductCard(product: product);
                      },
                    );
                  },
                ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
