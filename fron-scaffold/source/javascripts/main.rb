require 'fron'
require 'forwardable'

# Pager
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

class TableComponent < Fron::Component
  tag 'table'

  attr_accessor :page
  attr_accessor :per_page
  attr_accessor :users

  class UserItem < Fron::Component
    tag 'tr'

    class UserStatus < Fron::Component
      tag 'td'

      component :link, "a[href=#].status"

      on :click, '.status', :toggle

      def init(user)
        @user = user
      end

      def link_text
        case @user[:status]
        when 'active'
          'lock'
        when 'locked'
          'activate'
        end
      end

      def opposite_status
        case @user[:status]
        when 'active'
          'locked'
        when 'locked'
          'active'
        end
      end

      def toggle
        request = Fron::Request.new "http://js-assessment-backend.herokuapp.com/users/#{@user[:id]}.json", 'Content-Type' => 'application/json'
        request.put(user: { status: opposite_status }) do |response|
          if response.ok? || response.status == 204
            @user[:status] = opposite_status
            trigger 'render'
          end
        end
      end

      def render
        @link.text = link_text
      end
    end

    component :id, 'td'
    component :first_name, 'td'
    component :last_name, 'td'
    component :status, 'td.status'
    component :created_at, 'td'
    component :updated_at, 'td'
    component :status_toggle, UserStatus

    on 'render', :render

    def initialize( user )
      super( nil )
      @user = user
      self[:id] = "user_#{user[:id]}"
      status_toggle.init(user)
      render
    end

    def render
      @id.text = @user[:id]
      @last_name.text = @user[:last_name]
      @first_name.text = @user[:first_name]
      @status.text = @user[:status]
      @created_at.text = @user[:created_at]
      @updated_at.text = @user[:updated_at]
      @status_toggle.render
    end
  end

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

# My Component
class MyComponent < Fron::Component
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

DOM::Document.body << MyComponent.new
