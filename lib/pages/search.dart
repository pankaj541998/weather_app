import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _city;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;


  void _submit(){
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;

    if(form != null && form.validate()){
      form.save();
      Navigator.pop(context,_city!.trim());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                autofocus: true,
                style: const TextStyle(fontSize: 18.0),
                decoration: const InputDecoration(
                  labelText: 'City Name',
                  hintText: 'More the 2 characters',
                  prefix: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                validator: (String? input){
                  if(input == null || input.trim().length<2){
                    return 'City name must be at least 2 characters long';
                  }
                  return null;
                },
                onSaved: (String? input){
                  _city = input;
                },
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: _submit, child: const Text("How's Weather? ",style: TextStyle(fontSize: 20),)),
          ],
        ),
      ),
    );
  }
}
