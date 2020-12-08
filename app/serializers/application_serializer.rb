# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at

  def id
    object.id.to_s
  end
end
