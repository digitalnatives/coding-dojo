class PagerComponent < Fron::Component
  tag 'ul.pager'

  PAGE_METHODS = %w(first prev next last)

  PAGE_METHODS.each do |page_method|
    component page_method, 'li' do
      component :a, "a[href=#].#{ page_method } #{ page_method.capitalize }"
    end
    on :click, ".#{page_method}", page_method

    define_method page_method do
      trigger page_method
    end
  end

  def initialize
    super
  end
end
