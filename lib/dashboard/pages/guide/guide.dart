import 'package:flutter/material.dart';
import 'package:scrollable_text_indicator/scrollable_text_indicator.dart';

import '../../../globals.dart';

class Guide extends StatelessWidget {
  const Guide({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width;

    return new Scaffold(
        appBar: AppBar(
          backgroundColor: color1,
          title: Text(
            app_title,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Text(
                  "Tips/Guide",
                  style: new TextStyle(
                      fontSize: 28.0,
                      color: color1,
                      fontWeight: FontWeight.w600),
                ),
              ),
              new Expanded(
                flex: 1,
                child: new SingleChildScrollView(
                  scrollDirection: Axis.vertical, //.horizontal
                  child: new Text(
                    "Are you aware that a certified virus-free vine is the most important investment that you can make during vineyard establishment?"
                    "\n\nDo you know that you can manage grapevine virus diseases by “Starting Clean” and “Staying Clean”?"
                    "\n\nStarting Clean: plant only certified virus-free vines"
                    "\n\nStaying Clean: monitor and manage insect vectors of major grapevine viruses; replace infected vines only with certified virus-free vines."
                    "\n\nDo you know that several species of mealybugs and soft scale insects transmit grapevine leafroll-associated viruses from infected to healthy vines?"
                    "\nCan you identify these insects?"
                    "\n\nDo you know how to scout for them in vineyard?"
                    "\n\nAre you aware that the three-cornered alfalfa hopper is a vector for grapevine red blotch virus?"
                    "\n\nCan you identify this insect?"
                    "\n\nDo you know how to scout for it in vineyards?"
                    "\n\nThese can be rephrased differently as you deem fit and we can always modify and add to the list as necessary.",
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
