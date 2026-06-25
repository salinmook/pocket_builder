class Cart < ApplicationRecord
    belongs_to :store
    has_many :cart_items, dependent: :destroy
end
