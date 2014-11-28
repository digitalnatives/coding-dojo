class PagerComponent < Fron::Component
  tag 'div'

  PAGE_METHODS = %w(next prev first last)

  PAGE_METHODS.each do |page_method|
    component page_method, "a[href=#].#{ page_method } #{ page_method.capitalize }"
    on :click, ".#{page_method}", page_method

    define_method page_method do
      trigger page_method
    end
  end

  def initialize
    super
  end
end
