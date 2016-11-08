require 'test_helper'

class SuppliersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supplier = suppliers(:one)
  end

  test "should get index" do
    get suppliers_url
    assert_response :success
  end

  test "should get new" do
    get new_supplier_url
    assert_response :success
  end

  test "should create supplier" do
    assert_difference('Supplier.count') do
      post suppliers_url, params: { supplier: { address_line1: @supplier.address_line1, address_line2: @supplier.address_line2, authorised_responder: @supplier.authorised_responder, city: @supplier.city, country: @supplier.country, email: @supplier.email, end_date: @supplier.end_date, first_name: @supplier.first_name, industry: @supplier.industry, last_name: @supplier.last_name, mobile_number: @supplier.mobile_number, notes: @supplier.notes, start_date: @supplier.start_date, subscription: @supplier.subscription, supplier_name: @supplier.supplier_name, supplier_vat_number: @supplier.supplier_vat_number, telephone_number: @supplier.telephone_number, title: @supplier.title, town: @supplier.town } }
    end

    assert_redirected_to supplier_url(Supplier.last)
  end

  test "should show supplier" do
    get supplier_url(@supplier)
    assert_response :success
  end

  test "should get edit" do
    get edit_supplier_url(@supplier)
    assert_response :success
  end

  test "should update supplier" do
    patch supplier_url(@supplier), params: { supplier: { address_line1: @supplier.address_line1, address_line2: @supplier.address_line2, authorised_responder: @supplier.authorised_responder, city: @supplier.city, country: @supplier.country, email: @supplier.email, end_date: @supplier.end_date, first_name: @supplier.first_name, industry: @supplier.industry, last_name: @supplier.last_name, mobile_number: @supplier.mobile_number, notes: @supplier.notes, start_date: @supplier.start_date, subscription: @supplier.subscription, supplier_name: @supplier.supplier_name, supplier_vat_number: @supplier.supplier_vat_number, telephone_number: @supplier.telephone_number, title: @supplier.title, town: @supplier.town } }
    assert_redirected_to supplier_url(@supplier)
  end

  test "should destroy supplier" do
    assert_difference('Supplier.count', -1) do
      delete supplier_url(@supplier)
    end

    assert_redirected_to suppliers_url
  end
end
