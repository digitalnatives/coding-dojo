require "rubygems"
require "bundler/setup"
Bundler.require(:default)

require './db'

class RackApp < Grape::API
  format :json

  resource :image do
    get ':id' do
      p = Picture.get(params[:id])
      if p.nil?
        {status:500, errors: ['Invalid picture id!']}
      else
        if p.status == 'processed'
	  p.to_json
        else
          {status:500, errors: ['Unprocessed picture!']}
        end
      end
    end

    get do
      Picture.all.to_json
    end

    post do
      img = Picture.new({
        id: params[:id],
        title: params[:title],
        camera: params[:camera],
        date: params[:date],
        author: params[:author],
        picture: params[:picture],
        filename: params[:filename]
      })
      if img.save
        Worker.perform_async img.id
        {status: 200, errors: []}
      else
        errors = []
        img.errors.map {|error| errors.push error[0]}
        {status: 500, errors: errors}
      end
    end
  end
end
