require "maxwell/version"

module Maxwell
    class Error < StandardError; end
    require 'maxwell/http/base'
    require 'maxwell/http/github_users'
end
