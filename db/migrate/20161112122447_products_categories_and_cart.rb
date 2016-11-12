class ProductsCategoriesAndCart < ActiveRecord::Migration
  def change
    create_table "products", :force => true do |t|
      t.string   "name", null: false
      t.text   "description", null: false
      t.integer   "price", null: false
      t.string   "approval_status", null: false
      t.integer   "creator_id", null: false
      t.timestamps
    end

    create_table "categories", :force => true do |t|
      t.string   "name", null: false
      t.timestamps
    end

    create_table "product_categories", :force => true do |t|
      t.integer   "product_id", null: false
      t.integer   "category_id", null: false
      t.timestamps
    end

    add_index "product_categories", ["product_id", "category_id"], unique: true, name: 'product_category_index'

    create_table "orders", :force => true do |t|
      t.integer   "product_id", null: false
      t.integer   "user_id", null: false
      t.integer   "price", null: false
      t.boolean   "is_completed", null: false
      t.timestamps
    end
  end
end