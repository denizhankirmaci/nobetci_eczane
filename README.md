# eczane

Flutter test project.

## Description

Proje, API yardımı ile anlık olarak nöbetçi eczaneleri çekip listeleyen bir uygulamadır.

## Notes

Proje, debug mode da internet erişimine açık fakat production (release) mode da internet erişimi yoktu. 
Bunun çözümü ; android>app>src>main> AndroidManifest.xml dosyasına <uses-permission android:name="android.permission.INTERNET"/> kodunu eklemektir.

# v1
- Uygulama listeleme yapıyor.

# v2 (Development)
- Listeleme sonrasında telefon ve harita özellikleri eklenecek.
