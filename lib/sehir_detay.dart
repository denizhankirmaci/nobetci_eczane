import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ilce.dart';
import 'ilce_detay.dart';

class SehirDetay extends StatefulWidget {
  //final Map<String, String> im;
  final String ilAdi;
  const SehirDetay({@required this.ilAdi});

  @override
  _SehirDetayState createState() => _SehirDetayState();
}

class _SehirDetayState extends State<SehirDetay> {
  List<dynamic> _ilceListesi = [];
  Future _httpIstekYap(String ilAdiVal) async {
    //print(ilAdiVal);
    http.Response cevap = await http.get(
      "https://api.collectapi.com/health/districtList?il=${ilAdiVal.toString()}",
      //"https://api.collectapi.com/health/districtList?il=ARTVİN",
      //Uri.parse('https://api.collectapi.com/health/districtList?il=ARTVİN'),
      headers: {
        HttpHeaders.authorizationHeader:
            'apikey 1wG3uZY0TnVRB9KrZH6ZW2:3XfJQRdUCKiA0PNwgFzoFV',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    //print(cevap.body);
    //print(cevap.statusCode);
    if (cevap.statusCode == 200) {
      Map icCevap = jsonDecode(utf8.decode(cevap.bodyBytes));
      //print(icCevap);

      if (icCevap["success"]) {
        //print(icCevap);
        //print(icCevap["result"]);
        //_ilceListesi = icCevap["result"];
        //print(_ilceListesi);
        _ilceListesi = icCevap["result"]
            .map((e) => Ilce.fromJson(e))
            .toList()
            .cast<Ilce>();
        _ilceListesi = icCevap["result"].cast<Map>();
        setState(() {});
      }
    }
  }

  void initState() {
    _httpIstekYap(widget.ilAdi);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.ilAdi} İlçeleri"),
        backgroundColor: Colors.deepOrange,
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
        ),
        children: <Widget>[
          //Map'te Doğru kullanım bu şekildedir, böyle kullanılması daha iyidir.
          for (dynamic ilce in _ilceListesi)
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => IlceDetay(
                              ilAdi: widget.ilAdi,
                              ilceAdi: ilce["text"].toString())));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (ctx) => DetaySayfa(im: ilMap)));
                },
                child: Center(child: Text(ilce["text"])),
              ),
            ),
        ],
      ),

      // Center(
      //   child: Column(
      //     children: <Widget>[
      //       // RaisedButton(
      //       //     onPressed: () => _httpIstekYap(widget.ilAdi),
      //       //     child: Text("İstek Yap")),
      //       Expanded(
      //         child: ListView(
      //           children: <Widget>[
      //             for (dynamic ilce in _ilceListesi)
      //             //Burada hata var.
      //               Card(
      //                 child: InkWell(
      //           onTap: () {
      //             //print(ilMap.keys.first);
      //             //print(ilMap.values);
      //             Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SehirDetay(ilAdi: ilce["text"].toString())));
      //             // Navigator.push(
      //             //     context,
      //             //     MaterialPageRoute(
      //             //         builder: (ctx) => DetaySayfa(im: ilMap)));
      //           },
      //           child: Center(child: Text(ilce["text"])),
      //         ),

      //                 // child: ListTile(
      //                 //   title: Text(ilce["text"]),
      //                 //   //title: Text(eczaneMap["eczane_adi"]),
      //                 //   subtitle: Column(
      //                 //     crossAxisAlignment: CrossAxisAlignment.start,
      //                 //     children: <Widget>[
      //                 //       Text("İlçe : deniz"),
      //                 //       //Text(eczane.eczaneAdres),
      //                 //       //Text("Telefon : ${eczane.eczaneTelefon}"),
      //                 //     ],
      //                 //   ),
      //                 //   // trailing: IconButton(
      //                 //   //   icon: Icon(Icons.phone),
      //                 //   //   onPressed: () {
      //                 //   //     print("${eczane.eczaneTelefon} arandı");
      //                 //   //   },
      //                 //   // ),
      //                 // ),
      //               ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
