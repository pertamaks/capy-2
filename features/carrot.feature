@crrt
Feature: User can login into the carrot website

  Background: User go in the carrot
    Given user enter the carrot web
    When user enter the username and password
    Then user can successfully login

  @crrt_notif
  Scenario: user open the notification menu
    Given user open the notification button
    And user select all notification
    Then user will enter the all notification menu

  @crrt_detail
  Scenario: User browse the carrot detail
    Given user on the homepage
    And user enter his carrot detail
    Then user will see the carrot history
    When user change to shared carrot detail
    Then User will see the shared carrot history
    When User change to bazaar detail
    Then user will see the bazaar carrot history

  @crrt_logout
  Scenario: User logout from the carrot website
    Given user open the carrot menu
    Then user logout from the carrot page
