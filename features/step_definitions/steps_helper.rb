def user
  @user ||= Factory(:user, :name => "Chris")
end

def gift
  @gift ||= Factory(:gift, :name => "Xbox", :user => user)
end

def another_user
  @another_user ||= Factory(:user, :name => "Nick")
end

def another_gift
  @another_gift ||= Factory(:gift, :name => "Book", :user => another_user)
end

