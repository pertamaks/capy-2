Feature: User can see the movies trailer
  Background: User enter the gotix website
    Given User enter the Gotix website
    Then User reach the homepage
  @tix_trail
  Scenario: User see the avenger endgame trailer
    Given User on the homepage
    And User go to the movies menu
    When User see the avenger endgame poster
    Then User open the trailer