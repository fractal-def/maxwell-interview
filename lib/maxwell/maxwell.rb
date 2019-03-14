require "maxwell/version"

module Maxwell
  class Error < StandardError; end
  require 'maxwell/items/base'
  require 'maxwell/items/null'
  require 'maxwell/items/inventory'
  require 'maxwell/items/cart'
  require 'maxwell/items/purchase'
  require 'maxwell/collections/base'
  require 'maxwell/collections/cart'
  require 'maxwell/collections/store'
  require 'maxwell/collections/checkout'
end
