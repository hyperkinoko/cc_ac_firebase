#!/bin/sh

for a in {1..6}
do
    pandoc -f gfm text/step${a}.md -t html5 -s -o text_html/step${a}.html -c github-markdown.css --metadata pagetitle="step${a}"
done
