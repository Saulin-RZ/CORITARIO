String removeDiacritics(String str) {
  var withDia = 'ÀÁÂÃÄÅàáâãäåÈÉÊËèéêëÌÍÎÏìíîïÒÓÔÕÖØòóôõöøÙÚÛÜùúûüÝýÿÑñ';
  var withoutDia = 'AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuYyyNn';

  for (int i = 0; i < withDia.length; i++) {
    str = str.replaceAll(withDia[i], withoutDia[i]);
  }
  return str;
}

List<int> keyWordSearch(keyword, songs) {
  try {
    List<int> matchingIndices = [];

    // Normalize the keyword
    keyword = removeDiacritics(keyword.toLowerCase());

    // Loop through the songs and extract numbers and titles
    for (var i = 0; i < songs.length; i++) {
      var song = songs[i];
      String title = removeDiacritics(song['title'].toLowerCase());
      //String lyrics = removeDiacritics(song['lyrics_without_chords'].toLowerCase());
      
     // if (title.contains(keyword) || lyrics.contains(keyword)) {
     //   matchingIndices.add(i);
     // }

      if (title.contains(keyword)) {
        matchingIndices.add(i);
      }
    }

    //print(keyword);
    //print(matchingIndices);
    
    return matchingIndices;
  } catch (e) {
    return [];
  }
}
