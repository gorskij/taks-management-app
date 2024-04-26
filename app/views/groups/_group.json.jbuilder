# frozen_string_literal: true

json.extract! group, :id, :owner_id, :name, :single_user, :created_at, :updated_at
json.url group_url(group, format: :json)
