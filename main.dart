import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Final Exam"),
        ),
        body: const TextSample2(),
      ),
    );
  }
}

class TextSample2 extends StatefulWidget {
  const TextSample2({super.key});

  @override
  TextSample2State createState() => TextSample2State();
}

class TextSample2State extends State<TextSample2> {
  final _formKey = GlobalKey<FormState>();

  String? name,
      password,
      validatedName,
      validatedPass,
      status,
      gender,
      selectedCity,
      city,
      radioChecked,
      drop = "Choose a city";
  bool isStatusChecked = false,
      isRadioMaleChecked = false,
      isRadioFemaleChecked = false;
  late Color contcol = Colors.black;

  List<String> cities = [
    "Ankara",
    "Mersin",
    "Çanakkale",
    "Zonguldak",
    "İstanbul"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Enter user name",
                  labelText: "User Name",
                  prefixIcon: Icon(Icons.person),
                  border: UnderlineInputBorder(),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "User name cannot be left blank";
                  }
                  return null;
                },
                onSaved: (val) {
                  name = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: UnderlineInputBorder(),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Password field cannot be left blank";
                  } else if (val.trim().length < 6) {
                    return "Password length is invalid";
                  }
                  return null;
                },
                onSaved: (val) {
                  password = val;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CheckboxListTile(
              value: isStatusChecked,
              onChanged: (bool? val) {
                setState(() {
                  isStatusChecked = val!;
                });
              }, //onchanged
              title: const Text(
                "Commercial/Individual",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              checkColor: Colors.white,
            ),
            RadioListTile(
              selected: isRadioMaleChecked,
              title: const Text('Male'),
              value: 'Male',
              groupValue: radioChecked,
              onChanged: (val) {
                setState(() {
                  isRadioMaleChecked = true;
                  radioChecked = (val)!;
                });
              },
              activeColor: Colors.black,
            ),
            RadioListTile(
              selected: isRadioFemaleChecked,
              title: const Text('Female'),
              value: 'Female',
              groupValue: radioChecked,
              onChanged: (val) {
                setState(() {
                  isRadioFemaleChecked = true;
                  radioChecked = (val)!;
                });
              },
              activeColor: Colors.black,
            ),
            DropdownButton(
              items: cities.map((val) {
                return DropdownMenuItem(value: val, child: Text(val));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  city = val!;
                  drop = val;
                  selectedCity = val;
                });
              },
              value: selectedCity,
              hint: Text(selectedCity.toString()),
            ),
            ElevatedButton(
              child: const Text("Show User Information"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() {
                    validatedName = name;
                    validatedPass = password;
                    isStatusChecked
                        ? status = 'Commercial'
                        : status = 'Individual';
                    gender = radioChecked;
                    selectedCity = city;
                  });
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.lightBlueAccent.shade100,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 5,
                    child: Center(
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            textAlign: TextAlign.center,
                            "User Name: $validatedName\nUser Password: $validatedPass\nCommercial/Individual: $status\nGender Information: $gender\nCity: $selectedCity",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          );
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
