class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :name
      t.string :description
      t.string :status
      t.timestamp :due_at

      t.timestamps
    end
  end
end
