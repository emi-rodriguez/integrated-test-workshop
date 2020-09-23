# FILE: Candy_Order.feature
Feature: Processing request to order candy
  As a candy shop owner
  I want to accept and process candy orders
  In order to make my product available to my client

  Background:
    Given the Candy Shop API is up and running
    And the cache is available

  Scenario: Ordering as a first-time customer
    Given the request body to order candy at the candy shop
      |     |
    And the request address to order candy at the candy shop
      | uri |
      |     |
    And the customer is not in the cache
    When I request a candy order
    Then the request is granted
    And the total value of order is calculated
    And a 30% discount is applied
    And the customer is stored in the cache
    And the Candy Shop API replies a success message


  Scenario Outline: Ordering as a regular customer
    Given the request body to order candy at the candy shop
      |     |
    And the request address to order candy at the candy shop
      | uri |
      |     |
    And the customer is in the cache
      |     |
    When I request a candy order
    Then the request is granted
    And the total value of order is calculated
    And no discount is applied
    And the customer data is updated in the cache
    And the Candy Shop API replies a success message


  Scenario Outline: Ordering as a frequent customer
    Given the request body to order candy at the candy shop
      |     |
    And the request address to order candy at the candy shop
      | uri |
      |     |
    And the customer is in the cache
      |     |
    When I request a candy order
    Then the request is granted
    And the total value of order is calculated
    And a 10% discount is applied
    And the customer data is updated in the cache
    And the Candy Shop API replies a success message


  Scenario Outline: Ordering with an invalid request
    Given the request body to order candy at the candy shop
      | field   |
      | <field> |
    And the request address to order candy at the candy shop
      | uri |
      |     |
    When I request a candy order
    Then the request is denied
    And the total value of order is not calculated
    And the customer data is not updated in the cache
    And the Candy Shop API replies a failure message
    Examples:
      | field |
      |       |