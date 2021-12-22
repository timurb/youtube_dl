Hanami::Model.migration do
  change do
    create_table :videos do
      primary_key :id

      column :url, String, null: false
      column :status, String, null: false

      foreign_key :location_id, :locations
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
