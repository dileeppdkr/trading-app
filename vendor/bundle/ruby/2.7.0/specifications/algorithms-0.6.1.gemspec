# -*- encoding: utf-8 -*-
# stub: algorithms 0.6.1 ruby lib ext
# stub: ext/algorithms/string/extconf.rb ext/containers/bst/extconf.rb ext/containers/deque/extconf.rb ext/containers/rbtree_map/extconf.rb ext/containers/splaytree_map/extconf.rb

Gem::Specification.new do |s|
  s.name = "algorithms".freeze
  s.version = "0.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze, "ext".freeze]
  s.authors = ["Kanwei Li".freeze]
  s.date = "2013-01-22"
  s.description = "Heap, Priority Queue, Deque, Stack, Queue, Red-Black Trees, Splay Trees, sorting algorithms, and more".freeze
  s.email = "kanwei@gmail.com".freeze
  s.extensions = ["ext/algorithms/string/extconf.rb".freeze, "ext/containers/bst/extconf.rb".freeze, "ext/containers/deque/extconf.rb".freeze, "ext/containers/rbtree_map/extconf.rb".freeze, "ext/containers/splaytree_map/extconf.rb".freeze]
  s.files = ["ext/algorithms/string/extconf.rb".freeze, "ext/containers/bst/extconf.rb".freeze, "ext/containers/deque/extconf.rb".freeze, "ext/containers/rbtree_map/extconf.rb".freeze, "ext/containers/splaytree_map/extconf.rb".freeze]
  s.homepage = "https://github.com/kanwei/algorithms".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--line-numbers".freeze, "--inline-source".freeze, "--title".freeze, "Algorithms".freeze, "--main".freeze, "README.markdown".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Useful algorithms and data structures for Ruby. Optional C extensions.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version
end
