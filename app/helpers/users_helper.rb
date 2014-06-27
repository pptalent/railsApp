module UsersHelper
  def avatar(user,s="")
    image_array=%w(identicon monsterid wavatar retro)
    default_string="monsterid"
    id=Digest::MD5::hexdigest(user.email.downcase)
    if s.length>0
      url="https://secure.gravatar.com/avatar/#{id}#{s}&d="+default_string
    else
      url="https://secure.gravatar.com/avatar/#{id}?d="+default_string
    end

    image_tag( url,alt:user.name,:class=>"user-avatar",:url=>url)
  end

end
