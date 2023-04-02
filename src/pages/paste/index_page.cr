class Paste::IndexPage < MainLayout
  needs fork_of : Paste?

  def content
    form_for Paste::Create, class: "h-full", autocomplete: "off" do
      if paste = fork_of
        input type: "hidden", name: "paste:fork_of_id", value: paste.hashed_id
      end
      div class: "flex flex-col h-full justify-between" do
        mount Shared::Navbar, paste: fork_of
        div class: "w-full flex-grow" do
          if paste = fork_of
            textarea id: "editor", name: "paste:contents", data_language: paste.language do
              text paste.contents
            end
          else
            textarea id: "editor", name: "paste:contents"
          end
        end
        mount Shared::Footer
      end
    end
  end
end
