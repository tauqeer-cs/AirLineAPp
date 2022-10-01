import 'package:app/pages/search_result/ui/search_result_view.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(),
      body: SearchResultView(),
    );
  }
}
