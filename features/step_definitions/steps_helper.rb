def user
  @user ||= Factory(:user)
end

def gift
  @gift ||= Factory(:gift, :user => user)
end
