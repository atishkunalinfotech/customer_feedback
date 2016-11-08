# README

Things you may want to cover:

* Ruby version - 2.3.0
* Rails version 5.0.0


Steps

For creating supplier

rails g scaffold supplier email:string first_name:string last_name:string address_line1:string address_line2:string town:string city:string country:string title:string telephone_number:string mobile_number:string subscription:string start_date:date end_date:date supplier_name:string supplier_vat_number:string industry:string authorised_responder:string notes:text


rails g scaffold industry title:string user_id:integer


rails g scaffold location title:string user_id:integer town_id:integer

rails g scaffold town title:string user_id:integer

rails g scaffold company title:string user_id:integer industry_id:integer is_registered:boolean

rake db:migrate