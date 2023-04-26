class Paste::Create < BrowserAction
  post "/" do
    pp! params
    SavePaste.create(params) do |op, paste|
      if paste
        flash.success = "Paste created. To delete, visit <a class='text-blue-400' href='#{paste.delete_link}' target='_blank'>here</a>  <button type='button' onclick='copyValue(\"#{paste.delete_link}\")' title='Copy link'><i class='fas fa-copy'></i></button>. Save this link as this message will not be shown again."
        redirect to: Paste::Show.with(filename: paste.filename)
      else
        flash.failure = "Paste could not be created."
        redirect to: Paste::Index
      end
    end
  end
end
