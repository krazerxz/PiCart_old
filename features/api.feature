Feature: Api

  @wip
  Scenario: Sending a barcode
    When I post a barcode to the api
    Then a barcode is saved in the database

