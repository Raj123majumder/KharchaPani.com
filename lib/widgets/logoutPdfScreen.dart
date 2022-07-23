import 'package:expenses_app/screens/landingPage.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class logoutPdfScreen extends StatelessWidget {
  const logoutPdfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
                fit: FlexFit.loose,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => landingPage()));
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.picture_as_pdf,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Invoice',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        )
      )
    );
  }
}