@jenius
Feature: User can browse inside the webpage

  Background: User landed in the homepage
    Given user goto the website
    Then user change the language from "EN" to "IND"

  Scenario: User change menu to APP
    Given user on the jenius homepage
    And user click menu "App"
    Then user see "Permudah aktivitas perbankan dengan Jenius"

  Scenario: User change menu to CARDS
    Given user on the jenius homepage
    And user click menu "Cards"
    Then user see "Kartu-kartu Jenius"

  Scenario: User change menu to HIGHLIGHT
    Given user on the jenius homepage
    And user click menu "Highlight"
    Then user see "What's New"

  Scenario: User change menu to EVERYYAY
    Given user on the jenius homepage
    And user click menu "EveryYay"
    Then user see "Pilih Layanan"

  Scenario: User change menu to SUPPORT
    Given user on the jenius homepage
    And user click menu "Support"
    Then user see "Temukan seluruh informasi yang kamu butuhkan seputar Jenius"
  @home
  Scenario: User browse homepage
    Given user see "Simpler Life"
    When user change the cover animation to button 2
    Then user see "Aplikasi dan Kartu"
    And user click on "CARI TAU LEBIH LANJUT"
    Then user close the video
    When user click on "Ingin tau cara bikin akun jenius?"
    Then user see "Temukan Pengalaman Baru dengan Jenius"
  @wip
  Scenario: User scroll to the bottom of the homepage
    Given user on the jenius homepage
    Then user sroll to see "Saya ingin tahu"
