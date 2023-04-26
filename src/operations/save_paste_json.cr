class SavePasteJson < Paste::SaveOperation
  needs serialized_paste : SerializedPaste

  before_save do
    self.contents.value = serialized_paste.contents

    if extension = serialized_paste.extension
      self.language.value = EXTENSION_TO_LANGUAGE[extension]?
    elsif language = serialized_paste.language
      self.language.value = language
    end

    self.language.value ||= "plaintext"

    if fork_of = serialized_paste.fork_of
      fork_of_id = Hashids.instance.decode(fork_of).first
      self.fork_of_id.value = fork_of_id
    end

    self.deletion_token.value = Random.new.urlsafe_base64(16)
  end
end
