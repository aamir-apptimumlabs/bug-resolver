class ChangeTimelineToDateInTasks < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :timeline, 'timestamp without time zone USING timeline::timestamp without time zone'
  end
end
