Feature: File lottery kata
  In order to have a command line shuffle application which works with xargs + mplayer
     As an average joe
    I want to have a functionality which can return random files from a folder and print them out


  Scenario: Reading file names from given directory
    Given I have a folder with five different files no directories
     When I execute my application
     Then I see the content of the folder in random order

  Scenario: Shuffle is working
    Given I have a folder with five different files no directories
     When I execute my application twice
     Then I see that the order of the result of the executions are different
