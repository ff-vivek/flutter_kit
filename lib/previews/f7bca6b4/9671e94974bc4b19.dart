import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/pagination.dart';

@Preview(name: 'Default', width: 300, height: 80)
Widget preview_UkPagination() {
  return UkPagination(
    currentPage: 2,
    totalPages: 10,
    onPageChanged: (int page) {
      print('Page changed to $page');
    },
    // Using default values for optional parameters
    // maxPagesToShow: 5,
    // showEdges: true,
  );
}
