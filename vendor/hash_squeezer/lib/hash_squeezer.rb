require "hash_squeezer/version"

module HashSqueezer
  # Thanks https://stackoverflow.com/questions/3450641/removing-all-empty-elements-from-a-hash-yaml
  def squeeze(hash_or_array)
    p = proc do |*args|
      v = args.last
      v.delete_if(&p) if v.respond_to? :delete_if
      v.nil? || v.respond_to?(:"empty?") && v.empty?
    end

    hash_or_array.delete_if(&p)
  end

  extend self
end
