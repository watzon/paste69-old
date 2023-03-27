class Hashids
  def self.instance
    @@instance ||= new(salt: ENV["HASHIDS_SALT"], min_hash_size: 8)
  end
end
