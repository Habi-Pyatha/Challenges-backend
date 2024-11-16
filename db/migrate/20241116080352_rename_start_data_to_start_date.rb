class RenameStartDataToStartDate < ActiveRecord::Migration[7.2]
  def change
    rename_column :challenges, :start_data, :start_date
    rename_column :challenges, :end_data, :end_date
  end
end
