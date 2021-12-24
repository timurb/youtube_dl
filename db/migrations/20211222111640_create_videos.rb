Hanami::Model.migration do
  change do
    create_table :videos do
      primary_key :id

      column :url, String, null: false
      column :state, Integer, null: false
      column :filename, String

      foreign_key :location_id, :locations, null: false
      foreign_key :video_info_id, :video_infos, on_delete: :cascade

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
