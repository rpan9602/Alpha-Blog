class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
  
  @@create_success_message = "Category was created successfully"
  def self.create_success_message
    @@create_success_message
  end
  
end