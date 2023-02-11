import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Currency(),
    ),
  );
}

class Currency extends StatefulWidget {
  const Currency({Key? key}) : super(key: key);

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  String? dropDownValueFrom;
  String? dropDownValueTo;
  double result = 0.0;
  String amount = "";
  List from = ['INR', 'EUR', 'CAD', 'USD', 'AUD', 'GBP', 'JPY', 'PKR', 'LKR', 'KWD'];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Stack(
        children: [
          SizedBox(
            height: h,
            width: w,
            child: const Image(
              image: AssetImage('images/1585609947689.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: h,
            width: w,
            color: Colors.black54,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    SafeArea(
                      child: Text(
                        "Currency Exchange Rate",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 28,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    // =========== From ====================

                    const SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text("From",
                    //       style: TextStyle(
                    //         color: Colors.grey.shade400,
                    //         fontSize: 19,
                    //         fontWeight: FontWeight.w700,
                    //         letterSpacing: 1
                    //       ),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 38,),
                    //     Expanded(
                    //       child: Text("To",
                    //         style: TextStyle(
                    //             color: Colors.grey.shade400,
                    //             fontSize: 19,
                    //             fontWeight: FontWeight.w700,
                    //             letterSpacing: 1
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From",
                                style: TextStyle(color: Colors.grey.shade400, fontSize: 19, fontWeight: FontWeight.w700, letterSpacing: 1),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: h / 16,
                                width: w,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  child: DropdownButtonFormField(
                                    hint: Text(
                                      "Country",
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                    ),
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                    ),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    //value: dropDownValue,
                                    items: from.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: GoogleFonts.poppins(
                                              // fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropDownValueFrom = value as String?;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "To",
                                style: TextStyle(color: Colors.grey.shade400, fontSize: 19, fontWeight: FontWeight.w700, letterSpacing: 1),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: h / 16,
                                width: w,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                                  child: DropdownButtonFormField(
                                    hint: Text(
                                      "Country",
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                    ),
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                    ),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    //value: dropDownValue,
                                    items: from.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: GoogleFonts.poppins(),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropDownValueTo = value as String?;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // =========== To ====================

                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Amount",
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 19, fontWeight: FontWeight.w700, letterSpacing: 1),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: h / 16,
                      width: w,
                      child: TextFormField(
                        onChanged: (val) {
                          setState(() {
                            amount = val;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          hintText: "Amount",
                          hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        style: GoogleFonts.poppins(
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    // =========== Convert ====================
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          getDataApiResponse();
                        });
                      },
                      child: Container(
                        height: h / 14,
                        width: w,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Convert",
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 23, letterSpacing: 0.8, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),

                    // =========== Result ====================

                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Converted Amount",
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 19, fontWeight: FontWeight.w700, letterSpacing: 1),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: h / 16,
                      width: w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${result.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 23, letterSpacing: 0.3, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  getDataApiResponse() async {
    var url = Uri.parse(
        "https://api.apilayer.com/exchangerates_data/convert?to=$dropDownValueTo&from=$dropDownValueFrom&amount=$amount&apikey=1BLrbQ06jAlURku6ImqOhAO8IxuZQGQ4");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        result = data['result'];
      });
    }
  }
}
