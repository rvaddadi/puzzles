package com.leafac.orderedwords;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class OrderedWordsTest {

  private OrderedWords orderedWords;

  @Before
  public void setUp() {
    orderedWords = new OrderedWords();
  }

  @Test
  public void testEmptySentence() {
    assertEquals("", orderedWords.orderedWords("", new String[] {"Red", "are", "Blue"}));
  }

  @Test
  public void testEmptyWordsArray() {
    assertEquals("",
        orderedWords.orderedWords("Roses are red and Oceans are Blue", new String[] {}));
  }

  @Test
  public void testOneSimpleWord() {
    assertEquals("Roses", orderedWords.orderedWords("Roses", new String[] {"Roses"}));
  }

  @Test
  public void testTwoWordsInSentence() {
    assertEquals("Roses", orderedWords.orderedWords("Roses are", new String[] {"Roses"}));
  }

  @Test
  public void testTwoWordsInToBeFound() {
    assertEquals("Roses are", orderedWords.orderedWords("Roses are", new String[] {"Roses", "are"}));
  }

  @Test
  public void testRepetition() {
    assertEquals("are", orderedWords.orderedWords("are are", new String[] {"are"}));
  }

  @Test
  public void testWholeSentence() {
    assertEquals(
        "are Red Blue",
        orderedWords.orderedWords("Roses are red and Oceans are Blue", new String[] {"Red", "are",
            "Blue"}));
  }

  @Test
  public void testTokenizeEmptySentence() {
    assertArrayEquals(new String[] {}, orderedWords.tokenizeSentence(""));
  }

  @Test
  public void testTokenizeSpacesSentence() {
    assertArrayEquals(new String[] {}, orderedWords.tokenizeSentence("           "));
  }

  @Test
  public void testTokenizeOneWordSentence() {
    assertArrayEquals(new String[] {"Roses"}, orderedWords.tokenizeSentence("Roses"));
  }

  @Test
  public void testTokenizeMultipleWordSentence() {
    assertArrayEquals(new String[] {"Roses", "are"}, orderedWords.tokenizeSentence("Roses are"));
  }

  @Test
  public void testTokenizeMultipleWordWithMultipleSpacesSentence() {
    assertArrayEquals(new String[] {"Roses", "are"}, orderedWords.tokenizeSentence("Roses     are"));
  }

  @Test
  public void testTokenizeTrailingSpacesSentence() {
    assertArrayEquals(new String[] {"Roses", "are"}, orderedWords.tokenizeSentence("  Roses are  "));
  }

  @Test
  public void testTokenizeSentenceWithPonctuation() {
    assertArrayEquals(new String[] {"Roses", "are"}, orderedWords.tokenizeSentence("Roses, are"));
  }

}
