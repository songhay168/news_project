import 'package:flutter/material.dart';
import 'package:news_project/constan.dart';
import 'package:news_project/module/model/news_model.dart';

import 'FrostedGlassBox.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  // const DetailScreen({super.key});

  Article item;

  DetailScreen(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: _buildBrakingNews(context),
    );
  }

  Widget _buildBrakingNews(BuildContext context) {
    return Stack(
      children: [
        _buildTitleDetails(context),
        _buildBodyDetails(context),
      ],
    );
  }

  Widget _buildBodyDetails(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Aligns children at the start of the row vertically
                children: [
                  Image.asset(
                    "images/news_logo.jpg",
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(width: 8), // Spacing between the logo and the text
                  Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Aligns children at the start of the row vertically
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Aligns children at the start of the column horizontally
                        children: [
                          Text(
                            "${item.source.name.displayName}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height: 4), // Spacing between title and subtitle
                          Text(
                            "${item.author}",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      SizedBox(
                          width: 8), // Spacing between the text and the icon
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Divider(
                height: 30,
                thickness: 1,
                color: Colors.grey[300],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    "${item.content}",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleDetails(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "${item.urlToImage}",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent, // Transparent at the top
                Colors.black.withOpacity(1), // Black gradient at the bottom
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 3.5,
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.blue,
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   padding: EdgeInsets.all(5),
                  //   child: Text(
                  //     "Breaking News",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  Text(
                    "${item.title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    formattedDate(item.publishedAt),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: FrostedGlassBox(
                        // theWidth is the width of the frostedglass
                        theWidth: 50.0,
                        // theHeight is the height of the frostedglass
                        theHeight: 50.0,
                        // theChild is the child of the frostedglass
                        theChild: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      child: FrostedGlassBox(
                        // theWidth is the width of the frostedglass
                        theWidth: 50.0,
                        // theHeight is the height of the frostedglass
                        theHeight: 50.0,
                        // theChild is the child of the frostedglass
                        theChild: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.share),
                          color: Colors.white70,
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
    );
  }
}
