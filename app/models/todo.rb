class Todo < ApplicationRecord
  validates_presence_of :name, :description, :status, :due_at
end
