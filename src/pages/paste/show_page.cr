class Paste::ShowPage < MainLayout
  needs paste : Paste

  def content
    form_for Paste::Create, class: "flex flex-col h-full w-full", autocomplete: "off" do
      mount Shared::Navbar, paste: paste
      div class: "w-full flex-grow" do
        textarea paste.contents, id: "editor", data_language: paste.language, readonly: true, disabled: true
      end
      mount Shared::Footer
    end
  end
end
