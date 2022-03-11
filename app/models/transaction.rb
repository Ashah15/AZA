class Transaction < ApplicationRecord
  belongs_to :customer, class_name: 'Customer', foreign_key: 'customer_id'
  default_scope -> { order(created_at: :desc) }
  validates_presence_of :text

  validates_presence_of :customer_id
end
