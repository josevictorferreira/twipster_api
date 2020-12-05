# frozen_string_literal: true

class Tipster
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :user, type: String

  validates :name, presence: true
  validates :user, presence: true, uniqueness: true
end
