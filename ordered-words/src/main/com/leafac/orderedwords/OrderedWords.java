package com.leafac.orderedwords;


import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class OrderedWords {

  public String orderedWords(String sentence, String[] words) {
    StringBuilder orderedWords = new StringBuilder("");

    if (!sentence.isEmpty() && words.length > 0) {
      List<String> orderedWordsList = new ArrayList<>();
      Map<String, Integer> searchableWords = new HashMap<>();
      for (int i = 0; i < words.length; i++) {
        searchableWords.put(words[i].toLowerCase(), i);
      }
      for (String sentenceWord : tokenizeSentence(sentence.toLowerCase())) {
        Integer foundIndex = searchableWords.get(sentenceWord);
        if (foundIndex != null) {
          String orderedWord = words[foundIndex];
          if (!orderedWordsList.contains(orderedWord)) {
            orderedWordsList.add(orderedWord);
          }
        }
      }
      for (String orderedWord : orderedWordsList) {
        if (orderedWords.length() != 0) {
          orderedWords.append(" ");
        }
        orderedWords.append(orderedWord);
      }
    }

    return orderedWords.toString();
  }

  public String[] tokenizeSentence(String sentence) {
    String trimmedSentence = sentence.trim();
    return trimmedSentence.equals("") ? new String[0] : trimmedSentence.trim().split("[\\s.,:_-]+");
  }
}
