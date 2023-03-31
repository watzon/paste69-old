class Paste < BaseModel
  table do
    column contents : String
    column language : String
    column views : Int32 = 0
    column deletion_token : String
    belongs_to fork_of : Paste?
  end

  @hashed_id : String?

  def hashed_id
    @hashed_id = Hashids.instance.encode([id])
  end

  def link
    File.join(ENV["APP_DOMAIN"], "p", hashed_id)
  end

  def deletion_url
    File.join(ENV["APP_DOMAIN"], "p", hashed_id, "delete?deletion_token=#{deletion_token}")
  end
end
