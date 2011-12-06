Feature: English numeral converter

  Background:
    Given I have a converter

  Scenario Outline: Convert numbers below 20
    When I convert <number> with my converter
    Then I should get <name>
   
    Examples:
      | number | name      |
      |  1     |"one"      |
      |  2     |"two"      |
      |  3     |"three"    |
      |  4     |"four"     |
      |  5     |"five"     |
      |  6     |"six"      |
      |  7     |"seven"    |
      |  8     |"eight"    |
      |  9     |"nine"     |
      | 10     |"ten"      |
      | 11     |"eleven"   |
      | 12     |"twelve"   |
      | 13     |"thirteen" |
      | 14     |"fourteen" |
      | 15     |"fifteen"  |
      | 16     |"sixteen"  |
      | 17     |"seventeen"|
      | 18     |"eighteen" |
      | 19     |"nineteen" |
      | 20     | "twenty"  |

  Scenario Outline: Convert numbers between 21 and 99
    When I convert <number> with my converter
    Then I should get <name>
    
    Examples:
    | number | name          |
    | 21     | "twenty-one"  |
    | 30     | "thirty"      |
    | 40     | "forty"       |
    | 50     | "fifty"       |
    | 60     | "sixty"       |
    | 70     | "seventy"     |
    | 80     | "eigthy"      |
    | 90     | "ninety"      |

  Scenario Outline: Convert numbers between 100 and 999
    When I convert <number> with my converter
    Then I should get <name>

    Examples:
      | number   | name                        |
      | 100      | "hundred"                   |
      | 200      | "two hundred"               |
      | 719      | "seven hundred and nineteen"|
      
  Scenario Outline: Convert numbers between 1000 and 1000000
    When I convert <number> with my converter
    Then I should get <name>

    Examples:
      | number    | name                                                           |
      |   1000    | "thousand"                                                     |
      |   1997    | "one thousand nine hundred and ninety-seven"                   |
      |  19197    | "nineteen thousand one hundred and ninety-seven"               |
      | 403197    | "four hundred and three thousand one hundred and ninety-seven" |
