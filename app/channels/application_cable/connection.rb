module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :visit

    def connect
      self.visit = cookies.encrypted[:visit]
    end
  end
end
