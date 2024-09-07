import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_project/constan.dart';
import 'package:news_project/module/logic/search_logic.dart';
import 'package:news_project/module/model/news_model.dart';
import 'package:provider/provider.dart';

import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: _buildBody(),
        ),
      ),
    );
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

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildButton(),
        _buildTitle(),
        _buildSearchBar(),
        Expanded(
          child: Container(
            color: secondaryColor,
            width: MediaQuery.of(context).size.width,
            child: _buildSeachBody(),
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 40),
      child: Container(
        padding: EdgeInsets.all(5), // Adjust padding for the size of the circle
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F9), // Gray background color
          shape: BoxShape.circle, // Circular shape
        ),
        child: Transform.translate(
          offset:
              Offset(4.0, 0), // Adjust the offset to move the icon to the right
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text(
            "Discover",
            style: TextStyle(
              color: const Color.fromARGB(255, 5, 5, 5),
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            "Your news, your world, always stay informed.",
            style: TextStyle(
              color: Colors.grey[600], // A lighter gray color
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none, // Removes the border line
          ),
          filled: true, // Enables the fill color
          fillColor: Color(0xFFF6F6F9), // Background color for the search bar
          hintText: 'Search',
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey[400]), // Optional: change hint text color
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none, // Ensures no border on focus
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none, // Ensures no border when enabled
          ),
        ),
        textInputAction: TextInputAction.search, // Changes button on keyboard
        style: TextStyle(
            color: Colors.black54), // Optional: change input text color
        onSubmitted: (text) {
          debugPrint("search: $text");
          context.read<SearchLogic>().fetch(text);
          debugPrint("loading1111: ${context.read<SearchLogic>().fetch(text)}");
        },
      ),
    );
  }

  Widget _buildSeachBody() {
    bool loading = context.watch<SearchLogic>().loading;
    String? errorMessage = context.watch<SearchLogic>().errorMessage;

    debugPrint("loading: $loading");

    if (loading) {
      return Center(child: CircularProgressIndicator());
    } else if (errorMessage != null) {
      return _buildError(errorMessage);
    } else {
      List<Article> items = context.watch<SearchLogic>().foundProduct.articles;
      debugPrint("items.length: ${items.length}");
      return _buildData(items);
    }
  }

  Widget _buildError(String errorMessage) {
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
              // context.read<SearchProductLogic>().fetch();
            },
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildData(List<Article> items) {
    return RefreshIndicator(
      onRefresh: () async {
        // context.read<SearchProductLogic>().fetch();
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: (items.length),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // Ensure that items is not null and has elements
          if (index >= items.length) {
            return SizedBox
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
                          minimumSize: Size(0,
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
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:news_project/module/logic/search_logic.dart';
// import 'package:news_project/module/model/news_model.dart';
// import 'package:provider/provider.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _buildSearchTextField(),
//       ),
//       body: _buildBody(),
//     );
//   }

//   Widget _buildSearchTextField() {
//     return TextField(
//       decoration: InputDecoration(
//         icon: Icon(Icons.search, color: Colors.black),
//         hintText: "Search...",
//         hintStyle: TextStyle(color: Colors.black),
//         border: InputBorder.none,
//       ),
//       onSubmitted: (text) {
//         debugPrint("search: $text");
//         context.read<SearchLogic>().fetch(text);
//         debugPrint("loading1111: ${context.read<SearchLogic>().fetch(text)}");
//       },
//       style: TextStyle(color: Colors.black),
//       textInputAction: TextInputAction.search,
//     );
//   }

//   Widget _buildBody() {
//     bool loading = context.watch<SearchLogic>().loading;
//     String? errorMessage = context.watch<SearchLogic>().errorMessage;

//     debugPrint("loading: $loading");

//     if (loading) {
//       return Center(child: CircularProgressIndicator());
//     } else if (errorMessage != null) {
//       return _buildError(errorMessage);
//     } else {
//       List<Article> items = context.watch<SearchLogic>().foundProduct.articles;
//       debugPrint("items.length: ${items.length}");
//       return _buildData(items);
//     }
//   }

//   Widget _buildError(String errorMessage) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Text(errorMessage),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // context.read<SearchProductLogic>().fetch();
//             },
//             child: Text("Retry"),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildData(List<Article>? items) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         // context.read<SearchProductLogic>().fetch();
//       },
//       child: ListView.builder(
//         physics: BouncingScrollPhysics(),
//         itemCount: items!.length,
//         itemBuilder: (context, index) {
//           return _buildItem(items[index]);
//         },
//       ),
//     );
//   }

//   Widget _buildItem(Article? item) {
//     return Card(
//       child: ListTile(
//         leading: SizedBox(
//           width: 50,
//           height: 50,
//           child: CachedNetworkImage(
//             imageUrl: item!.urlToImage ?? "",
//             placeholder: (x, y) => Container(color: Colors.grey),
//             errorWidget: (x, y, z) => Container(color: Colors.grey[900]),
//           ),
//         ),
//         title: Text("${item!.title}"),
//         subtitle: Text("USD ${item.content}"),
//       ),
//     );
//   }
// }
