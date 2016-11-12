class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
    	t.string :name,              							null: false, default: ""
    	t.string :address
    	t.integer :creator_id,										null: false
      t.string :email,              						null: false, default: ""
      t.string :mobile,              						null: false, default: ""
      t.string :organization_type,            	null: false, default: ""
      t.string :pan_tin_number, 								null: false, default: ""
      t.boolean :is_store,											null: false
      t.boolean :is_eco_friendly,								null: false
      t.boolean :can_do_logistics,							null: false
      t.string :products_sold
      t.boolean :is_approved
    end

	  add_index :organizations, :creator_id
	  add_index :organizations, :email, unique: true
	  add_index :organizations, :mobile, unique: true
	  add_index :organizations, :organization_type
	  add_index :organizations, :is_store
	  add_index :organizations, :is_eco_friendly
	  add_index :organizations, :can_do_logistics
  end
end
