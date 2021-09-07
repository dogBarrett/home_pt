List <String> deckOfCardsExercises(){
  return ["Burpees",
  "Push ups",
  "Sit-ups",
  "Squats",
  "Lunges",
  "Get ups",
  "Crunches"];
}

String getDeckOfCardsExercises(int number){
  switch (number){
    case 0:
      return "Burpees";
    case 1:
      return "Push ups";
    case 2:
      return "Sit-ups";
    case 3:
      return "Squats";
    case 4:
      return "Lunges";
    case 5:
      return "Get ups";
    case 6:
      return "Crunches";
    default:
      return "";
  }
}
