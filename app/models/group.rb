# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User', optional: false
  has_many :tasks, class_name: 'Task', dependent: :destroy
  has_and_belongs_to_many :users

  validates :owner, :name, presence: true
  validates :single_user, inclusion: { in: [true, false] }
end
