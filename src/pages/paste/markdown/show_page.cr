class Paste::Markdown::ShowPage < MainLayout
  needs paste : Paste
  needs raw_html : String

  def content
    form_for Paste::Create, class: "h-full", autocomplete: "off" do
      div class: "flex flex-col h-screen justify-between" do
        mount Shared::Navbar, paste: paste
        mount Shared::MarkdownContent do
          raw raw_html
        end
        mount Shared::Footer
      end
    end
  end
end
