// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

Color topColor = const Color.fromRGBO(177, 0, 105, 1.0);
Color backgroundColor = const Color.fromRGBO(0, 6, 43, 1.0);

void main() {
  runApp(
    MaterialApp(
      title: 'Futurs',
      theme: ThemeData(
        primaryColor: topColor,
        scaffoldBackgroundColor: backgroundColor 
      ),
      home: const Navigation(),
    )
  );
}

// ignore: constant_identifier_names
const String map_url = "https://www.escaux.com/rsrc/EscauxCustomerDocs/DRD_T38Support_AdminGuide/T38_TEST_PAGES.pdf";
const Color darkBackground = Color(0xFF2D2D2D);

class Company {
  int id;
  String name;
  String description;
  IconData icon;
  String photo;

  Company(this.id,
          this.name,
          this.description,
          this.icon,
          this.photo);
}

// TESTS (start)
Company test1 = Company(1,
                        "Microsoft",
                        "It's Microsoft bro",
                        Icons.ac_unit,
                        "https://pbs.twimg.com/profile_images/1234407307955535873/0pjqJnab_400x400.png");

Company test2 = Company(2,
                        "Ubisoft",
                        "Assassin's Creed for Life",
                        Icons.access_alarm,
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6P_xCU5PeM3YF4MPc2e5IbRCrPyeoj1iGYln1Zgaklvyi0jbXyozuTQ7oew78cCAkFzU&usqp=CAU");

Company test3 = Company(3,
                        "EpiMac",
                        "The best company",
                        Icons.computer,
                        "https://media-exp1.licdn.com/dms/image/C560BAQE2K1RY08GxSA/company-logo_200_200/0/1562418791936?e=2159024400&v=beta&t=Eu2g_9IDiUIJzd9t7keq_jf3HmQ6GXbWKRx61ThZr2I");

final companies = [test1, test2, test3];
// TESTS (end)

class Futurs_HomeRoute extends StatelessWidget {
  const Futurs_HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FUTURS"),//Image.asset('assets/logo_futurs.png', fit: BoxFit.cover),
        backgroundColor: topColor
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Scannez une entreprise'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Futurs_CompaniesRoute()),
            );
          },
        ),
      ),
    );
  }
}

class Futurs_CompaniesRoute extends StatelessWidget {
  const Futurs_CompaniesRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  title: Text(companies[index].name),
                  subtitle: Text(companies[index].description),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          companies[index].photo)),
                  trailing: Icon(companies[index].icon)));
        });
  }
}

class Futurs_MapRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Futurs_MapRoute_State();
}

class _Futurs_MapRoute_State extends State<Futurs_MapRoute> {
  bool _isLoading = true;
  late PDFDocument document;
  String title = "Loading";

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    setState(() {
      _isLoading = true;
      title = "Chargement en cours";
    });
    document = await PDFDocument.fromURL(map_url);
    
    setState(() {
      title = "Plan du salon";
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: topColor
            ),
            body: Center(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : PDFViewer(
                        document: document,
                        zoomSteps: 1,
                      ))));
  }
}

/*
class Futurs_MapRoute extends StatelessWidget {
  const Futurs_MapRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan du salon'),
      ),
      body: Center(
          child: PDFViewer(document: map_document)),
    );
  }
}
*/

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [Futurs_HomeRoute(),
                                       Futurs_CompaniesRoute(),
                                       Futurs_MapRoute()];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.apartment), label: 'Exposants'),
          BottomNavigationBarItem(
              icon: Icon(Icons.map), label: 'Plan')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}

/*
class _QRViewExampleState {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Barcode result;
  late QRViewController controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    //super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
*/