// FUTURS - Main file

// ignore_for_file: camel_case_types
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'companies.dart';
import 'misc.dart';

// URLs
const String api_url = "https://api.npoint.io/e86cf7afdde9b4af50cb";
const String map_url = "https://www.escaux.com/rsrc/EscauxCustomerDocs/DRD_T38Support_AdminGuide/T38_TEST_PAGES.pdf";

// Settings
Color topColor = const Color.fromRGBO(177, 0, 105, 1.0);
Color backgroundColor = const Color.fromRGBO(0, 6, 43, 1.0);

// API Calls
List<Companies> parseCompanies(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String,dynamic>>();
  return parsed.map<Companies>((json) => Companies.fromJson(json)).toList();
}

Future<List<Companies>> fetchCompanies(http.Client client) async {
  final response = await client.get(Uri.parse(api_url));
  if (response.statusCode == 200) { 
      return parseCompanies(response.body); 
   } else { 
      throw Exception('Unable to fetch companies from the REST API');
   } 
}

// Main
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
// Home Activity
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  text: "Une journée type dans le futur, ",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(text: 'pour les jeunes', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    TextSpan(text: '.', style: TextStyle(color: Colors.white)),
                  ],
                ),
                textAlign: TextAlign.center,
              )
            ),
            ElevatedButton(
              child: const Text('Scannez une entreprise'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Futurs_CompaniesRoute()),
                );
              },
            )
          ],
        )
      ),
      
    );
  }
}

// Companies Activity
class Futurs_CompaniesRoute extends StatelessWidget {
  const Futurs_CompaniesRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Exposants"),
              backgroundColor: topColor
            ),
        body: FutureBuilder<List<Companies>>(
        future: fetchCompanies(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Une erreur s'est produite"),
            );
          } else if (snapshot.hasData) {
            return CompaniesList(companies: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
      )
    );
  }
}

// Companies ListView
class CompaniesList extends StatelessWidget {
  const CompaniesList({Key? key, required this.companies}) : super(key: key);

  final List<Companies> companies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
              title: Text(companies[index].companyName),
              subtitle: Text(companies[index].companyDescription),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  companies[index].companyPhotoUrl)),
              trailing: getIcon(companies[index].companyCategory)
            )
        );
      }
    );
  }
}

// Map Activity
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

// Bottom navigation bar
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
        items: const [
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