# FILE: Order_Payment.feature
Feature: Processing request to order candy
  As a candy shop owner
  I want to accept and process candy orders
  In order to make my product available to my client

  Background:
    Given the Candy Shop API is up and running
    And the cache is available
    And the Kind Bank API is available

  Scenario: Paying an order with sufficient funds
    Given the request body to pay an order at the candy shop
      |     |
    And the request address to pay an order at the candy shop
      | uri |
      |     |
    And the customer data is not in the cache
    And the requester has sufficient funds
    When I pay a candy order
    Then the request is granted
    And the Candy Shop API replies a success message


  Scenario Outline: Paying and order with in-store credit
    Given the request body to order candy at the candy shop
      |     |
    And the request address to order candy at the candy shop
      | uri |
      |     |
    And the customer is in the cache
      |     |
    And the requester has insufficient funds
    When I pay a candy order
    Then the request is granted
    And the customer in-store credit is updated in the cache
    And the Candy Shop API replies a success message


  Scenario Outline: Rejecting an order with insufficient funds
    Given the request body to pay an order at the candy shop
      |     |
    And the request address to pay an order at the candy shop
      | uri |
      |     |
    And the customer is not in the cache
    And the requester has insufficient funds
    When I pay a candy order
    Then the request is denied
    And the Candy Shop API replies a failure message


  Scenario Outline: Paying wiht an invalid request
    Given the request body to pay an order at the candy shop
      | field   |
      | <field> |
    And the request address to order candy at the candy shop
      | uri |
      |     |
    And the request address to pay an order at the candy shop
      | uri |
      |     |
    When I pay a candy order
    Then the request is denied
    And the Candy Shop API replies a failure message
    Examples:
      | field |
      |       |