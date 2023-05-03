class Paste::Show < BrowserAction
  param raw : String?

  get "/p/:filename" do
    parts = filename.split(".")
    hashed_id = parts.first
    extension = parts[1]?
    language = EXTENSION_TO_LANGUAGE[extension]? || "plaintext"

    begin
      id = Hashids.instance.decode(hashed_id).first
    rescue
      raise Lucky::RouteNotFoundError.new(context)
    end

    if (paste = PasteQuery.new.preload_fork_of.find(id) rescue nil)
      if raw && raw.in?(["1", "true", "t", ""])
        return plain_text paste.contents
      else
        case language
        when "markdown"
          raw_html = Luce.to_html(paste.contents, extension_set: Luce::ExtensionSet::GITHUB_WEB)
          sanitized_html = sanitizer.process(raw_html)
          return html Paste::Markdown::ShowPage, paste: paste, raw_html: sanitized_html
        else
          return html Paste::ShowPage, paste: paste, language: language
        end
      end
    end

    raise Lucky::RouteNotFoundError.new(context)
  end

  memoize def sanitizer : Sanitize::Policy
    safelist = Sanitize::Policy::HTMLSanitizer::COMMON_SAFELIST
    safelist["code"].add "class"

    Sanitize::Policy::Whitelist.new(safelist)
  end
end
