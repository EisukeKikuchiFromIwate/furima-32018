class ShippingAddress < ApplicationRecord
  belongs_to :user_order
end
