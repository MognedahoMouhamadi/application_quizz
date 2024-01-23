import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one_day_flutter/Question.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const QUIZZ());
}

class QUIZZ extends StatelessWidget {
  const QUIZZ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quizz",
      theme: ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(color: Colors.white),
        primarySwatch: Colors.cyan,
        // Changez la couleur de fond de l'AppBar ici
      ),
      home: const SimpleQuizz(),
      // On doit créer le widget de type stateful, ce widget pourra changer d'état
    );
  }
}

class SimpleQuizz extends StatefulWidget {
  const SimpleQuizz({super.key});

  @override
  State<SimpleQuizz> createState() => _SimpleQuizzState();
}

class _SimpleQuizzState extends State<SimpleQuizz> {


  var _id = 0;
  bool _quizzTermine = false;
  double juste = 0 ;
  double nbrq = 0;
  BoutonQuizz(String textBouton, Color couleurText, Color couleurBouton){
    return Container(
      height: 50,
      color: couleurBouton,
      child: MaterialButton(
        onPressed: () => BoutonPresse(textBouton),
        padding: EdgeInsets.all(16),
        child: Text(textBouton, style: TextStyle(color: couleurText, fontSize: 30, fontWeight: FontWeight.normal),),),
    );
  }

  BoutonPresse(String textBouton) {
    print(textBouton);

    var n = que_liste.length;

    if (_id < n) {
      if (textBouton == 'Faux' && que_liste[_id].ans == false) {
        reponse.add("✓");
        juste++;
        print(_id);
      } else if (textBouton == 'Faux' && que_liste[_id].ans == true) {
        reponse.add("✕");
        print(_id);
      } else if (textBouton == 'Vrai' && que_liste[_id].ans == true) {
        reponse.add("✓");
        juste++;
        print(_id);
      } else if (textBouton == 'Vrai' && que_liste[_id].ans == false) {
        reponse.add("✕");
        print(_id);
      }

      setState(() {
        if (_id < n - 1) {
          _id++;
        } else {
          // Afficher un message indiquant que le quizz est terminé
          _quizzTermine = true;
          print('Quizz terminé');
        }
        print(reponse);
      });
    }
  }

  List que_liste=[
    Question("Un colibri d'Elena pèse aussi lourd qu’une pièce d'un euro. Vrai ou faux ?","1", false ),
    Question("Le requin est l’animal le plus dangereux pour l’homme. Vrai ou faux ?","2", false ),
    Question("Au XVIIe siècle, les carottes n’étaient pas orange. Vrai ou faux ?","3", true )
  ];



List reponse =[];
  @override
  Widget build(BuildContext context) {

    nbrq + que_liste.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quizz"),
        centerTitle: true,
        elevation: 20,
        backgroundColor: Colors.blue.shade400,

        leading: IconButton(onPressed: (){
          //faire quelques chose
        }, icon:Icon(Icons.menu),
        ),
      ),
      backgroundColor: Colors.blue.shade300,
      body:  _quizzTermine ? Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
        child: Text(
          "Quizz terminé",
          style: TextStyle(fontSize: 35),
        ),
      ):

      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex:5,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child:Text(que_liste[_id].que,
                    textAlign: TextAlign.center,
                    style:TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),),
                ),
              )
          ),//question

          Expanded(child: Padding(
            padding:EdgeInsets.all(13.0),
            child: SfLinearGauge(
              minimum: 0,
              maximum: 3,
              ranges: <LinearGaugeRange>[LinearGaugeRange(startValue: 0, endValue:juste,color: Colors.green,)],
            ),
          ),
          ),


          Expanded(child: Padding(
              padding:EdgeInsets.all(13.0),
            child: BoutonQuizz('Vrai', Colors.white, Colors.green,)
          ),
          ),

          Expanded(child: Padding(
              padding:EdgeInsets.all(13.0),
              child: BoutonQuizz('Faux', Colors.white, Colors.red,)
          ),
          ),

        ],
      ),
      );
  }
}

