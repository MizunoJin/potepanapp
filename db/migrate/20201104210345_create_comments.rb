class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table "comments", force: :cascade do |t|
    t.string "content", limit: 1000, default: "", null: false
    t.bigint "user_id"
    t.bigint "micropost_id"

      t.timestamps
    end
  end
end
