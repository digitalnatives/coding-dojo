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

    trait :base64 do
      base64 "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3AkRDwwzVKRNWAAAAB1pVFh0Q29tbWVudAAAAAAAQ3JlYXRlZCB3aXRoIEdJTVBkLmUHAAAADUlEQVQI12NgYGBgAAAABQABXvMqOgAAAABJRU5ErkJggg=="
    end

    trait :photo do
      photo { Rack::Test::UploadedFile.new ::Rails.root.join('spec/fixtures/photo.jpg') }
    end
  end
end
