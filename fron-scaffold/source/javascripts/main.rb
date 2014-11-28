require 'fron'

# My Component
class MyComponent < Fron::Component
  tag 'div'

  def initialize
    super
    self.text = 'Hello from Fron!'
  end
end

DOM::Document.body << MyComponent.new
