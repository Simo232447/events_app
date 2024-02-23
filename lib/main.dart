import 'package:evens_app/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool nightMode = false;

  DateTime date = DateTime(2016, 10, 26);
  DateTime dateTime = DateTime(2016, 8, 3, 17, 45);

  List<String> list = <String>['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  String dropdownValue = 'Monday';

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  bool switchValue = false;


  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        backgroundColor: nightMode ? Colors.black54 : Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(dropdownValue, style: TextStyle(color: nightMode ? Colors.white : Colors.black)),
              ),
              Center(
                child: Wrap(
                  children: [


                      /// 2  : vari custom Button ricorda di decommentare la quadra riga 108

                      CustomButton(
                      title: 'Button 1',
                      myfunction: () {
                        print('Button 1 pressed');
                      },
                      nightMode: nightMode,
                    ),
                    CustomButton(
                      title: 'Button 2',
                      myfunction: () {
                        print('Button 2 pressed');
                      },
                      nightMode: nightMode,
                    ),

                   ]
                ),
              ),

              Center(
                child: CustomButton(
                  title: 'switch mode',
                  myfunction: () {
                    setState(() {
                      nightMode = !nightMode;
                    });
                  },
                  nightMode: nightMode,
                ),
              ),

              //3 aggiunta del date picker --> aggiungi anche le funzioni e variabii relative sopra

              Center(
                child: CupertinoButton(
                  // Display a CupertinoDatePicker in date picker mode.
                  onPressed: () => _showDialog(
                    CupertinoDatePicker(
                      initialDateTime: date,
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      // This shows day of week alongside day of month
                      showDayOfWeek: true,
                      // This is called when the user changes the date.
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() => date = newDate);
                      },
                    ),
                  ),
                  // In this example, the date is formatted manually. You can
                  // use the intl package to format the value based on the
                  // user's locale settings.
                  child: Text(
                    '${date.day}-${date.month}-${date.year}',
                    style: TextStyle(
                      color: nightMode ? Colors.white: Colors.black,
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),

              /// 4 Gestione eventi con DropDown Button deommenta anche la funzione sopra e il titolo all'inizio della colonna

        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),

              /// 5 creazione del Form Decommenta anche la chiave sopra

              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: 'insert your name'),
                        controller: nameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: 'insert your password'),
                        controller: passwordController,
                      ),
                    ),

                    //6 aggiunta del cupertino switch

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('accept terms and conditions ', style: TextStyle(color: nightMode ? Colors.white : Colors.black),),
                        CupertinoSwitch(
                          // This bool value toggles the switch.
                          value: switchValue,
                          activeColor: CupertinoColors.activeBlue,
                          onChanged: (bool? value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              switchValue = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                    CustomButton(
                        title: 'send',
                        myfunction: (){
                          if(_formKey.currentState!.validate()){

                            //7 aggiunta della logica del cupertino switch

                            if(switchValue){
                              print(nameController.text);
                              print(passwordController.text);
                            }else {
                              print('user did not agree terms and conditions');
                            }

                          }
                        },
                        nightMode: nightMode)
                  ],
                ),

              )

            ],
          ),
        ),
      ),
    );
  }
}
