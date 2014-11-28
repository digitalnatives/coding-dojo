class UserStatus < Fron::Component
  tag 'td'

  component :link, "a[href=#].status"

  on :click, '.status', :toggle

  def init(user)
    @user = user
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

  private

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

end
