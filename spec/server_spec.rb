describe "GET /" do      
  context "Fetch / endpoint" do      
    it "returns Hello World" do
      get "/"
      expect(last_response.body).to eq("Hello World")
      expect(last_response.status).to eq 200
    end
  end
end
