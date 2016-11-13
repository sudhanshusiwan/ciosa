class AddAttributesAndIsEcoFriendlyColumnsToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.jsonb :old_attributes, null: false, default: '{}'
      t.boolean :is_eco_friendly, null: false, default: true
    end
  end
end