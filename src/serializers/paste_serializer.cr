class PasteSerializer < BaseSerializer
  def initialize(@paste : Paste, @is_new : Bool = false)
  end

  def render
    hashed_id = Hashids.instance.encode([@paste.id])
    paste_tuple = {
      id:          hashed_id,
      link:        File.join(ENV["APP_DOMAIN"], "p", hashed_id),
      contents:    @paste.contents,
      language:    @paste.language,
      created_at:  @paste.created_at.to_utc,
    }

    if @is_new
      paste_tuple = paste_tuple.merge({
        delete_link: File.join(ENV["APP_DOMAIN"], "p", hashed_id, "delete?deletion_token=#{@paste.deletion_token}")
      })
    else
      paste_tuple = paste_tuple.merge({
        forks: @paste.forks.map do |fork|
          {
            id:         Hashids.instance.encode([fork.id]),
            link:       File.join(ENV["APP_DOMAIN"], "p", hashed_id),
            created_at: fork.created_at.to_utc,
          }
        end
      })
    end

    {
      success: true,
      paste: paste_tuple,
    }
  end
end
