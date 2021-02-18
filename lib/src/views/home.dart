import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:windows_app_manager/src/models/Application.dart';
import 'package:windows_app_manager/src/services/cmd.dart';
import 'package:windows_app_manager/src/utils/utils.dart';
import 'package:windows_app_manager/src/views/powershell.dart';
import 'package:windows_app_manager/src/views/settings.dart';
import 'package:windows_app_manager/src/widgets/install.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = 'https://img.freepik.com/free-photo/hand-painted-watercolor-background-with-sky-clouds-shape_24972-1095.jpg?size=626&ext=jpg';
  List<Application> applications = [];
  String _filter = '';
  List<Application> _filtered = [];

  bool isLoading = false;

  void loader() async {
    try {
      await Scoop.scoopCheck();
      setState(() { isLoading = true;});
      applications = _filtered = await Scoop.scoopList(query: _filter);
    } catch (e) {
      print(e.toString());
      // * Show error message 
    } finally {
      setState(() { isLoading = false;});
    }
  }

  @override
  void initState() {
    super.initState();
    loader();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: Colors.black,
      isLoading: isLoading,
      child: Scaffold(
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
              onStretchTrigger: () async {
                loader();
                return;
              },
              stretchTriggerOffset: 50,
              title: Text('Scoop Applications', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold)),
              bottom: AppBar(
                primary: true,
                title: TextFormField(
                  onChanged: (value) => setState(() {
                    _filter = value;
                    _filtered = applications.where((element) => element.name.contains(_filter) || _filter == '').toList();
                  }),
                  onFieldSubmitted: (_) async {
                    loader();
                  },
                  decoration: InputDecoration(
                    labelText: 'Looking for',
                    suffixIcon: Icon(Icons.search)
                  )
                ),
                actions: [
                  MaterialButton(child: Icon(Icons.file_download), onPressed: () => Utils.navigateTo(PowerShell())),
                  MaterialButton(child: Icon(Icons.settings), onPressed: () => Utils.navigateTo(SettingPage())),
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
              delegate: SliverChildBuilderDelegate((context, index) => Card(
                child: ListTile(
                  dense: true,
                  title: Text('${_filtered[index].name}'),
                  subtitle: Text('${_filtered[index].version}/${_filtered[index].bucket}'),
                  trailing: Icon(Icons.cloud_download, color: _filtered[index].installed ? Colors.green[900] : Colors.white),
                  onTap: _filtered[index].installed ? () {} : () async {
                    Utils.openDialog(GetInstall(
                      label: _filtered[index].name,
                      onTap: () async {
                        await Scoop.scoopInstall('nano');
                      },
                    ));
                  },
                ),
              ), 
              childCount: _filtered.length)
            )
          ],
        ),
      ),
    );
  }
}
