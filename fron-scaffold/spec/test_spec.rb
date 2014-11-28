require 'spec_helper'

describe 'Test' do
  it 'should add a message to the body' do
    DOM::Document.body.find('div').text.should eq 'Hello from Fron!'
  end
end
