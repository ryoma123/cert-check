require 'spec_helper'

describe CertCheck::CLI do
  let(:cli) { CertCheck::CLI.new }
  describe '#array_to_hash' do
    arr = [
      ['C', 'JP', 19],
      ['ST', 'TOKYO', 19],
      ['L', 'SHIBUYA', 19],
      ['O', 'EXAMPLE, Inc.,', 19],
      ['OU', '', 19],
      ['CN', 'www.example.com', 19]
    ]
    expected = {
      'C' => 'JP',
      'ST' => 'TOKYO',
      'L' => 'SHIBUYA',
      'O' => 'EXAMPLE, Inc.,',
      'OU' => '',
      'CN' => 'www.example.com'
    }

    it 'returns hash with contents of certificate files' do
      expect(cli.send(:array_to_hash, arr)).to be_a Hash
      expect(cli.send(:array_to_hash, arr)).to match(expected)
    end
  end

  describe '#sans_to_array' do
    text = "Subject Alternative Name: DNS:www.example.com, DNS:example.com\n"
    expected = ['www.example.com', 'example.com']

    it 'returns array with contents of certificate files' do
      openssl_mock = double('OpenSSL::X509::Certificate')
      allow(openssl_mock).to receive(:to_text).and_return(text)
      cli.instance_variable_set(:@cert, openssl_mock)

      expect(cli.send(:sans_to_array)).to be_a Array
      expect(cli.send(:sans_to_array)).to match(expected)
    end
  end
end
