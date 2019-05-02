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
