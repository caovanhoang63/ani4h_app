String capitalizeFirstLetter(String input) {
  if (input.isEmpty) {
    return input;  // Return the original string if it's empty
  }

  // Remove underscores and split by the underscore
  input = input.replaceAll('_', ' ');

  // Capitalize the first letter and ensure the rest are lowercase
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

String capitalizeSentence(String sentence) {
  return sentence
      .split(' ')  // Split sentence into words by spaces
      .map((word) => capitalizeFirstLetter(word))  // Capitalize each word
      .join(' ');  // Join the words back together
}
