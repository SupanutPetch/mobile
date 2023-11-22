import 'package:flutter/material.dart';
import 'package:project_mobile/constant/color.dart';

class Textformfields {
  static Widget fieldBlank(String title, IconData icon) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 75),
          child: Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white))),
      const SizedBox(height: 5),
      Row(children: [
        SizedBox(
            width: 350,
            child: TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.lightnavi,
                  icon: Icon(icon, color: Colors.amber, size: 45),
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.indigo, width: 2)),
                )))
      ])
    ]);
  }

  static Widget fieldPassWord(
      String title, IconData icon, bool obscure, Function function) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 75),
          child: Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white))),
      const SizedBox(height: 5),
      Row(children: [
        SizedBox(
            width: 350,
            child: TextFormField(
                style: const TextStyle(color: Colors.white),
                obscureText: obscure,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.lightnavi,
                  icon: Icon(icon,
                      color: Colors.amber,
                      size: 45,
                      shadows: const [
                        Shadow(blurRadius: 2, color: Colors.white)
                      ]),
                  labelStyle: const TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                      onPressed: () => function(),
                      icon: obscure
                          ? const Icon(Icons.visibility_off,
                              color: Colors.white)
                          : const Icon(Icons.visibility, color: Colors.amber)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      )),
                )))
      ])
    ]);
  }
}

class Button {
  static buttonSave(String label, Icon icon, var save) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Container(
        width: 250,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2)),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: save,
          icon: icon,
          label: Text(label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                shadows: [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.white,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
