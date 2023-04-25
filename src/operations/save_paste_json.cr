class SavePasteJson < Paste::SaveOperation
  needs serialized_paste : SerializedPaste

  before_save do
    self.contents.value = serialized_paste.contents
    self.language.value = serialized_paste.language
    if fork_of = serialized_paste.fork_of
      fork_of_id = Hashids.instance.decode(fork_of).first
      self.fork_of_id.value = fork_of_id
    end
    self.deletion_token.value = Random.new.urlsafe_base64(16)
  end
end
