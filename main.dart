import 'package:flutter/material.dart';
void main() {
  runApp(KalkulatorApp());
}
class KalkulatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Kalkulator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Kalkulator extends StatefulWidget {
  @override
  _KalkulatorState createState() => _KalkulatorState();
}
class _KalkulatorState extends State<Kalkulator> {
  String ekran = '';
  String dzialanie = '';
  double liczba1 = 0;
  double liczba2 = 0;
  String operacja = '';
  bool nowaLiczba = false;
  void klik(String wartosc) {
    setState(() {
      if (wartosc == '+' || wartosc == '-' || wartosc == '*' || wartosc == '/') {
        operacja = wartosc;
        liczba1 = double.tryParse(ekran) ?? 0;
        dzialanie = ekran + ' ' + operacja;
        nowaLiczba = true;
      }
      else if (wartosc == '=') {
        liczba2 = double.tryParse(ekran) ?? 0;
        double wynik = 0;
        if (operacja == '+') {
          wynik = liczba1 + liczba2;
        } else if (operacja == '-') {
          wynik = liczba1 - liczba2;
        } else if (operacja == '*') {
          wynik = liczba1 * liczba2;
        } else if (operacja == '/') {
          if (liczba2 != 0) {
            wynik = liczba1 / liczba2;
          } else {
            ekran = 'Błąd';
            dzialanie = '';
            return;
          }
        }
        dzialanie = '$liczba1 $operacja $liczba2 =';
        ekran = wynik.toString();
        nowaLiczba = true;
      }
      else if (wartosc == 'C') {
        ekran = '';
        dzialanie = '';
        liczba1 = 0;
        liczba2 = 0;
        operacja = '';
        nowaLiczba = false;
      }
      else {
        if (nowaLiczba) {
          ekran = wartosc;
          nowaLiczba = false;
        } else {
          ekran += wartosc;
        }
      }
    });
  }
  Widget przycisk(String tekst) {
    Color kolorTla;
    Color kolorTekstu = Colors.black;
    if (tekst == 'C') {
      kolorTla = Colors.redAccent;
      kolorTekstu = Colors.white;
    } else if (tekst == '+' || tekst == '-' || tekst == '*' || tekst == '/' || tekst == '=') {
      kolorTla = Colors.orange;
      kolorTekstu = Colors.white;
    } else {
      kolorTla = Colors.blue;
      kolorTekstu=Colors.white;
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kolorTla,
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: () => klik(tekst),
          child: Text(
            tekst,
            style: TextStyle(fontSize: 24, color: kolorTekstu),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Prosty Kalkulator'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: 20, right: 20),
            child: Text(
              dzialanie,
              style: TextStyle(fontSize: 24, color: Colors.black54),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(
              ekran,
              style: TextStyle(fontSize: 36, color: Colors.black),
            ),
          ),
          Divider(),
          Column(
            children: [
              Column(
                children: [
                  Row(children: [przycisk('7'), przycisk('8'), przycisk('9'), przycisk('/')]),
                  Row(children: [przycisk('4'), przycisk('5'), przycisk('6'), przycisk('*')]),
                  Row(children: [przycisk('1'), przycisk('2'), przycisk('3'), przycisk('-')]),
                  Row(children: [przycisk('0'), przycisk('C'), przycisk('='), przycisk('+')]),
                ],
              )

            ],
          ),
        ],
      ),
    );
  }
}