require 'rubygems'

gem "harbor", "~> 0.12"
require "harbor"

gem "dm-core"
require "dm-core"

gem "dm-is-searchable"
require "dm-is-searchable"

gem "dm-validations"
require "dm-validations"

gem "dm-timestamps"
require "dm-timestamps"

gem "dm-observer"
require "dm-observer"

gem "dm-aggregates"
require "dm-aggregates"

gem "dm-types"
require "dm-types"

Dir[Pathname(__FILE__).dirname + "compass" + "models/*"].each { |r| require r }
Dir[Pathname(__FILE__).dirname + 'compass/helpers/*'].each { |r| require r }

Dir[Pathname(__FILE__).dirname + 'compass/controllers/*'].each { |r| require r }

Harbor::View::path.unshift(Pathname(__FILE__).dirname + "compass" + "views")
Harbor::View::layouts.default("layouts/application")

class Compass < Harbor::Application
  WIKI_PAGE_REGEX = /\/wiki(\/.*)?/
  
  @@public_path = Pathname(__FILE__).dirname.parent.expand_path + "public"
  def self.public_path=(value)
    @@public_path = value
  end

  def self.public_path
    @@public_path
  end

  @@private_path = Pathname(__FILE__).dirname.parent.expand_path + "private"
  def self.private_path=(value)
    @@private_path = value
  end

  def self.private_path
    @@private_path
  end

  @@tmp_path = Pathname(__FILE__).dirname.parent.expand_path + "tmp"
  def self.tmp_path=(value)
    @@tmp_path = value
  end

  def self.tmp_path
    @@tmp_path
  end
  
  def self.routes(services = self.services)
    raise ArgumentError.new("+services+ must be a Harbor::Container") unless services.is_a?(Harbor::Container)

    Harbor::Router.new do
      using services, Compass::WikiPages do
        get(WIKI_PAGE_REGEX) { |wiki_pages, request| wiki_pages.show(request.path.sub('/wiki/', '')) }
        put(WIKI_PAGE_REGEX) { |wiki_pages, request| wiki_pages.update(request.path.sub('/wiki/', ''), request['content']) }
      end
    end
  end
  
end
