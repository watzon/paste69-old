class SavePaste < Paste::SaveOperation
  permit_columns :contents, :language

  attribute fork_of : String

  before_save do
    if self.language.value.nil? || self.language.value.try &.empty?
      self.language.value = "Plain Text"
    end

    if fork_of = self.fork_of.value
      fork_of_id = Hashids.instance.decode(fork_of).first
      self.fork_of_id.value = fork_of_id
    end

    self.deletion_token.value = Random.new.urlsafe_base64(16)
  end
end
