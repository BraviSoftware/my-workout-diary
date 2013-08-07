class User < ActiveRecord::Base
  attr_accessible :name, :email, :provider, :uid, :oauth_token, :oauth_expires_at, :image
end
