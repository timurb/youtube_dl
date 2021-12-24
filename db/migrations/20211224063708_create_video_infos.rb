Hanami::Model.migration do
  change do
    create_table :video_infos do
      primary_key :id

      column :youtube_id, String, null:false

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
