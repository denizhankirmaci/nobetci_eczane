import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'eczane_entity.dart';

class IlceDetay extends StatefulWidget {
  //final Map<String, String> im;
  final String ilAdi;
  final String ilceAdi;
  const IlceDetay({@required this.ilAdi, this.ilceAdi});

  @override
  _IlceDetayState createState() => _IlceDetayState();
}

class _IlceDetayState extends State<IlceDetay> {
  //final String _url = "";
  List<dynamic> _eczaneListesi = [];

  Future _httpIstekYap(String ilceAdiVal, String ilAdiVal) async {
    http.Response cevap = await http.get(
      //"https://api.collectapi.com/health/districtList?ilce=${ilceAdiVal.toString()}&il=${ilAdiVal.toString()}",
      "https://api.collectapi.com/health/dutyPharmacy?ilce=${ilceAdiVal.toString()}&il=${ilAdiVal.toString()}",

      //"https://api.collectapi.com/health/districtList?il=ARTVİN",
      //Uri.parse('https://api.collectapi.com/health/districtList?il=ARTVİN'),
      headers: {
        HttpHeaders.authorizationHeader:
            'apikey 1wG3uZY0TnVRB9KrZH6ZW2:3XfJQRdUCKiA0PNwgFzoFV',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print(cevap.statusCode);
    if (cevap.statusCode == 200) {
      //print(cevap);
      Map icCevap = jsonDecode(utf8.decode(cevap.bodyBytes));
      if (icCevap["success"]) {
        _eczaneListesi = icCevap["result"]
            .map((e) => EczaneEntity.fromJson(e))
            .toList()
            .cast<EczaneEntity>();
        _eczaneListesi = icCevap["result"].cast<Map>();
        //print(icCevap["result"]);
        setState(() {});
      }
    }
  }

//Lifecycle da ekran daha açılmadan ilk yapılacak şeyler initState de yapılıyor.
  @override
  void initState() {
    _httpIstekYap(widget.ilceAdi, widget.ilAdi);
    print("denizhan");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ilceAdi + " Eczaneleri"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // RaisedButton(
            //   onPressed: () => _httpIstekYap("Suluova", "Amasya"),
            //   child: Text("İstek Yap"),
            // ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  for (dynamic eczane in _eczaneListesi)
                    Card(
                      child: ListTile(
                        //title: Text("eczane"),
                        title: Text(eczane["name"]),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //Text("İlçe : "),
                            Text(eczane["address"]),
                            Text("Telefon : ${eczane["phone"]}"),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.phone),
                          onPressed: () {
                            print("${eczane["phone"]} arandı");
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
