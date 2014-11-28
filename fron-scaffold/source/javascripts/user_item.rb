require 'user_status'

class UserItem < Fron::Component
  tag 'tr'

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
