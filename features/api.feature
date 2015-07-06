Feature: Api

  @wip
  Scenario: Sending a barcode
    When I post a barcode to the api
    Then a barcode is saved in the database
    And the barcode is resolved to a product
    Then the barcode is removed

  @wip
  Scenario: Sending a barcode that can not be resolved
    When I post a barcode to the api
    Then a barcode is saved in the database
    And the barcode is not resolved
    Then the barcode stays in the database
