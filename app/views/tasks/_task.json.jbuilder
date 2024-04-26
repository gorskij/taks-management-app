# frozen_string_literal: true

json.extract! task, :id, :name, :status, :user_id, :due_date, :description, :created_at, :updated_at
json.url task_url(task, format: :json)
