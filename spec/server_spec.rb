describe '.server' do
  context 'when fetching / endpoint' do
    it 'returns Hello World' do
      get '/'
      expect(last_response.body).to eq('Hello World')
      expect(last_response.status).to eq 200
    end
  end
  context 'when fetching /status endpoint' do
    it 'returns status information' do
      get '/status'
      expect(last_response.status).to eq 200
      info = JSON.parse(last_response.body)
      expect(info.size).to eq 1
      expect(info['myapplication'][0]['version']).not_to be_empty
      expect(info['myapplication'][0]['description']).not_to be_empty
      expect(info['myapplication'][0]['lastcommitsha']).not_to be_empty
    end
  end
end
