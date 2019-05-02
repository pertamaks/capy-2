Feature: This feature will show user a JS pop up
@js1
  Scenario: User get JS pop up then accept
    Given user visit the webpage
    And user go to JS pop up page
    When user select and accept the pop up
    Then the result will accept the pop up
@js2
Scenario: User get the 2nd JS then dismissed
  Given user visit the webpage
  And user go to JS pop up page
  When user select the second JS and dismissed the pop up
  Then ther result will cancel the pop up
@js3
Scenario: User get the third JS and send aiueo
  Given user visit the webpage
  And user go to JS pop up page
  When user select the third JS and send aiueo
  Then ther result will show aiueo
