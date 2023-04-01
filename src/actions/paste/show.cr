class Paste::Show < BrowserAction
  param raw : Bool = false

  get "/p/:hashed_id" do
    # Check if the id ends with a .md, if so, render it as markdown
    if hashed_id.ends_with? ".md"
      id = Hashids.instance.decode(hashed_id[0...-3]).first
      markdown = true
    else
      id = Hashids.instance.decode(hashed_id).first
    end

    paste = PasteQuery.find(id)
    if raw
      plain_text paste.contents
    elsif markdown
      raw_html = Luce.to_html(paste.contents)
      html Paste::Markdown::ShowPage, paste: paste, raw_html: raw_html
    else
      html Paste::ShowPage, paste: paste
    end
  end
end
