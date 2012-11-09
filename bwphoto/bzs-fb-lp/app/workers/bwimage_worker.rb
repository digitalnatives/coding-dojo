class BwimageWorker

	include Sidekiq::Worker


	def perform( bw_id )
		bw = Bwimage.find( bw_id )
		logger.debug bw.inspect
		case bw.status
		when nil
			bw.download_image_from_url
			BwimageWorker.perform_async( bw_id )
		when "file_downloaded"
			bw.crop_and_grayscale
		end
	end

end