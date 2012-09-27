class DownloadWorker
  include Sidekiq::Worker

  def perform( remote_url, tmp_path, destination )
    if system( 'curl', '-o', tmp_path, remote_url )
      ConvertWorker.perform_async( tmp_path, destination )
    end
  end
end
