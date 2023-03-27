class PasteSerializer < BaseSerializer
  def initialize(@paste : Paste)
  end

  def render
    hashed_id = Hashids.instance.encode([@paste.id])
    {
      success: true,
      paste: {
        id: hashed_id,
        link: File.join(ENV["APP_DOMAIN"], hashed_id),
        delete_link: File.join(ENV["APP_DOMAIN"], hashed_id, "delete?deletion_token=#{@paste.deletion_token}"),
        contents: @paste.contents,
        language: @paste.language,
        created_at: @paste.created_at.to_utc,
      }
    }
  end
end
