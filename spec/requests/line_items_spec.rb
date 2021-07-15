require 'rails_helper'

RSpec.describe "/line_items", type: :request do

  let(:valid_attributes) {
    attributes_for(:line_item, cart_id: create(:cart).id, product_id: create(:product).id)
  }

  let(:invalid_attributes) {
    attributes_for(:line_item, cart_id: nil, product_id: nil)
  }

  describe "GET /index" do
    it "renders a successful response" do
      LineItem.create! valid_attributes
      get line_items_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      line_item = LineItem.create! valid_attributes
      get line_item_url(line_item)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_line_item_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      line_item = LineItem.create! valid_attributes
      get edit_line_item_url(line_item)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    let(:valid_creation_params) {
      { product_id: create(:product).id }
    }

    let(:invalid_creation_params) {
      { product_id: nil }
    }

    context "with valid parameters" do
      context "when adding a product that is not in the cart" do
        it "creates a new LineItem" do
          expect {
            post line_items_url, params: valid_creation_params
          }.to change(LineItem, :count).by(1)
        end

        it "redirects to the cart containing the line item" do
          post line_items_url, params: valid_creation_params
          expect(response).to redirect_to(cart_url(LineItem.last.cart))
        end
      end

      context "when adding a product that is already in the cart" do
        before :each do
          post line_items_url, params: valid_creation_params
        end

        it "does not create a new LineItem" do
          expect {
            post line_items_url, params: valid_creation_params
          }.to change(LineItem, :count).by(0)
        end

        it "increases the line_item quantity" do
          post line_items_url, params: valid_creation_params
          expect(LineItem.last.quantity).to be 2
        end
      end
    end

    context "with invalid parameters" do
      it "does not create a new LineItem" do
        expect {
          post line_items_url, params: invalid_creation_params
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      # it "renders a successful response (i.e. to display the 'new' template)" do
      #   post line_items_url, params: invalid_creation_params
      #   expect(response).to be_successful
      # end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        attributes_for(
          :line_item,
          cart_id: create(:cart).id,
          product_id: create(:product).id
          ).except(:cart_id).stringify_keys
      }

      it "updates the requested line_item" do
        line_item = LineItem.create! valid_attributes
        patch line_item_url(line_item), params: { line_item: new_attributes }
        line_item.reload
        expect(line_item.attributes).to include(new_attributes)
      end

      it "redirects to the line_item" do
        line_item = LineItem.create! valid_attributes
        patch line_item_url(line_item), params: { line_item: new_attributes }
        line_item.reload
        expect(response).to redirect_to(line_item_url(line_item))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        line_item = LineItem.create! valid_attributes
        patch line_item_url(line_item), params: { line_item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested line_item" do
      line_item = LineItem.create! valid_attributes
      expect {
        delete line_item_url(line_item)
      }.to change(LineItem, :count).by(-1)
    end

    it "redirects to the line_items list" do
      line_item = LineItem.create! valid_attributes
      delete line_item_url(line_item)
      expect(response).to redirect_to(line_items_url)
    end
  end
end
