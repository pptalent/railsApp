module UsersHelper
  def avatar(user,s="")
    id=Digest::MD5::hexdigest(user.email.downcase)
    url="https://secure.gravatar.com/avatar/#{id}#{s}"
    image_tag( url,alt:user.name,class:"user-avatar" )
  end

end
