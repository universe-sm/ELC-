import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyFormInImageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 3, 3, 3),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/6.jpg',
                width: 430,
                height: 700,
                fit: BoxFit.fill,
              ),
              Positioned(
                top: 205,
                child: Container(
                  width: 320,
                  height: 320,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      243,
                      177,
                      177,
                    ).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: UserForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _mobile = TextEditingController();
  DateTime? _dob;
  String? _gender;
  String? _bloodGroup;

  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Form submitted!')));
    }
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dob = picked;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Register',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 10),

        // Scrollable form fields (only 3 visible at a time)
        Theme(
          data: Theme.of(context).copyWith(
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all<Color>(
                Colors.red,
              ), // scrollbar thumb color
              trackColor: MaterialStateProperty.all<Color>(
                Colors.grey.shade300,
              ), // optional track color
              thickness: MaterialStateProperty.all<double>(
                6,
              ), // width of the scrollbar
              radius: Radius.circular(6),
            ),
          ),

          child: Container(
            height: 180, // shows approx. 3 fields
            child: Scrollbar(
              controller: _scrollController,
              thickness: 8,
              radius: Radius.circular(4),
              scrollbarOrientation:
                  ScrollbarOrientation.right, // ensures it's on the right edge
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 0,
                ), // remove inner padding if any
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(right: 15.0),
                  primary: false,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        field(
                          controller: _name,
                          label: 'Name',
                          validator: (val) =>
                              val == null || val.isEmpty ? 'Enter name' : null,
                        ),
                        field(
                          controller: _email,
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => val == null || !val.contains('@')
                              ? 'Enter valid email'
                              : null,
                        ),
                        field(
                          controller: _password,
                          label: 'Password',
                          obscureText: true,
                          validator: (val) => val == null || val.length < 6
                              ? 'Min 6 characters'
                              : null,
                        ),
                        field(
                          controller: _mobile,
                          label: 'Mobile Number',
                          keyboardType: TextInputType.phone,
                          validator: (val) => val == null || val.length != 10
                              ? 'Enter 10-digit number'
                              : null,
                        ),
                        GestureDetector(
                          onTap: _pickDate,
                          child: AbsorbPointer(
                            child: field(
                              controller: TextEditingController(
                                text: _dob == null
                                    ? ''
                                    : DateFormat('dd-MM-yyyy').format(_dob!),
                              ),
                              label: 'Date of Birth',
                              validator: (val) => val == null || val.isEmpty
                                  ? 'Select date'
                                  : null,
                            ),
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            filled: true,
                            fillColor: Colors.white70,
                            border: OutlineInputBorder(),
                          ),
                          value: _gender,
                          items: ['Male', 'Female', 'Other']
                              .map(
                                (g) =>
                                    DropdownMenuItem(value: g, child: Text(g)),
                              )
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _gender = val;
                            });
                          },
                          validator: (val) =>
                              val == null ? 'Select gender' : null,
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Blood Group',
                            filled: true,
                            fillColor: Colors.white70,
                            border: OutlineInputBorder(),
                          ),
                          value: _bloodGroup,
                          items: _bloodGroups.map((String group) {
                            return DropdownMenuItem<String>(
                              value: group,
                              child: Text(group),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _bloodGroup = newValue;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Select blood group' : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 10),

        // Submit button outside scroll
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text('Submit'),
        ),
      ],
    );
  }

  Widget field({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white70,
          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
