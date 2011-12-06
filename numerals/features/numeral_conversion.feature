Feature: English numeral converter

  Background:
    Given I have a converter

  Scenario Outline: convert cardinal numbers to words
    When I convert <number> with my converter
    Then I should get <word>
   
    Examples:
      | number | word      |
      | 1      |"one"      |
      | 2      |"two"      |
      | 3      |"three"    |
      | 4      |"four"     |
      | 5      |"five"     |
      | 6      |"six"      |
      | 7      |"seven"    |
      | 8      |"eight"    |
      | 9      |"nine"     |
      |10      |"ten"      |
      |11      |"eleven"   |
      |12      |"twelve"   |
      |13      |"thirteen" |
      |14      |"fourteen" |
      |15      |"fifteen"  |
      |16      |"sixteen"  |
      |17      |"seventeen"|
      |18      |"eighteen" |
      |19      |"nineteen" |
      |20      | "twenty"  |
      |30      | "thirty"  |
      |40      | "forty"   |
      |50      | "fifty"   |
      |60      | "sixty"   |
      |70      | "seventy" |
      |80      | "eigthy"  |
      |90      | "ninety"  |

  Scenario: Convert a number with hyphen to a word
    When I convert 21 with my converter
    Then I should get "twenty-one"