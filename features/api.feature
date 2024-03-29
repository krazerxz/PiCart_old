Feature: Api

  @wip
  Scenario: Sending a barcode
    When I post a barcode to the product api
    Then a product is saved in the database

  @wip
  Scenario: Sending a barcode that can not be resolved
    When I post a barcode to the api
    Then a barcode is saved in the database
    And the barcode is not resolved
    Then the barcode stays in the database
