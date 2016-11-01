require 'openssl'

class Guest < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/}
  validates :password, length: {minimum: 6}, format: {with: /\A[a-zA-Z0-9"_"]+\z/}

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password

  def encrypt_password
    if self.password.present?
      self.password_salt = Guest.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = Guest.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    guest = find_by(email: email)

    if guest.present? && guest.password_hash == Guest.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password,
                                                                                             guest.password_salt,
                                                                                                ITERATIONS,
                                                                                                DIGEST.length,
                                                                                                DIGEST))
      guest
    else
      nil
    end
  end


end
