class PasteSerializer < BaseSerializer
  def initialize(@paste : Paste, @is_new : Bool = false)
  end

  def render
    hashed_id = Hashids.instance.encode([@paste.id])
    paste_tuple = {
      id:          hashed_id,
      link:        @paste.link,
      contents:    @paste.contents,
      language:    @paste.language,
      created_at:  @paste.created_at.to_utc,
    }

    if @is_new
      paste_tuple = paste_tuple.merge({
        delete_link: @paste.delete_link
      })
    else
      paste_tuple = paste_tuple.merge({
        forks: @paste.forks.map do |fork|
          {
            id:         fork.hashed_id,
            link:       fork.link,
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
