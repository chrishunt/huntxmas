def user
  @user ||= FactoryGirl.create(:user, name: "Chris")
end

def gift
  @gift ||= FactoryGirl.create(:gift, name: "Xbox", user: user)
end

def another_user
  @another_user ||= FactoryGirl.create(:user, name: "Nick")
end

def another_gift
  @another_gift ||= FactoryGirl.create(
    :gift, name: "Book", user: another_user)
end

def third_user
  @third_user ||= FactoryGirl.create(:user, name: "Mom")
end
