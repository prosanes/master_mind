require './secret_code_holder'

describe SecretCodeHolder do
  
	it "has a secret code" do
		sch = SecretCodeHolder.new(secret_code:"AAAA")
	end

	it "accepts a guess"
	it "answers a clue based on the last guess"

end
