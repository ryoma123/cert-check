# cert-check

[![Gem Version](https://badge.fury.io/rb/cert-check.svg)](https://badge.fury.io/rb/cert-check)
[![Build Status](https://travis-ci.org/ryoma123/cert-check.svg?branch=master)](https://travis-ci.org/ryoma123/cert-check)

CLI tool for Check a certificate files and return information.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cert-check'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install cert-check
```

## Usage

Passing one or more certificate file paths as arguments.

```sh
$ cert-check info /tmp/www.example.org.crt /tmp/github.com.crt
CertFile:   /tmp/www.example.org.cert
Issuer:     DigiCert SHA2 Secure Server CA
NotBefore:  2018-11-28 09:00:00 +0900
NotAfter:   2020-12-02 21:00:00 +0900
CommonName: www.example.org
SANs:       [www.example.org example.com example.edu example.net example.org www.example.com www.example.edu www.example.net]

CertFile:   /tmp/github.com.cert
Issuer:     DigiCert SHA2 Extended Validation Server CA
NotBefore:  2018-05-08 09:00:00 +0900
NotAfter:   2020-06-03 21:00:00 +0900
CommonName: github.com
SANs:       [github.com www.github.com]
```

Get help on this command.

```sh
$ cert-check help
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
