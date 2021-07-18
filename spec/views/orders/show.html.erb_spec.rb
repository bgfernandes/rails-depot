require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  let(:order) { create(:order) }

  before do
    @order = order
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{order.name}/)
    expect(rendered).to match(/#{order.address}/)
    expect(rendered).to match(/#{order.email}/)
    expect(rendered).to match(/#{order.pay_type}/)
  end
end
