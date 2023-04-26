class Home::DocsPage < MainLayout
  def page_title
    "Documentation"
  end

  def content
    div class: "flex flex-col h-full justify-between" do
      mount Shared::Navbar
      div class: "w-full flex-grow text-gray-800 bg-gray-200 dark:bg-gray-700 dark:text-gray-200" do
        mount Shared::MarkdownContent do
          raw Luce.to_html <<-MARKDOWN
          # Documentation
          #### Last updated: 04/25/2023

          Paste69 is a simple pastebin service that allows you to share text and code snippets with others. You can do this using the web interface or the API.

          ## Web Interface

          The web interface is mostly self-explanatory, but there are a couple of very useful hidden features you may wish to be aware of:

          ### Markdown Support

          Paste69 has first class support for rendering markdown. To use this, simply select `Markdown` as the language when creating a paste. You can also use the `--language Markdown` flag when using the bash script, or append `.md` to the end of any paste URL to render the paste as if it were markdown.

          ### Raw File Downloads

          Sometimes you may wish to download a paste directly rather than copy/pasting it. To get a raw text response without any of the UI clutter, just add the `?raw` flag to the end of a paste URL. For example, [https://0x45.st/p/xrQZGRNA?raw](https://0x45.st/p/xrQZGRNA?raw).

          ### Forking

          For now there is no editing built into Paste69, and there may never be. Instead you can fork a paste to create a new paste with the same contents. To do this, just click the `Fork` button on any paste. You can also use the `--fork-of` flag when using the bash script. Forks will be linked together, so you can easily see the history of a paste.

          ## API

          Swagger documentation is available at [/api/v1](/api/v1). The purpose of this documentation will be to explain in a little bit more detail what is possible through the API.

          ### Create a paste

          To create a paste, you need to send a POST request to the `/api/v1/paste` endpoint. The request body should be a JSON object with the following fields:
          - `contents` - The contents of the paste
          - `language` - The language of the paste. This is used for syntax highlighting. Defaults to `Plain Text` if not specified.
          - `fork_of`  - The ID of the paste that this paste is a fork of. Defaults to `null` if not specified.

          The response will be a JSON object:

          ```json
          {
            "success": true,
            "paste": {
              "id": "yGOdnRpq",
              "link": "https://0x45.st/yGOdnRpq",
              "delete_link": "https://0x45.st/yGOdnRpq/delete?deletion_token=JrWVH8QJWNSpQqTMR84SGg",
              "contents": "Testing",
              "language": "Plain Text",
              "created_at": "2023-04-24T23:21:31Z"
            }
          }
          ```

          ### Get a paste

          Fetching a paste requires that you know the ID of that paste. You can then send a GET request to `/api/v1/paste/:id`, where `:id` is the ID of the paste you want to fetch.

          The response will be exactly the same as the above JSON object, but without the `deletion_token` and with the addition of a `forks` array, which contains all of the pastes that were forked from this paste.

          ### Delete a paste

          Deleting pastes requires the ID of the paste, as well as the deletion token. The `deletion_token` itself is only ever shown when a paste is first created, so don't lose that.

          To delete a paste, send a DELETE request to `/api/v1/paste/:id/delete?deletion_token=:deletion_token`, where `:id` is the ID of the paste you want to delete, and `:deletion_token` is the deletion token of that paste.

          The response will be a `200 OK` if the paste was successfully deleted, or a `422 Unprocessable Entity` if the deletion token was incorrect.

          ## Bash Script

          To make it easy to use paste69 from the terminal, you can download the bash script located at [/paste69.sh](/paste69.sh). This script requires `curl` and `jq` to be installed. To install it to `~/.local/bin`, run the following commands:

          ```bash
          sudo apt update && sudo apt install curl jq
          curl -o ~/.local/bin/paste69 https://0x45.st/paste69.sh
          chmod +x ~/.local/bin/paste69
          ```

          To make things even easier you can also use the installer script located at [/install.sh](/install.sh). This script will install the bash script to `/usr/local/bin`. You can run it like this:

          ```bash
          sudo apt update && sudo apt install curl jq
          curl -s https://0x45.st/install.sh | sudo bash
          ```

          You can then use it like this:

          ```bash
          paste69 ./some-file.md --language Markdown
          # or
          cat ./some-file.md | paste69 --language Markdown
          ```
          MARKDOWN
        end
      end
      mount Shared::Footer
    end
  end
end
