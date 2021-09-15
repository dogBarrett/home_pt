library my_prj.globals;
import 'dart:core';

import 'package:flutter/material.dart';

  //public static String hiitExercise[] = new String[8];
  //public static String circuitExercise[] = new String[8];
  //public static String setsExercise[] = new String[8];
  //public static int circuitNumberSelected[] = new int[8];

  int numberOfExercisesToChooseFrom = 31;
  int numberOfDeckOfCardsExercises = numberOfExercisesToChooseFrom;
  List <String> deckOfCardsExercises = List.filled(numberOfExercisesToChooseFrom, "");

  List <bool> deckOfCards = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <String> exerciseName = List.filled(numberOfExercisesToChooseFrom + 1, "");
  List <String> exerciseNamePlural = List.filled(numberOfExercisesToChooseFrom + 1, "");
  List <String> deckOfCardsSuit = List.filled(numberOfExercisesToChooseFrom + 1, "");
  List <bool> HIIT = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> circuit = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> sets = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <String> exerciseImageText = List.filled(numberOfExercisesToChooseFrom + 1, "");
  List <int> numberOfExerciseImages = List.filled(numberOfExercisesToChooseFrom + 1, 1);

  List <bool> upperBody = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> core = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> legs = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> biceps = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> triceps = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> back = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> shoulders = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> quads = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> calves = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> fullBody = List.filled(numberOfExercisesToChooseFrom + 1, false);
  List <bool> chest = List.filled(numberOfExercisesToChooseFrom + 1, false);

  List <bool> isSelected = List.filled(numberOfExercisesToChooseFrom + 1, true);



//circuit number is as follows:
  //1: 1/2/5/10/15 reps
  //2: 2/5/10/20/25 reps
  //3: 5/10/20/30/50 reps
  //4: 10/15/30/60/90 seconds
  List <int> circuitNumber = List.filled(numberOfExercisesToChooseFrom + 1, 0);

  List <String> description = List.filled(numberOfExercisesToChooseFrom + 1, "");

/*

  public static int numberOfHIITExercises;
  public static int HIITLevel;

  public static int numberOfCircuitExercises;
  public static int circuitLevel;

  public static int numberOfSetsExercises;
  public static int setsLevel;



  public static int currentExerciseNumber;
*/