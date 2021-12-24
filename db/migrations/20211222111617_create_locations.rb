Hanami::Model.migration do
  change do
    create_table :locations do
      primary_key :id

      column :path, String, null: false
      column :name, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
