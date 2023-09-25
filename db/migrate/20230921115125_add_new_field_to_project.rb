class AddNewFieldToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :assigned_to_qa, :integer, array: true, default: []
  end
end
