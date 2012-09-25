# Read about factories at https://github.com/thoughtbot/factory_girl

# include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :photo do
    # user { get_user }
    camera ""
    title "This is an awesome photo"
    author ""
    taken_at Time.now
    # photo { Rack::Test::UploadedFile.new ::Rails.root.join('spec/fixtures/photo.mp4') }

    trait :url do
      # thumbnail { Rack::Test::UploadedFile.new ::Rails.root.join('spec/fixtures/bbb-300.jpg') }
    end

    trait :base64 do
    end
  end
end
