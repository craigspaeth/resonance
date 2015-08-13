# Remove whitespace from HTML so display: inline-block is actually useful
Haml::Template.options[:ugly] = true
Haml::Template.options[:remove_whitespace] = true
