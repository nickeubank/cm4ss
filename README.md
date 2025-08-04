# Computational Methods for Social Scientists

This site is built with `sphinx`, a python-based document builder. 

To build / update the page:

- install `sphinx`, `nbsphinx`, and `sphinx-material`. `pip install sphinxcontrib.youtube sphinx_autobuild` too.
- navigate to the root folder and run `python -m sphinx_autobuild source docs/html`. This will rebuild the site after every change, and serve it to a localhost site for immediate review. 

All materials live in `source` as jupyter notebooks, and built to HTML files in `docs/html`. 
