class PagerComponent < Fron::Component
  tag 'div'

  component :previous,  "a[href=#].prev Prev"
  component :next, "a[href=#].next Next"

  on :click, '.prev', :prev_page
  on :click, '.next', :next_page

  def next_page
    trigger 'nextPage'
  end

  def prev_page
    trigger 'prevPage'
  end

  def initialize
    super
  end
end
