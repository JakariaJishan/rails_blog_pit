class GenerateThumbnailJob < ApplicationJob
  queue_as :default

  def perform(reel)
    video_path = ActiveStorage::Blob.service.send(:path_for, reel.video.blob.key)
    thumbnail_path = "#{Rails.root}/tmp/thumbnails/#{reel.id}.jpg"

    movie = FFMPEG::Movie.new(video_path)
    movie.screenshot(thumbnail_path, seek_time: 5)

    reel.thumbnail.attach(io: File.open(thumbnail_path), filename: "#{reel.id}.jpg")
  end
end
