module CryptKey

  private

  def crypt_key(pass=Time.zone.now, salt=Time.zone.now)
    require "digest/sha1"
    3.times do |i|
      pass = Digest::SHA1.hexdigest("--#{salt}--#{pass}--")
    end
    return pass
  end
end

