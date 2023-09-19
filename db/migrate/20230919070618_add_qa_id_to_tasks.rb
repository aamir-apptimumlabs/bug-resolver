class AddQaIdToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :qa_id, :integer
  end
end
