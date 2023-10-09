class AddDevelopersToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :assigned_to_developer, :integer, array: true, default: []  
  end
end
