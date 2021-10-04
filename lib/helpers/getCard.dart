import 'package:flutter/material.dart';

import 'package:home_pt/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';


int getNumberOfReps(int cardNumber){

  bool boolPicturePicture = true;
  bool boolPicture10 = false;
  bool boolAce1 = true;
  bool boolAce11 = false;

  void getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    boolPicturePicture = prefs.getBool('boolPicturePicture') ?? true;
    boolPicture10 = prefs.getBool('boolPicture10') ?? false;
    boolAce1 = prefs.getBool('boolAce1') ?? true;
    boolAce11 = prefs.getBool('boolAce11') ?? false;
  }

  getPreferences();

  if (cardNumber == 12 || cardNumber == 25 || cardNumber == 38 || cardNumber == 51){
    if (boolPicturePicture) return 13;
    else return 10;
  }
  else if (cardNumber == 11 || cardNumber == 24 || cardNumber == 37 || cardNumber == 50) {
    if (boolPicturePicture)
      return 12;
    else
      return 10;
  }
  else if (cardNumber == 10 || cardNumber == 23 || cardNumber == 36 || cardNumber == 49) {
    if (boolPicturePicture)
      return 11;
    else
      return 10;
  }
  else if (cardNumber == 0 || cardNumber == 13 || cardNumber == 26 || cardNumber == 39){
    if (boolAce1) return 1;
    else return 11;
  }
  else{
    if (cardNumber >= 39) {
      return cardNumber - 38;
    }
    else if (cardNumber >= 26 && cardNumber <= 38){
      return cardNumber - 25;
    }
    else if (cardNumber >= 13 && cardNumber <= 25){
      return cardNumber - 12;
    }
    else return (cardNumber + 1);
  }




}
String getCardImageText(int cardNumber){
  String cardImageString;
  if (cardNumber == 0 || cardNumber == 13 || cardNumber == 26 || cardNumber == 39){
    cardImageString = "A";
  }
  else if (cardNumber == 1 || cardNumber == 14 || cardNumber == 27 || cardNumber == 40){
    cardImageString = "2";
  }
  else if (cardNumber == 2 || cardNumber == 15 || cardNumber == 28 || cardNumber == 41){
    cardImageString = "3";
  }
  else if (cardNumber == 3 || cardNumber == 16 || cardNumber == 29 || cardNumber == 42){
    cardImageString = "4";
  }
  else if (cardNumber == 4 || cardNumber == 17 || cardNumber == 30 || cardNumber == 43) {
    cardImageString = "5";
  }
  else if (cardNumber == 5 || cardNumber == 18 || cardNumber == 31 || cardNumber == 44){
    cardImageString = "6";
  }
  else if (cardNumber == 6 || cardNumber == 19 || cardNumber == 32 || cardNumber == 45){
    cardImageString = "7";
  }
  else if (cardNumber == 7 || cardNumber == 20 || cardNumber == 33 || cardNumber == 46){
    cardImageString = "8";
  }
  else if (cardNumber == 8 || cardNumber == 21 || cardNumber == 34 || cardNumber == 47){
    cardImageString = "9";
  }
  else if (cardNumber == 9 || cardNumber == 22 || cardNumber == 35 || cardNumber == 48){
    cardImageString = "10";
  }
  else if (cardNumber == 10 || cardNumber == 23 || cardNumber == 36 || cardNumber == 49){
    cardImageString = "J";
  }
  else if (cardNumber == 11 || cardNumber == 24 || cardNumber == 37 || cardNumber == 50){
    cardImageString = "Q";
  }
  else if (cardNumber == 12 || cardNumber == 25 || cardNumber == 38 || cardNumber == 51){
    cardImageString = "K";
  }
  else{
    cardImageString = "aces";
  }

  cardImageString = cardImageString + getCardSuit(cardNumber);
  return "assets/cards/" + cardImageString + ".png";
}

String getCardSuit(int cardNumber){
  if (cardNumber >= 0 && cardNumber <= 12) {
    return "S";
  }
  else if (cardNumber >= 13 && cardNumber <= 25) {
    return "C";
  }
  else if (cardNumber >= 26 && cardNumber <= 38) {
    return "D";
  }
  else if (cardNumber >= 37 && cardNumber <= 51) {
    return "H";
  }
  else {
    return "";
  }
}