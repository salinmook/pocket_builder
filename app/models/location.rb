class Location < ApplicationRecord
    belongs_to :store

    validates :address, presence: true
end