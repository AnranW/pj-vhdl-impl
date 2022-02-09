

out.pdf: *.md
	pandoc --filter pandoc-citeproc -f markdown -t latex $^ -o $@

.PHONY: clean

clean:
	rm -rf out.pdf
