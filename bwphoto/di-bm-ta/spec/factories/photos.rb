# Read about factories at https://github.com/thoughtbot/factory_girl

# include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :photo do
    # user { get_user }
    camera ""
    title "This is an awesome photo"
    author ""
    taken_at Time.now

    trait :url do
      url 'http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg'
    end

    trait :photo do
      photo { Rack::Test::UploadedFile.new ::Rails.root.join('spec/fixtures/photo.jpg') }
    end
  end
end
