# Trading Model

This is a simple trading application where you can BUY, SELL coins.

# Request Format
* price   -> float value suported upto 8 decimal values 
* volume  -> float value suported upto 8 decimal values 
* side    -> Currently supported orders are BUY and SELL

# Response Format
  Fully Traded:
  `{
    "orderId": 67,
    "status": "done",
    "price": "124.0",
    "volume": "0.0",
    "tradedVolume": "12.6"
  }`

  Trade Pending:
  `{
    "orderId": 68,
    "status": "pending",
    "price": "124.0",
    "volume": "12.6",
    "tradedVolume": 0
  }`

# Data Structure
* Hash of orders, one per side
* Order match is a pair of rb tree maps, one for BUY and one for SELL

# Algorithm
* Insert order into appropriate order model
* Check order book for a match at the top
* If there is a match, remove top orders from both buy and sell (Update table) and print trade

# Followed Algorithm
* Red–black tree

# Example CURL:
  * BUY

    `curl --location --request POST 'localhost:3000/orders' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "price": 124.8767,
      "side": "BUY",
      "volume": 12.6 
  }'`
  * SELL

    `curl --location --request POST 'localhost:3000/orders' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "price": 124.8767,
      "side": "SELL",
      "volume": 12.6 
  }'`

  * Response

    `{
      "orderId": 75,
      "status": "done",
      "price": "124.8767",
      "volume": "0.0",
      "tradedVolume": "12.6"
    }`

  * Listing

    `curl --location --request GET 'localhost:3000/orders?side=BUY&page=1&pageSize=2&orderBy=asc&onlyCompletedOrders=true'`

  * Response:

    `[
        {
            "orderId": 53,
            "status": "done",
            "price": "124.0",
            "volume": "0.0",
            "tradedVolume": "0.0"
        },
        {
            "orderId": 54,
            "status": "done",
            "price": "124.0",
            "volume": "0.0",
            "tradedVolume": "12.6"
        }
    ]`

    `[
        {
            "orderId": 71,
            "status": "pending",
            "price": "124.8767",
            "volume": "12.6",
            "tradedVolume": 0
        },
        {
            "orderId": 69,
            "status": "pending",
            "price": "124.8767",
            "volume": "12.6",
            "tradedVolume": 0
        }
      ]`

Things you may want to cover:

* Ruby version: 

  * ruby '2.7.0'

* System dependencies

  * MYSQL
  * algorithms
  * kaminari
  * rspec

* Configuration

* Database creation

  * rails db:create

* Database initialization

  * rails db:migrate

* How to run the test suite
  * bundle exec rspec 

* ...
