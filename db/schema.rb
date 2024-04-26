# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_407_223_506) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'groups', force: :cascade do |t|
    t.bigint 'owner_id', null: false
    t.string 'name', null: false
    t.boolean 'single_user', default: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['owner_id'], name: 'index_groups_on_owner_id'
  end

  create_table 'groups_users', id: false, force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'group_id', null: false
  end

  create_table 'tasks', force: :cascade do |t|
    t.string 'name'
    t.string 'status'
    t.bigint 'reporter_id', null: false
    t.bigint 'assignee_id'
    t.bigint 'group_id', null: false
    t.datetime 'due_date'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['assignee_id'], name: 'index_tasks_on_assignee_id'
    t.index ['group_id'], name: 'index_tasks_on_group_id'
    t.index ['reporter_id'], name: 'index_tasks_on_reporter_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'groups', 'users', column: 'owner_id'
  add_foreign_key 'tasks', 'groups'
  add_foreign_key 'tasks', 'users', column: 'assignee_id'
  add_foreign_key 'tasks', 'users', column: 'reporter_id'
end
