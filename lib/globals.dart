library my_prj.globals;
import 'dart:core';

import 'package:flutter/material.dart';

  //List <String> deckOfCardsExercise = new String;
  //public static String hiitExercise[] = new String[8];
  //public static String circuitExercise[] = new String[8];
  //public static String setsExercise[] = new String[8];
  //public static int circuitNumberSelected[] = new int[8];

  int numberOfExercisesToChooseFrom = 31;

  List <bool> deckOfCards = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <String> exerciseName = List.filled(numberOfExercisesToChooseFrom + 1, "");
  List <String> deckOfCardsSuit = List.filled(numberOfExercisesToChooseFrom + 1, "");
  List <bool> HIIT = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> circuit = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> sets = List.filled(numberOfExercisesToChooseFrom + 1, false);

  //circuit number is as follows:
  //1: 1/2/5/10/15 reps
  //2: 2/5/10/20/25 reps
  //3: 5/10/20/30/50 reps
  //4: 10/15/30/60/90 seconds
  List <int> circuitNumber = List.filled(numberOfExercisesToChooseFrom + 1, 0);

  List <String> description = List.filled(numberOfExercisesToChooseFrom + 1, "");


//exerciseName[0] = "[Select Exercise...]";
//Global.deckOfCardsSuit[0] = "";
//globals.deckOfCards[0] = true;`
//Global.HIIT[0] = true;
//Global.circuit[0] = true;
//Global.circuitNumber[0] = 0;
//Global.sets[0] = true;

/*

  public static int numberOfHIITExercises;
  public static int HIITLevel;

  public static int numberOfCircuitExercises;
  public static int circuitLevel;

  public static int numberOfSetsExercises;
  public static int setsLevel;



  public static int currentExerciseNumber;
*/