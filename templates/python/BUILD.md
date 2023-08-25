# Build readme

Hi

Copy all the stuff in a new dir where you want to begin editing a python project.

* start a python shell in the project dir with `nix-shell`.
* then do `poetry init` in the directory, to start poetry.
* add project dependancies with `poetry add requests flask libraryblah libraryblah2`
* add the main app in `poetry.toml` under `[tool.poetry.scripts]`, like for example `imgapp = 'imgapp:main'`
* do all the python stuff in your app (in this case `imgapp/__init__.py`)
* build with `nix-build`
* voila, see `result` dir..
