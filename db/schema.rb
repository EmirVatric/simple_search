# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_604_150_002) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pg_trgm'
  enable_extension 'plpgsql'

  create_table 'articles', force: :cascade do |t|
    t.string 'title'
    t.text 'content'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['content'], name: 'index_articles_on_content'
    t.index ['title'], name: 'index_articles_on_title'
  end

  create_table 'queries', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'act_identifier'
    t.string 'query'
    t.boolean 'found'
    t.integer 'counter', default: 1
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['act_identifier'], name: 'index_queries_on_act_identifier'
    t.index ['query'], name: 'index_queries_on_query'
    t.index ['user_id'], name: 'index_queries_on_user_id'
  end
end
