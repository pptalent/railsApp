module CommentsHelper
  def userFrom(userID)
    User.find_by(id:userID)
  end
end
