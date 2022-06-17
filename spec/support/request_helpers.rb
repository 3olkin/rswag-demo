module RequestHelpers
  def json
    @json ||= Oj.load(response.body).with_indifferent_access
  end

  def access_token_for(user)
    return unless user.is_a? User

    "Bearer #{JsonWebToken.encode(sub: user.id)}"
  end
end
