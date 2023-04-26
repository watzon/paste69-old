class Paste::IndexPage < MainLayout
  needs fork_of : Paste?

  def content
    form_for Paste::Create, class: "h-full", autocomplete: "off" do
      if paste = fork_of
        input type: "hidden", name: "paste:fork_of_id", value: paste.hashed_id
      end
      div class: "flex flex-col h-full justify-between" do
        mount Shared::Navbar, paste: fork_of
        div id: "editor", class: "w-full flex-grow", data_language: fork_of.try(&.language.downcase) || "plaintext"
        textarea id: "editor-contents", class: "hidden", name: "paste:contents" do
          if paste = fork_of
            text paste.contents
          end
        end
        mount Shared::Footer
      end
    end
  end
end
