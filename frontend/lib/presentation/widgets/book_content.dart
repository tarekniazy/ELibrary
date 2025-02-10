import 'package:flutter/material.dart';

import 'package:e_library/domain/entities/book.dart'; 

class BookContent extends StatelessWidget {
  final Book book;

  const BookContent({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Content'),
              Tab(text: 'Text Analysis'),
            ],
            labelColor: Colors.blue,
          ),
          Expanded(
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(book.content),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(book.textAnalysis),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}