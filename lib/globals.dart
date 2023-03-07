library my_prj.globals;

import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'helpers/ad_helper.dart';

InterstitialAd? interstitialAd;


//public static String hiitExercise[] = new String[8];
//public static String circuitExercise[] = new String[8];
//public static String setsExercise[] = new String[8];
//public static int circuitNumberSelected[] = new int[8];
bool weightsArms = false;
bool weightsChest = false;
bool weightsBack = false;
bool weightsShoulders = false;
bool weightsLegs = false;
bool weightsAbs = false;
bool weightsBiceps = false;
bool weightsTriceps = false;


List<ExerciseAndIndex> chestExercises = [];
List<ExerciseAndIndex> backExercises = [];
List<ExerciseAndIndex> armExercises = [];
List<ExerciseAndIndex> shoulderExercises = [];
List<ExerciseAndIndex> coreExercises = [];
List<ExerciseAndIndex> legsExercises = [];
List<ExerciseAndIndex> fullBodyExercises = [];

class ExerciseAndIndex{
  String exerciseName;
  int indexNumber;

  ExerciseAndIndex(this.exerciseName, this.indexNumber);
}

class DailyMeasurements {
  String thisDate;
  double thisWeight;
  double thisFatPercent;

  DailyMeasurements({required this.thisDate, required this.thisWeight, required this.thisFatPercent});

  factory DailyMeasurements.fromJson(Map<String, dynamic> json) {
    return DailyMeasurements(
      thisDate: json['thisDate'],
      thisWeight: json['thisWeight'],
      thisFatPercent: json['thisFatPercent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'thisDate': this.thisDate,
      'thisWeight': this.thisWeight,
      'thisFatPercent': this.thisFatPercent,
    };
  }
}

List <DailyMeasurements> globalDailyMeasurements = [];


class Exercises{
  String exerciseName;
  String exerciseNamePlural;
  bool isSelected = true;
  String deckOfCardsSuit;
  bool deckOfCards = false;
  bool hiit = false;
  bool weights= false;
  bool circuit = false;
  int? circuitNumber;
  bool sets = false;
  String description;
  bool core = false;
  bool biceps = false;
  bool triceps = false;
  bool back = false;
  bool shoulders = false;
  bool quads = false;
  bool calves = false;
  bool fullBody = false;
  bool chest = false;
  String exerciseImageText = "";
  int numberOfExerciseImages = 0;
  bool lowReps = false;
  bool highReps = false;
  bool amrap = false;
  bool dropSet = false;
  bool timeUnderTension = false;

  Exercises(this.exerciseName, this.exerciseNamePlural, this.isSelected,
      this.deckOfCardsSuit, this.deckOfCards, this.hiit, this.weights, this.circuit,
      this.circuitNumber, this.sets, this.description, this.core, this.biceps,
      this.triceps, this.back, this.shoulders, this.quads, this.calves,
      this.fullBody, this.chest, this.exerciseImageText, this.numberOfExerciseImages,
      this.lowReps, this.highReps, this.amrap, this.dropSet, this.timeUnderTension);

  getExerciseName() => exerciseName;
  getExerciseNamePlural() => exerciseNamePlural;
  getIsSelected() => isSelected;
  getDeckOfCardsSuit() => deckOfCardsSuit;
  getDeckOfCards() => deckOfCards;
  getHIIT() => hiit;
  getWeights() => weights;
  getCircuit() => circuit;
  getCircuitNumber() => circuitNumber;
  getSets() => sets;
  getDescription() => description;
  getCore() => core;
  getBiceps() => biceps;
  getTriceps() => triceps;
  getBack() => back;
  getShoulders() => shoulders;
  getQuads() => quads;
  getCalves() => calves;
  getFullBody() => fullBody;
  getChest() => chest;
  getExerciseImageText() => exerciseImageText;
  getNumberOfExerciseImages() => numberOfExerciseImages;
  getLowReps() => lowReps;
  getHighReps() => highReps;
  getAMRAP() => amrap;
  getDropSet() => dropSet;
  getTimeUnderTension() => timeUnderTension;

