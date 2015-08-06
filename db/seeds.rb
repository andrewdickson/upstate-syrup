
def find_or_create_user(email)
  user = User.where(email: email)
  if user && user.any?
    return user.first
  else
    return User.create(email: email, password: 'palisades', password_confirmation: 'palisades')
  end
end

u1 = find_or_create_user("andrewdickson24@gmail.com")
u2 = find_or_create_user("wiredin24@gmail.com")

