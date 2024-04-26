# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :status
      t.belongs_to :reporter, null: false, foreign_key: { to_table: :users }
      t.belongs_to :assignee, foreign_key: { to_table: :users }
      t.belongs_to :group, null: false, foreign_key: true
      t.datetime :due_date
      t.text :description

      t.timestamps
    end
  end
end
