class Message < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :created_by

  validates_presence_of :title, :content, :created_by
end
