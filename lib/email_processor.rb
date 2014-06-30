class EmailProcessor
  def self.process(email)
    Email.create(from: email.from.to_s, to: email.to.to_s, cc: email.cc.to_s, subject: email.subject, body: email.body)
  end	
end