require 'fron'
require 'forwardable'

require 'table_component'
require 'pager_component'

class MainComponent < Fron::Component
  extend Forwardable

  tag 'div'

  component :table, TableComponent
  component :pager, PagerComponent

  PagerComponent::PAGE_METHODS.each do |page_method|
    on page_method, page_method
  end

  def_delegators :table, *PagerComponent::PAGE_METHODS

  def initialize
    super
  end
end

DOM::Document.body << MainComponent.new
