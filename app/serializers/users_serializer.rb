class UsersSerializer
  def initialize(user)
    @user = user
  end

  def as_json
    @user.to_h
  end
end
