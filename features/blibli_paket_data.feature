@blibli
Feature: This feature make user can buy paket data from the blibli homepage

  Background: User enter the blibli webpage
    Given User enter the blibli
    Then user reach blibli homepage

  @blibli_pktdata
  Scenario: User open the paket data menu and buy paket data
    Given User go to paket data page
    And User enter the phone number
    And User select the paket data
    And User click beli sekarang
    Then Quick register form will appear

  @blibli_pswt
  Scenario: User going to buy the aiplane ticket on blibli
    Given User go to the tiket pesawat page
    And User select the destination
    And User select the trip type
    And User select the trip date
    And User select the flight detail
    When User click the cari tiket button
    Then Ticket page will be opened
