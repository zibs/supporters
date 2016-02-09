class SupportRequest < ActiveRecord::Base
  before_create :format_name

  validates :name, presence: true, length: { maximum:50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum:255 },
                                    format: { with: VALID_EMAIL_REGEX }
  enum department: { Sales: 0, Marketing: 1, Technical: 2 }
  validates :message, presence: true, length: { maximum: 2000 }

  scope :search_requests, -> (term = ""){ where(["name ILIKE ? OR email ILIKE ? OR message ILIKE ?", "%#{term}%", "%#{term}%", "%#{term}%}" ]).order("updated_at DESC")}

  def snippet
    if self.message.length >= 35
      snippet = "#{self.message[0..35]} ... "
    else
      self.message
    end
  end

    private

      def format_name
        self.name = self.name.titleize
      end

end
