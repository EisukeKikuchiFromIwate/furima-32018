class ShippingAddress < ApplicationRecord
  has_one :user_order
end
