StaticR only works when each connector-piece of a file is referred to by a `_`
character. So to refer to something like `bootstrap-theme.min.css` you would
write `bootstrap_theme_min_css`.

Adding new static files can be a bit tricky when it comes to compiling. You will
probably need to delete the `dist` and `.stack-work` folders when you add new
files in the `static/` directory in order for them to come into scope properly.
