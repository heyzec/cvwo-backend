class Link < ApplicationRecord
  belongs_to :user
  belongs_to :list

  # Remove share_hash column when converting model record into json
  def as_json(options = {})
    super(options.merge({ except: [:share_hash] }))
  end
end
