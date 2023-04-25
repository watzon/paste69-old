class Shared::LayoutHead < BaseComponent
  needs page_title : String?

  def render
    head do
      utf8_charset
      title @page_title ? "Paste69 - #{@page_title}" : "Paste69 - Beautiful open source pastebin service"
      css_link asset("css/app.css")
      js_link asset("js/app.js"), defer: "true"
      csrf_meta_tags
      responsive_meta_tag
      meta content: "Paste, save, share, and fork code snippets and other content.", name: "description"
      meta content: "#1E1E2E", name: "theme-color"
      meta content: "pastebin,paste,paste tool,code,code snippets,code sharing,code sharing tool,code sharing website,crystal,lucky,luckyframework,crystallang", name: "keywords"
      meta content: "Paste69 - Beautiful open source pastebin service", property: "og:title"
      meta content: ENV["APP_DOMAIN"], property: "og:url"
      meta content: "website", property: "og:type"
      meta content: "Paste, save, share, and fork code snippets and other content.", name: "og:description"
      meta content: "Paste69", property: "og:site_name"
      meta content: "en_US", property: "og:locale"
      meta content: File.join(ENV["APP_DOMAIN"], asset("images/logo.png")), property: "og:image"

      # Share enabled languages with JS
      tag "script", type: "text/javascript" do
        raw "window.enabledLanguages = #{ENABLED_LAGUAGES.to_json}"
      end

      # Used only in development when running `lucky watch`.
      # Will reload browser whenever files change.
      # See [docs]()
      live_reload_connect_tag
    end
  end
end