  setExerciseName(String value) => exerciseName = value;
  setExerciseNamePlural(String value) => exerciseNamePlural = value;
  setIsSelected(bool value) => isSelected = value;
  setDeckOfCardsSuit(String value) => deckOfCardsSuit = value;
  setDeckOfCards(bool value) => deckOfCards = value;
  setHIIT(bool value) => hiit = value;
  setWeights(bool value) => weights = value;
  setCircuit(bool value) => circuit = value;
  setCircuitNumber(int value) => circuitNumber = value;
  setSets(bool value) => sets = value;
  setDescription(String value) => description = value;
  setCore(bool value) => core = value;
  setBiceps(bool value) => biceps = value;
  setTriceps(bool value) => triceps = value;
  setBack(bool value) => back = value;
  setShoulders(bool value) => shoulders = value;
  setQuads(bool value) => quads = value;
  setCalves(bool value) => calves = value;
  setFullBody(bool value) => fullBody = value;
  setChest(bool value) => chest = value;
  setExerciseImageText(String value) => exerciseImageText = value;
  setNumberOfExerciseImages(int value) => numberOfExerciseImages = value;
  setLowReps(bool value) => lowReps = value;
  setHighReps(bool value) => highReps = value;
  setAMRAP(bool value) => amrap = value;
  setDropSet(bool value) => dropSet = value;
  setTimeUnderTension(bool value) => timeUnderTension = value;

}

List<Exercises> exerciseList = [];

int newNumberOfExercisesToChooseFrom = exerciseList.length;

int numberOfExercisesToChooseFrom = 72;
int numberOfDeckOfCardsExercises = numberOfExercisesToChooseFrom;
List<String> deckOfCardsExercises =
List.filled(numberOfExercisesToChooseFrom, "");

List<bool> isAnExercise = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> deckOfCards = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<String> exerciseName = List.filled(numberOfExercisesToChooseFrom + 1, "");
List<String> exerciseNamePlural =
List.filled(numberOfExercisesToChooseFrom + 1, "");
List<String> deckOfCardsSuit =
List.filled(numberOfExercisesToChooseFrom + 1, "");
List<bool> HIIT = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> weights = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> circuit = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> sets = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<String> exerciseImageText =
List.filled(numberOfExercisesToChooseFrom + 1, "");
List<int> numberOfExerciseImages =
List.filled(numberOfExercisesToChooseFrom + 1, 1);

List<bool> upperBody = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> core = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> legs = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> biceps = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> triceps = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> back = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> shoulders = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> quads = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> calves = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> fullBody = List.filled(numberOfExercisesToChooseFrom + 1, false);
List<bool> chest = List.filled(numberOfExercisesToChooseFrom + 1, false);

List<bool> isSelected = List.filled(numberOfExercisesToChooseFrom + 1, true);

List<bool> lowReps = List.filled(numberOfExercisesToChooseFrom + 1, true);
List<bool> highReps = List.filled(numberOfExercisesToChooseFrom + 1, true);
List<bool> amrap = List.filled(numberOfExercisesToChooseFrom + 1, true);
List<bool> dropSet = List.filled(numberOfExercisesToChooseFrom + 1, true);
List<bool> timeUnderTension = List.filled(numberOfExercisesToChooseFrom + 1, true);

//circuit number is as follows:
//1: 1/2/5/10/15 reps
//2: 2/5/10/20/25 reps
//3: 5/10/20/30/50 reps
//4: 10/15/30/60/90 seconds
List<int> circuitNumber = List.filled(numberOfExercisesToChooseFrom + 1, 0);

List<String> description = List.filled(numberOfExercisesToChooseFrom + 1, "");

void createAds() {
  InterstitialAd.load(
    adUnitId: AdHelper.interstitialAdUnitId,
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        interstitialAd = ad;

      },
      onAdFailedToLoad: (LoadAdError error) {
        print('InterstitialAd failed to load: $error');

        interstitialAd = null;
      },
    ),
  );
}

void showAd() {
  if (interstitialAd != null) {
    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          createAds();
        }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      print('$ad onAdFailedToShowFullScreenContent: $error');
      ad.dispose();
      createAds();
    });
  }

  interstitialAd?.show();
}
/*

  public static int numberOfHIITExercises;
  public static int HIITLevel;

  public static int numberOfCircuitExercises;
  public static int circuitLevel;

  public static int numberOfSetsExercises;
  public static int setsLevel;



  public static int currentExerciseNumber;
*/
