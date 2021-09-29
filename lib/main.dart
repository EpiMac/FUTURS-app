import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Futurs',
    home: Futurs_HomeRoute(),
  ));
}

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
Company test1 = new Company(1,
                            "Microsoft",
                            "It's Microsoft bro",
                            Icons.ac_unit,
                            "https://pbs.twimg.com/profile_images/1234407307955535873/0pjqJnab_400x400.png");

Company test2 = new Company(2,
                            "Ubisoft",
                            "Assassin's Creed for Life",
                            Icons.access_alarm,
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6P_xCU5PeM3YF4MPc2e5IbRCrPyeoj1iGYln1Zgaklvyi0jbXyozuTQ7oew78cCAkFzU&usqp=CAU");

Company test3 = new Company(3,
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
        title: const Text('Home Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Discover companies'),
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