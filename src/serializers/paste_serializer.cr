class PasteSerializer < BaseSerializer
  def initialize(@paste : Paste, @is_new : Bool = false)
  end

  def render
    hashed_id = Hashids.instance.encode([@paste.id])
    {
      success: true,
      paste:   {
        id:          hashed_id,
        link:        File.join(ENV["APP_DOMAIN"], "p", hashed_id),
        delete_link: @is_new ? File.join(ENV["APP_DOMAIN"], "p", hashed_id, "delete?deletion_token=#{@paste.deletion_token}") : nil,
        contents:    @paste.contents,
        language:    @paste.language,
        created_at:  @paste.created_at.to_utc,
      },
    }
  end
end
