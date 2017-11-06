class Message < ApplicationRecord
  validates_presence_of :title, :content, :created_by
end
