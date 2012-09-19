module BWPhoto
  class Rest < Sinatra::Base

    #configure do
      # set app specific settings
      # for example different view folders
    #end

    get '/' do
      "Hello from foo"
    end

    get '/:id' do
    end

    delete '/:id' do
    end

  end
end
