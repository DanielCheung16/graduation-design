# 定义任务 sv2v：将所有 .sv 文件改为 .v 文件
sv2v:
	@for f in ./*.sv; do \
		[ -e "$$f" ] && echo "Renaming $$f -> $${f%.sv}.v" && mv "$$f" "$${f%.sv}.v"; \
	done

# 定义任务 v2sv：将所有 .v 文件改为 .sv 文件	
v2sv:
	@for f in ./*.v; do \
		[ -e "$$f" ] && echo "Renaming $$f -> $${f%.v}.sv" && mv "$$f" "$${f%.v}.sv"; \
	done

count_lines:
	@echo "1. Counting non-empty lines of all .sv files..."
	@sv_lines=$$(find . -type f -name "*.sv" -exec grep -v '^[[:space:]]*$$' {} + | wc -l); \
	echo "$$sv_lines lines in all .sv files under current directory"

	@echo "2. Counting non-empty lines of all .v files in HDMI folder..."
	@v_lines=$$(find ./sources_1/imports/HDMI -type f -name "*.v" -exec grep -v '^[[:space:]]*$$' {} + | wc -l); \
	echo "$$v_lines lines in all .v files under HDMI directory"

	@echo "3. Total non-empty lines:"
	@sv_lines=$$(find . -type f -name "*.sv" -exec grep -v '^[[:space:]]*$$' {} + | wc -l); \
	v_lines=$$(find ./sources_1/imports/HDMI -type f -name "*.v" -exec grep -v '^[[:space:]]*$$' {} + | wc -l); \
	total_lines=$$((sv_lines + v_lines)); \
	echo "$$total_lines total non-empty lines"
