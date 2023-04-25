class Home::AboutPage < MainLayout
  def page_title
    "About"
  end

  def content
    div class: "flex flex-col h-full justify-between" do
      mount Shared::Navbar
      div class: "w-full h-full flex-grow text-gray-800 bg-gray-200 dark:bg-gray-700 dark:text-gray-200" do
        mount Shared::MarkdownContent do
          raw Luce.to_html <<-MARKDOWN
          # About

          **Paste69** is a free, minimal, easy to use, and open source pastebin created by [@watzon](https://watzon.tech) using the [Lucky](https://luckyframework.org) web framework. Its features include:

          - Syntax highlighting for several languages
          - Markdown support (by adding .md to the end of the URL)
          - Light and dark modes (powered by [catppuccin](https://github.com/catppuccin/codemirror))
          - A simple API for creating, deleting, and viewing pastes (see the swagger docs at [/api/v1](/api/v1))

          You can find the source for the project and contribute [on Github](https://github.com/paste69/paste69).

          ### Special Thanks

          - [Lucky](https://luckyframework.org) for making web development fun and easy
          - [Supercell](https://codeberg.org/supercell) for providing a great open source [markdown renderer](https://codeberg.org/supercell/luce) for Crystal.
          - [Catppuccin](https://github.com/catppuccin) for an awesome theme which I use everywhere.
          - [Tailwind](https://tailwindcss.com) for making CSS less of a pain.
          - [CodeMirror](https://codemirror.net) for providing an awesome code editor.

          ### Enjoying Paste69?
          <script type="text/javascript" src="https://cdnjs.buymeacoffee.com/1.0.0/button.prod.min.js" data-name="bmc-button" data-slug="watzon" data-color="#40DCA5" data-emoji=""  data-font="Comic" data-text="Buy me a coffee" data-outline-color="#000000" data-font-color="#ffffff" data-coffee-color="#FFDD00" ></script>
          MARKDOWN
        end
      end
      mount Shared::Footer
    end
  end
end
