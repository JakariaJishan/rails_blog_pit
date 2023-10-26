class UpdateAttachmentName < ActiveRecord::Migration[7.0]
  def up
    ActiveStorage::Attachment.where(name: "post_image", record_type: "Post")
                             .update_all(name: "post_images")
  end

  def down
    ActiveStorage::Attachment.where(name: "post_images", record_type: "Post")
                             .update_all(name: "post_image")
  end
end
