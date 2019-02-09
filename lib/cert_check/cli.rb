require 'openssl'
require 'thor'

module CertCheck
  # Cert-check's command line interface
  class CLI < Thor
    desc 'info [CERTIFICATE FILES]', 'Check certificate files and return information'
    def info(*files)
      if files.empty?
        say_status :error,
                   'Pass one or more certificate file paths as arguments.',
                   :red
        exit(1)
      end

      files.each do |file|
        puts "CertFile:   #{file}"

        begin
          @cert = OpenSSL::X509::Certificate.new File.read file
        rescue OpenSSL::X509::CertificateError => e
          say_status :error,
                     "Certificate file is incorrect. (#{e.class}: #{e.message})\n\n",
                     :red
          next
        rescue StandardError => e
          say_status :error, "#{e.class}: #{e.message}\n\n", :red
          next
        end

        resources
        puts template
      end
    end

    private

    def resources
      @subject    = array_to_hash(@cert.subject.to_a)
      @issuer     = array_to_hash(@cert.issuer.to_a)
      @not_before = @cert.not_before.getlocal
      @not_after  = @cert.not_after.getlocal
      @sans       = sans_to_array
    end

    def array_to_hash(arr)
      Hash[*arr.flatten.reject { |a| a.is_a?(Integer) }]
    end

    def sans_to_array
      @cert.to_text.scan(/Subject Alternative Name:\s*([^\n\r]*)/).join(',')
           .scan(/DNS:([^,]*)/).flatten
    end

    def template
      <<~OUT
        Issuer:     #{@issuer['CN']}
        NotBefore:  #{@not_before}
        NotAfter:   #{@not_after}
        CommonName: #{@subject['CN']}
        SANs:       [#{@sans.join(' ')}]\n
      OUT
    end
  end
end
