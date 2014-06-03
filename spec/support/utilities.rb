def full_title(title)
  if title.blank?
    "wayne"
  else
    "wayne #{title}"
  end
end

def sign_in(user)
  remember_token=User.create_remember_token
  cookies[:remember_token]=remember_token
  user.update_attribute(:remember_token,User.digest_remember_token(remember_token))
end