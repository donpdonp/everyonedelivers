Feature: List a delivery job
  In order to add data to the site
  As a user
  I want to list a new delivery job

  Scenario: I want to list a flower delivery
    Given I have filled out the delivery form
    When I press submit
    Then a new delivery should exist
