# just-encrypt

The simplest gem for encrypt and decrypt data

# Getting started
JustEncrypt works with Rails 5.2 onwards. Add the following line to your Gemfile:
```ruby
gem 'devise'
```  
Then run `bundle install`

Next, you need to add a secret key into your credentials file, the key must be 32 bytes. You can generate one easily with OpenSSL:
```console
$ openssl rand -hex 16
```

Then edit your credentials:
```console
$ EDITOR=vim rails credentials:edit
```

And add the secret key generated with the next structure:

`just_encrypt:
  secret: YOUR_SECRET_KEY`
  
# Encrypt data

For encrypt data just do:

`require 'just-encrypt'

`JustEncrypt.encrypt('STRING_TO_ENCRYPT')`

# Decrypt data

`require 'just-encrypt'

`JustEncrypt.decrypt('STRING_TO_DECRYPT')`
