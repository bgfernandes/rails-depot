require 'rails_helper'

RSpec.describe '/products', type: :request do
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes_for(:product)
  end

  let(:invalid_attributes) do
    attributes_for(:product, price: 0)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Product.create! valid_attributes
      get products_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      product = Product.create! valid_attributes
      get product_url(product)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_product_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      product = Product.create! valid_attributes
      get edit_product_url(product)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Product' do
        expect do
          post products_url, params: { product: valid_attributes }
        end.to change(Product, :count).by(1)
      end

      it 'redirects to the created product' do
        post products_url, params: { product: valid_attributes }
        expect(response).to redirect_to(product_url(Product.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Product' do
        expect do
          post products_url, params: { product: invalid_attributes }
        end.to change(Product, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post products_url, params: { product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for(:another_product).stringify_keys
      end

      it 'updates the requested product' do
        product = Product.create! valid_attributes
        patch product_url(product), params: { product: new_attributes }
        product.reload

        expect(product.attributes).to include(new_attributes)
      end

      it 'redirects to the product' do
        product = Product.create! valid_attributes
        patch product_url(product), params: { product: new_attributes }
        product.reload
        expect(response).to redirect_to(product_url(product))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        product = Product.create! valid_attributes
        patch product_url(product), params: { product: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested product' do
      product = Product.create! valid_attributes
      expect do
        delete product_url(product)
      end.to change(Product, :count).by(-1)
    end

    it 'redirects to the products list' do
      product = Product.create! valid_attributes
      delete product_url(product)
      expect(response).to redirect_to(products_url)
    end

    context 'when requested product is in a cart' do
      let!(:product) { create(:line_item).product }

      it 'does not destroy the requested product' do
        expect do
          delete product_url(product)
        end.to change(Product, :count).by(0)
      end
    end
  end
end
