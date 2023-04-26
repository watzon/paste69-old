class Paste::ShowPage < MainLayout
  needs paste : Paste

  def content
    form_for Paste::Create, class: "flex flex-col h-full w-full", autocomplete: "off" do
      mount Shared::Navbar, paste: paste
      div id: "editor", class: "w-full flex-grow", data_readonly: true, data_language: paste.language
      textarea id: "editor-contents", class: "hidden", name: "paste:contents" do
        text paste.contents
      end
      mount Shared::Footer
    end
  end
end
