import 'package:flutter/material.dart';

class TabHeader extends StatelessWidget {
  const TabHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter( //headerSilverBuilder only accepts slivers
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('My Top Widget'),
                  ),
                  TabBar(
                    tabs: [
                      Tab(child: Text('Available')),
                      Tab(child: Text('Taken')),
                    ],
                  ),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              // I wrapped large widgets in the SingleChildScrollView
              SingleChildScrollView(
                child: Text('1')/*Very large widget*/,
              ),
              Text('2'),
            ],
          ),
        ),
      ),
    );
  }
}
