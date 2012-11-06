class FayeClient
  def self.photo_added(photo)
    broadcast("/photos/updated", photo.as_json)
  end

  def self.broadcast(channel, data)
    if EM.reactor_running?
      Rails.logger.debug "EM reactor running, broadcasting"
      $faye_client.publish channel, data
    end
  end
end
