require 'spec_helper.rb'

describe Stitches::Configuration do
  before do
    Stitches.configuration.reset_to_defaults!
  end

  describe "global configuration" do
    let(:whitelist_regexp) { %r{foo} }
    let(:custom_http_auth_scheme) { "Blah" }
    let(:env_var_to_hold_api_client_primary_key) { "FOOBAR" }

    it "can be configured globally" do
      Stitches.configure do |config|
        config.whitelist_regexp                       = whitelist_regexp
        config.custom_http_auth_scheme                = custom_http_auth_scheme
        config.env_var_to_hold_api_client_primary_key = env_var_to_hold_api_client_primary_key
      end

      expect(Stitches.configuration.whitelist_regexp).to                       eq(whitelist_regexp)
      expect(Stitches.configuration.custom_http_auth_scheme).to                eq(custom_http_auth_scheme)
      expect(Stitches.configuration.env_var_to_hold_api_client_primary_key).to eq(env_var_to_hold_api_client_primary_key)
    end

    it "defaults to nil for whitelist_regexp" do
      expect(Stitches.configuration.whitelist_regexp).to be_nil
    end

    it "sets a default for env_var_to_hold_api_client_primary_key" do
      expect(Stitches.configuration.env_var_to_hold_api_client_primary_key).to eq("STITCHES_API_CLIENT_ID")
    end

    it "blows up if you try to use custom_http_auth_scheme without having set it" do
      expect {
        Stitches.configuration.custom_http_auth_scheme
      }.to raise_error(/you must set a value for custom_http_auth_scheme/i)
    end
  end
  describe "whitelist_regexp" do
    let(:config) { Stitches::Configuration.new }
    it "must be a regexp" do
      expect {
        config.whitelist_regexp = "foo"
      }.to raise_error(/whitelist_regexp must be a Regexp/i)
    end
    it "may be nil" do
      expect {
        config.whitelist_regexp = nil
      }.not_to raise_error
    end
    it "may be a regexp" do
      expect {
        config.whitelist_regexp = /foo/
      }.not_to raise_error
    end
  end

  describe "custom_http_auth_scheme" do
    let(:config) { Stitches::Configuration.new }
    it "must be a string" do
      expect {
        config.custom_http_auth_scheme = 42
      }.to raise_error(/custom_http_auth_scheme must be a String/i)
    end
    it "may not be nil" do
      expect {
        config.custom_http_auth_scheme = nil
      }.to raise_error(/custom_http_auth_scheme may not be blank/i)
    end
    it "may not be a blank string" do
      expect {
        config.custom_http_auth_scheme = "    "
      }.to raise_error(/custom_http_auth_scheme may not be blank/i)
    end
    it "may be a String" do
      expect {
        config.custom_http_auth_scheme = "Foobar"
      }.not_to raise_error
    end
  end

  describe "env_var_to_hold_api_client_primary_key" do
    let(:config) { Stitches::Configuration.new }
    it "must be a string" do
      expect {
        config.env_var_to_hold_api_client_primary_key = 42
      }.to raise_error(/env_var_to_hold_api_client_primary_key must be a String/i)
    end
    it "may not be nil" do
      expect {
        config.env_var_to_hold_api_client_primary_key = nil
      }.to raise_error(/env_var_to_hold_api_client_primary_key may not be blank/i)
    end
    it "may not be a blank string" do
      expect {
        config.env_var_to_hold_api_client_primary_key = "    "
      }.to raise_error(/env_var_to_hold_api_client_primary_key may not be blank/i)
    end
    it "may be a String" do
      expect {
        config.env_var_to_hold_api_client_primary_key = "Foobar"
      }.not_to raise_error
    end
  end
end
