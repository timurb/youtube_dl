Hanami::Model.migration do
  change do
    create_table :video_infos do
      primary_key :id

      column :youtube_id, String, null: false
      foreign_key :video_id, :videos, null: false, on_delete: :cascade

      column :title, String
      column :thumbnail, String
      column :description, String
      column :duration, Integer
      column :filename, String

      column :uploader, String
      column :uploader_url, String
      column :channel, String
      column :channel_url, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
