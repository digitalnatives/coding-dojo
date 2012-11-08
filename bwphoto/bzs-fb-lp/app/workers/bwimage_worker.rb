class BwimageWorker

	include Sidekiq::Worker


	def perform( bw )
		case bw.status
		when nil
			bw.download_image_from_url
			HardWorker.perform_async( bw )
		when "file_downloaded"
			bw.crop_and_grayscale
		end
	end

end