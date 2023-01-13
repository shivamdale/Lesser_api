module ApiHelper
  def authenticated_header(request, user)
    token = BuilderJsonWebToken.encode(user.id)
    request.headers.merge!(token: "#{token}")
  end
end