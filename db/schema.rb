# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121223195113) do

  create_table "artifacts", :force => true do |t|
    t.text     "content"
    t.integer  "job_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artifacts", ["type", "job_id"], :name => "index_artifacts_on_type_and_job_id"

  create_table "broadcasts", :force => true do |t|
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.string   "kind"
    t.string   "message"
    t.boolean  "expired"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "build_compacts", :force => true do |t|
    t.integer  "result"
    t.datetime "finished_at"
    t.integer  "number"
    t.text     "config"
    t.integer  "repository_compact_id"
  end

  create_table "builds", :force => true do |t|
    t.integer  "repository_id"
    t.string   "number"
    t.integer  "status"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string   "agent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "config"
    t.integer  "commit_id"
    t.integer  "request_id"
    t.string   "state"
    t.string   "language"
    t.datetime "archived_at"
    t.integer  "duration"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "result"
    t.integer  "previous_result"
    t.string   "event_type"
  end

  add_index "builds", ["finished_at"], :name => "index_builds_on_finished_at"
  add_index "builds", ["repository_id", "event_type"], :name => "index_builds_on_repository_id_and_event_type"
  add_index "builds", ["repository_id", "state"], :name => "index_builds_on_repository_id_and_state"

  create_table "commits", :force => true do |t|
    t.integer  "repository_id"
    t.string   "commit"
    t.string   "ref"
    t.string   "branch"
    t.text     "message"
    t.string   "compare_url"
    t.datetime "committed_at"
    t.string   "committer_name"
    t.string   "committer_email"
    t.string   "author_name"
    t.string   "author_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commits", ["branch"], :name => "index_commits_on_branch"
  add_index "commits", ["commit"], :name => "index_commits_on_commit"

  create_table "dimensions", :force => true do |t|
    t.integer  "job_info_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "repository_id"
    t.string   "event"
    t.text     "data"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "job_compacts", :force => true do |t|
    t.string   "language"
    t.string   "version"
    t.boolean  "allow_failure"
    t.integer  "result"
    t.datetime "finished_at"
    t.integer  "build_compact_id"
  end

  create_table "job_infos", :force => true do |t|
    t.integer  "repository_id"
    t.integer  "job_id"
    t.string   "language"
    t.string   "result"
    t.string   "integer"
    t.string   "dimension_keys"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "jobs", :force => true do |t|
    t.integer  "repository_id"
    t.integer  "commit_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "queue"
    t.string   "type"
    t.string   "state"
    t.string   "number"
    t.text     "config"
    t.integer  "status"
    t.string   "job_id"
    t.string   "worker"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tags"
    t.integer  "retries",       :default => 0
    t.boolean  "allow_failure", :default => false
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "result"
    t.datetime "queued_at"
  end

  add_index "jobs", ["created_at"], :name => "index_jobs_on_created_at"
  add_index "jobs", ["queue", "state"], :name => "index_jobs_on_queue_and_state"
  add_index "jobs", ["repository_id"], :name => "index_jobs_on_repository_id"
  add_index "jobs", ["state", "owner_id", "owner_type"], :name => "index_jobs_on_state_owner_type_owner_id"
  add_index "jobs", ["type", "source_id", "source_type"], :name => "index_jobs_on_type_and_owner_id_and_owner_type"

  create_table "memberships", :force => true do |t|
    t.integer "organization_id"
    t.integer "user_id"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.integer  "github_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "permissions", :force => true do |t|
    t.integer "user_id"
    t.integer "repository_id"
    t.boolean "admin",         :default => false
    t.boolean "push",          :default => false
    t.boolean "pull",          :default => false
  end

  add_index "permissions", ["repository_id"], :name => "index_permissions_on_repository_id"
  add_index "permissions", ["user_id"], :name => "index_permissions_on_user_id"

  create_table "repositories", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "last_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_build_id"
    t.string   "last_build_number"
    t.integer  "last_build_status"
    t.datetime "last_build_started_at"
    t.datetime "last_build_finished_at"
    t.string   "owner_name"
    t.text     "owner_email"
    t.boolean  "active"
    t.text     "description"
    t.string   "last_build_language"
    t.integer  "last_build_duration"
    t.boolean  "private",                :default => false
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "last_build_result"
  end

  add_index "repositories", ["last_build_started_at"], :name => "index_repositories_on_last_build_started_at"
  add_index "repositories", ["owner_name", "name"], :name => "index_repositories_on_owner_name_and_name"

  create_table "repository_compacts", :force => true do |t|
    t.string "name"
    t.text   "description"
    t.string "url"
    t.string "owner_name"
  end

  create_table "requests", :force => true do |t|
    t.integer  "repository_id"
    t.integer  "commit_id"
    t.string   "state"
    t.string   "source"
    t.text     "payload"
    t.string   "token"
    t.text     "config"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "event_type"
    t.string   "comments_url"
    t.string   "base_commit"
    t.string   "head_commit"
    t.string   "result"
    t.string   "message"
  end

  add_index "requests", ["head_commit"], :name => "index_requests_on_head_commit"

  create_table "ssl_keys", :force => true do |t|
    t.integer  "repository_id"
    t.text     "public_key"
    t.text     "private_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ssl_keys", ["repository_id"], :name => "index_ssl_key_on_repository_id"

  create_table "tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "urls", :force => true do |t|
    t.string   "url"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",           :default => false
    t.integer  "github_id"
    t.string   "github_oauth_token"
    t.string   "gravatar_id"
    t.string   "locale"
    t.boolean  "is_syncing"
    t.datetime "synced_at"
  end

  add_index "users", ["github_id"], :name => "index_users_on_github_id"
  add_index "users", ["github_oauth_token"], :name => "index_users_on_github_oauth_token"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "workers", :force => true do |t|
    t.string   "name"
    t.string   "host"
    t.string   "state"
    t.datetime "last_seen_at"
    t.text     "payload"
    t.text     "last_error"
    t.string   "queue"
  end

  add_index "workers", ["name", "host"], :name => "index_workers_on_name_and_host"

end
