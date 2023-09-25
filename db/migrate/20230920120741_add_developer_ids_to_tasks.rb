class AddDeveloperIdsToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :developer_id, :integer
  end
end
