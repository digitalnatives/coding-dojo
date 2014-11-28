require 'user_item'

class TableComponent < Fron::Component
  tag 'table'

  attr_accessor :page
  attr_accessor :per_page
  attr_accessor :users

  def initialize
    super
    get_users do |users|
      @page = 1
      @per_page = 10
      @users = users
      render_page(@page)
    end
  end

  def render_page(page)
    empty
    @users[(page-1)*@per_page..page*@per_page].each do |user|
      self << UserItem.new(user)
    end
  end

  def get_users
    request = Fron::Request.new 'http://js-assessment-backend.herokuapp.com/users.json', 'Content-Type' => 'application/json'
    request.get do |response|
      @users = response.json if response.ok?
      yield @users
    end
  end

  def next_page
    return if @page == (@users.count.to_f / @per_page).ceil
    @page += 1
    render_page @page
  end

  def prev_page
    return if @page == 1
    @page -= 1
    render_page @page
  end

end
