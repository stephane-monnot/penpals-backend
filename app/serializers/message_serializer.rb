class MessageSerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :title, :content, :created_at, :updated_at
  # model association
  belongs_to :creator, class_name: 'User', foreign_key: :created_by
end
