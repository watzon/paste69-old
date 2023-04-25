class Paste::Markdown::ShowPage < MainLayout
  needs paste : Paste
  needs raw_html : String

  def content
    form_for Paste::Create, class: "flex flex-col min-h-full justify-between", autocomplete: "off" do
      mount Shared::Navbar, paste: paste
      mount Shared::MarkdownContent do
        raw raw_html
      end
      mount Shared::Footer
    end
  end
end
