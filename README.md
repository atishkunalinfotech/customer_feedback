# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Steps

For creating supplier

rails g scaffold supplier email:string first_name:string last_name:string address_line1:string address_line2:string town:string city:string country:string title:string telephone_number:string mobile_number:string subscription:string start_date:date end_date:date supplier_name:string supplier_vat_number:string industry:string authorised_responder:string notes:text
