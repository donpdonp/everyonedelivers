class Openidentity < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :url
  validates_uniqueness_of :url
  belongs_to :user

  def self.lookup(url)
    url = cannonical(url)
    find(:first, :conditions => {:url => cannonical(url)})
  end 

  def self.create_openid_and_user_with_url(url, hints)
      new_user = User.create!(:username => generate_username(url))
      new_user.update_attribute :email, hints[:email] unless hints[:email].blank?
      new_user.update_attribute :username, hints[:username] unless hints[:username].blank?
      Openidentity.create!(:user => new_user, :url => cannonical(url))
  end

  def self.cannonical(url)
    # add a trailing slash if there is no slash after the hostname
    uri = URI.parse(url)
    if uri.path.blank?
      return uri.to_s+"/"
    end
    uri.to_s
  end

  def self.generate_username(url)
    uri = URI.parse(url)
    case uri
    when URI::HTTP, URI::HTTPS
      username = uri.host + uri.path + (uri.query ? uri.query : "")
    when URI::Generic
      if uri.path.blank?
        username = uri.opaque
      else
        username = uri.path
      end
    end
    username.gsub('.', '').gsub('/','')
  end
end
