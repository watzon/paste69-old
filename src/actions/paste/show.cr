class Paste::Show < BrowserAction
  param raw : String?

  get "/p/:hashed_id" do
    # Check if the id ends with a .md, if so, render it as markdown
    begin
      if hashed_id.ends_with? ".md"
        index = hashed_id.rindex(".md")
        id = Hashids.instance.decode(hashed_id[0...index]).first
        markdown = true
      else
        id = Hashids.instance.decode(hashed_id).first
      end
    rescue
      raise Lucky::RouteNotFoundError.new(context)
    end

    if (paste = PasteQuery.find(id) rescue nil)
      if raw && raw.in?(["1", "true", "t", ""])
        plain_text paste.contents
      elsif markdown
        raw_html = Luce.to_html(paste.contents, extension_set: Luce::ExtensionSet::GITHUB_WEB)
        # TODO: XSS protection
        html Paste::Markdown::ShowPage, paste: paste, raw_html: raw_html
      else
        html Paste::ShowPage, paste: paste
      end
    else
      raise Lucky::RouteNotFoundError.new(context)
    end
  end
end
