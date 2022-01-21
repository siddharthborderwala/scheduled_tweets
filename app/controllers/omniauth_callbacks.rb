class OmniauthCallbacks < ApplicationController
  def twitter
    acc = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
    acc.update(
      name: auth.info.name,
      username: auth.info.nickname,
      image: auth.info.image,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
    )
    redirect_to twitter_accounts_path, notice: "@#{auth.info.nickname} twitter account connected!"
  end

  def auth
    request.env['omniauth.auth']
  end
end