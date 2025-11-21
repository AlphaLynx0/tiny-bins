PROGRAM := true

.PHONY: all clean test savings listing

all: $(PROGRAM) reference

$(PROGRAM): $(PROGRAM).asm
	nasm -f bin $< -o $@ -l $(PROGRAM).lst
	chmod +x $@

reference: $(PROGRAM).c
	gcc -s -Os $< -o $@

test: $(PROGRAM) reference
	@echo "Comparing outputs of ASM vs. reference"
	@ASM_OUT="$$(./$(PROGRAM))"; \
	 REF_OUT="$$(./reference)"; \
	 if [ "$$ASM_OUT" = "$$REF_OUT" ]; then \
	   echo "Test passed: outputs match"; \
	 else \
	   echo "Test failed: outputs differ"; \
	   echo "  ASM:       $$ASM_OUT"; \
	   echo "  Reference: $$REF_OUT"; \
	   exit 1; \
	 fi

savings: $(PROGRAM) reference
	@echo "Calculating space savings (Assembly vs. C reference)"
	@ASM_SIZE=$$(stat -c%s $(PROGRAM)); \
	 REF_SIZE=$$(stat -c%s reference); \
	 DIFF=$$(($$REF_SIZE - $$ASM_SIZE)); \
	 PCT=$$(awk -v d=$$DIFF -v r=$$REF_SIZE 'BEGIN{printf "%.2f", d/r*100}'); \
	 echo "  asm:            $$ASM_SIZE bytes"; \
	 echo "  C reference:	  $$REF_SIZE bytes"; \
	 echo "  savings:        $$DIFF bytes ( $${PCT}% )"; \
	 rm -f reference.upx

listing: $(PROGRAM).lst
	@cat $(PROGRAM).lst

clean:
	rm -f $(PROGRAM) reference $(PROGRAM).lst
