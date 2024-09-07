import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_project/module/logic/news_logic.dart';
import 'package:news_project/module/model/news_model.dart';
import 'package:provider/provider.dart';
import '../constan.dart'; // Assuming 'secondaryColor' is defined here
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

import 'about_screen.dart';
import 'detail_screen.dart';
import 'search_screen.dart';
import 'termAndcon.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(const Duration(seconds: 1), () {
        context.read<NewsLogic>().enableLoading();
        context.read<NewsLogic>().fetch();
      });
    }
  }

  final List<String> imgList = [
    'https://picsum.photos/200/300?random=1',
    'https://picsum.photos/200/300?random=2',
    'https://picsum.photos/200/300?random=3',
    'https://picsum.photos/200/300?random=4',
    'https://picsum.photos/200/300?random=5',
    'https://picsum.photos/200/300?random=6',
    'https://picsum.photos/200/300?random=7',
    'https://picsum.photos/200/300?random=8',
  ];

  final List<String> dataList = [
    'To use a custom color code like 1.',
    'To use a custom color code like 2.',
    'To use a custom color code like 3.',
    'To use a custom color code like 4.',
    'To use a custom color code like 5.',
    'To use a custom color code like 6.',
    'To use a custom color code like 7.',
    'To use a custom color code like 8.',
  ];

  int _currentIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: _buildAppBar(context), // Pass context here
      drawer: _buildDrawerStyle(),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: _buildBrakingNews(),
    );
  }

  Widget _buildBrakingNews() {
    bool loading = context.watch<NewsLogic>().loading;
    String? errorMessage = context.watch<NewsLogic>().errorMessage;
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (errorMessage != null) {
      {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(errorMessage),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<NewsLogic>().fetch();
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        );
      }
    } else {
      List<Article> items = context.watch<NewsLogic>().allNews.articles;

      return Column(children: [
        _buildCarousel(items),
        _buildRecomandation(),
        _buildList(items),
      ]);
    }
  }

  Widget _buildList(List<Article>? items) {
    // Define the maximum number of items to display
    const int maxItems = 10;
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: (items?.length ?? 0) > maxItems ? maxItems : items?.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // Ensure that items is not null and has elements
          if (items == null || index >= items.length) {
            return const SizedBox
                .shrink(); // Return an empty widget if index is out of range
          }

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(items[index]),
                ),
              );
            },
            child: _buildListItem(items[index]),
          );
        },
      ),
    );
  }

  Widget _buildListItem(Article? items) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    String formattedDate = formatter.format(items!.publishedAt);
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(color: Colors.white), // Border color and width
      ),
      color: Colors.white, // Set the card color to white
      elevation: 0, // Remove the shadow
      child: _buildListItemList(items, formattedDate),
    );
  }

  Widget _buildListItemList(Article? items, String formattedDate) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: items!.urlToImage ?? "",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items.title,
                      style: GoogleFonts.mPlusRounded1c(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      formattedDate,
                      style: GoogleFonts.mPlusRounded1c(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                        height:
                            4), // Reduced space between title and description
                    Text(
                      items.description,
                      style: GoogleFonts.mPlusRounded1c(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                        height:
                            4), // Reduced space between description and button
                    Align(
                      alignment: Alignment
                          .centerLeft, // Align button to the left to be closer to text
                      child: TextButton(
                        onPressed: () {
                          // Implement the navigation or action on tap
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                          backgroundColor:
                              Colors.transparent, // Background color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0,
                              vertical:
                                  0.0), // Removed padding to make button tighter
                          minimumSize: const Size(0,
                              0), // Ensuring the button's minimum size is minimal
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // Reducing the touch area
                        ),
                        child: Text(
                          "Read More",
                          style: GoogleFonts.mPlusRounded1c(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecomandation() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Recomandation",
                style: GoogleFonts.mPlusRounded1c(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "View All",
                  style: GoogleFonts.mPlusRounded1c(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        //_buildRecommendationListView(),
      ],
    );
  }

  Widget _buildCarousel(List<Article>? items) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Breaking News",
                style: GoogleFonts.mPlusRounded1c(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "View All",
                  style: GoogleFonts.mPlusRounded1c(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        _buildCarouselSlider(items),
        _buildCarouselIndecator1(),
      ],
    );
  }

  Widget _buildCarouselSlider(List<Article>? items) {
    return CarouselSlider(
      carouselController: _carouselController,
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 9 / 16,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
        onPageChanged: (value, _) => setState(() => _currentIndex = value),
      ),
      items: items!
          .take(6)
          .map((item) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(item),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          item.urlToImage!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0), // Transparent
                                  Color.fromARGB(0, 0, 0, 0) // Black
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '${item.title}', // Dynamic numbering
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCarouselIndecator1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) {
          bool isSelected = _currentIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = index;
                print('_currentIndex ${_currentIndex}');
              });
              _carouselController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            child: AnimatedContainer(
              width: isSelected ? 30 : 10,
              height: 10,
              margin: EdgeInsets.symmetric(horizontal: isSelected ? 6 : 3),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(
                  40,
                ),
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: secondaryColor, //desabled appbar color
      backgroundColor: secondaryColor,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Container(
            padding: const EdgeInsets.all(
                8.0), // Adjust padding to control the size of the circle
            decoration: const BoxDecoration(
              color: Color(0xFFF6F6F9), // Gray background color
              shape: BoxShape.circle, // Circular shape
            ),
            child: SvgPicture.asset(
              'images/menu-fries.svg',
              width: 24.0, // Adjust size as needed
              height: 24.0, // Adjust size as needed
            ),
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(
                8.0), // Adjust padding to control the size of the circle
            decoration: const BoxDecoration(
              color: Color(0xFFF6F6F9), // Gray background color
              shape: BoxShape.circle, // Circular shape
            ),
            child: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          },
        ),
        IconButton(
          icon: Container(
            margin: const EdgeInsets.only(right: 8.0),
            padding: const EdgeInsets.all(
                8.0), // Adjust padding to control the size of the circle
            decoration: const BoxDecoration(
              color: Color(0xFFF6F6F9), // Gray background color
              shape: BoxShape.circle, // Circular shape
            ),
            child: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildDrawerStyle() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.8, // Adjust width as needed
            height: MediaQuery.of(context).size.height *
                0.5, // Set height to half the screen
            padding: const EdgeInsets.all(16.0), // Add padding
            decoration: const BoxDecoration(
              color: Colors.white, // Background color
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, // Shadow color
                  blurRadius: 8.0, // Blur radius
                  offset: Offset(0, 2), // Shadow offset
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: _buildDrawer(), // Drawer content
          ),
        ),
      ],
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white, // Assuming white as the secondary color
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: secondaryColor, // Blue as the primary color
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: secondaryColor,
                  radius: 40.0,
                  backgroundImage:
                      AssetImage('images/Logo.png'), // Your logo image path
                ),
                SizedBox(height: 10.0),
                Text(
                  'Smile Bee News',
                  style: TextStyle(
                    color: Colors.black45, // White text for contrast
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.description,
                color: Colors.blue), // Icon for Terms and Conditions
            title: const Text('Terms and Conditions',
                style: TextStyle(color: Colors.black87)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TermsAndConditionsScreen()), // Assuming this screen exists
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.info, color: Colors.blue), // Icon for About
            title: const Text('About', style: TextStyle(color: Colors.black87)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AboutScreen()), // Assuming this screen exists
              );
            },
          ),
        ],
      ),
    );
  }
}
