class Paste::ShowPage < MainLayout
  needs paste : Paste

  def content
    form_for Paste::Create, class: "h-full", autocomplete: "off" do
      div class: "flex flex-col h-screen justify-between" do
        mount Shared::Navbar, paste: paste
        div class: "w-full flex-grow" do
          textarea paste.contents, id: "editor", data_language: paste.language, readonly: true, disabled: true
        end
        mount Shared::Footer
      end
    end
  end
end
