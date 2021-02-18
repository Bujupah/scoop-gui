import 'package:flutter/material.dart';
import 'package:windows_app_manager/mock.dart';
import 'package:windows_app_manager/src/utils/utils.dart';
import 'package:windows_app_manager/src/views/settings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = 'https://img.freepik.com/free-photo/hand-painted-watercolor-background-with-sky-clouds-shape_24972-1095.jpg?size=626&ext=jpg';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            stretch: true,
            expandedHeight: 200,
            backwardsCompatibility: true,
            centerTitle: true,
            onStretchTrigger: () {
              print('Stretch');
              return;
            },
            title: Text('Applications List', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold)),
            bottom: AppBar(
              primary: true,
              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Looking for',
                  suffixIcon: Icon(Icons.search)
                )
              ),
              actions: [
                MaterialButton(child: Icon(Icons.file_download), onPressed: () {}),
                MaterialButton(child: Icon(Icons.settings), onPressed: () {}),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              title: Text('Title', style: TextStyle(color: Colors.white, fontSize: 16.0)),
              background: Image.network(url, fit: BoxFit.cover)
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) => ExpansionTile(
              title: Text('${applications[index].name}'),
              subtitle: Text('${applications[index].version}'),
              leading: Image.network('${applications[index].logo}',
                alignment: Alignment.center,
                height: 64,
              ),
              trailing: Icon(Icons.cloud_download),
              childrenPadding: EdgeInsets.all(4),
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.topLeft,
                  child: Text('${applications[index].description}'),
                ),
                ...applications[index].alternative.entries.map((alt) => Card(
                  child: ListTile(
                    dense: true,
                    title: Text('${applications[index].name} ${alt.key}'),
                    subtitle: Text('${alt.value}'),
                    trailing: Icon(Icons.cloud_download_outlined),
                    onTap: () {

                    },
                  ),
                )).toList()
              ],
            ), 
            childCount: applications.length))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: () {
          Utils.navigateTo(context, SettingPage());
        },
      ),
    );
  }
}
