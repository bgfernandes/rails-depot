# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/carts', type: :request do
  # Cart. As you add validations to Cart, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes_for(:cart)
  end

  let(:invalid_attributes) do
    skip("Cart doesn't have any attributes so far, so it's not possible to have an invalid one.")
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Cart.create! valid_attributes
      get carts_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      cart = Cart.create! valid_attributes
      get cart_url(cart)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_cart_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      cart = Cart.create! valid_attributes
      get edit_cart_url(cart)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Cart' do
        expect do
          post carts_url, params: { cart: valid_attributes }
        end.to change(Cart, :count).by(1)
      end

      it 'redirects to the created cart' do
        post carts_url, params: { cart: valid_attributes }
        expect(response).to redirect_to(cart_url(Cart.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Cart' do
        expect do
          post carts_url, params: { cart: invalid_attributes }
        end.to change(Cart, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post carts_url, params: { cart: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {}
      end

      it 'updates the requested cart' do
        cart = Cart.create! valid_attributes
        patch cart_url(cart), params: { cart: new_attributes }
        cart.reload
        skip("Cart doesn't have any attributes so far, so there is change to assert.")
      end

      it 'redirects to the cart' do
        cart = Cart.create! valid_attributes
        patch cart_url(cart), params: { cart: new_attributes }
        cart.reload
        expect(response).to redirect_to(cart_url(cart))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        cart = Cart.create! valid_attributes
        patch cart_url(cart), params: { cart: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    context "with target cart in the user's session" do
      let!(:cart) do
        post line_items_url, params: { product_id: create(:product).id }
        Cart.find(session[:cart_id])
      end

      it 'destroys the requested cart' do
        expect do
          delete cart_url(cart)
        end.to change(Cart, :count).by(-1)
      end

      it 'redirects to the carts list' do
        delete cart_url(cart)
        expect(response).to redirect_to(store_index_url)
      end

      context 'when calling with ajad' do
        it 'destroys the requested cart' do
          expect do
            delete cart_url(cart), xhr: true
          end.to change(Cart, :count).by(-1)
        end

        it 'removes the cart from the UI' do
          delete cart_url(cart), xhr: true
          expect(response.body).to match(/cart.innerHTML = ''/)
        end
      end
    end

    context "with a cart that is not in the user's session" do
      it 'fails to destroys the requested cart' do
        cart = Cart.create! valid_attributes
        expect do
          delete cart_url(cart)
        end.to change(Cart, :count).by(0)
      end

      it 'redirects to the carts list' do
        cart = Cart.create! valid_attributes
        delete cart_url(cart)
        expect(response).to redirect_to(store_index_url)
      end
    end
  end
end
