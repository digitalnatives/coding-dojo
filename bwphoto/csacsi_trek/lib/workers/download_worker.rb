
# class DownloadWorker 
# 	include Sidekiq::Worker

# 	def perform
# 	Net::HTTP.start("somedomain.net/") do |http|
# 	    resp = http.get("/flv/sample/sample.flv")
# 	    open("sample.flv", "wb") do |file|
# 	        file.write(resp.body)
# 	    end
# 	end
# end