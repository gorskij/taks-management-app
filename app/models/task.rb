# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :reporter, class_name: 'User', optional: false
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :group, optional: false

  before_update :ensure_immutable_associations

  scope :from_group, ->(group) { where(group:) }

  private

  def ensure_immutable_associations
    if reporter_id_changed?
      errors.add(:reporter_id, "can't be changed")
      throw(:abort)
    end

    return unless group_id_changed?

    errors.add(:group_id, "can't be changed")
    throw(:abort)
  end
end
