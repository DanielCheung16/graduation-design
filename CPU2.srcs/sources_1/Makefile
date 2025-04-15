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