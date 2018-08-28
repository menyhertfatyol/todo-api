class Todo < ApplicationRecord
  validates :name, :description, :status, :due_at, presence: true
end
