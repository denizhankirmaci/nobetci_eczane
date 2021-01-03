import 'package:flutter/material.dart';

import './iller.dart';
import 'detay_sayfa.dart';

class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nöbetçi Eczane"),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
        ),
        children: <Widget>[
          //Map'te Doğru kullanım bu şekildedir, böyle kullanılması daha iyidir.
          for (Map<String, String> ilMap in iller)
            Card(
              child: InkWell(
                onTap: () {
                  print(ilMap.keys.first);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => DetaySayfa(im: ilMap)));
                },
                child: Center(child: Text(ilMap.values.first)),
              ),
            ),
        ],
      ),
    );
  }
}
