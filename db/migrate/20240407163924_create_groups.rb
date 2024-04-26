# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.belongs_to :owner, null: false, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.boolean :single_user, default: true
      t.timestamps
    end
  end
end
