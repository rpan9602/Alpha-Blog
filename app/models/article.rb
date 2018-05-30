# class Article < ActiveRecord::Base # for Rails 4
class Article < ApplicationRecord # for Rails 5
  validates :title, presence: true,	length: {minimum: 3, maximum: 50}
  validates :description, presence: true,	length: {minimum: 10, maximum: 300}
end