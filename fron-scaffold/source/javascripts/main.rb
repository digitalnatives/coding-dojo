require 'fron'
require 'forwardable'

require 'table_component'
require 'pager_component'

class MainComponent < Fron::Component
  extend Forwardable

  tag 'div'

  component :table, TableComponent
  component :pager, PagerComponent

  on 'nextPage', :next_page
  on 'prevPage', :prev_page

  def_delegators :table, :next_page, :prev_page

  def initialize
    super
  end
end

DOM::Document.body << MainComponent.new
