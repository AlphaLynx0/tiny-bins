.PHONY: all clean test savings

all: hello-world reference

hello-world: hello-world.asm
	nasm -f bin $< -o $@
	chmod +x $@

reference: hello-world.c
	gcc -s -Os $< -o $@

test: hello-world reference
	@ASM_OUT="$$(./hello-world)"; \
	 REF_OUT="$$(./reference)"; \
	 if [ "$$ASM_OUT" = "$$REF_OUT" ]; then \
	   echo "Test passed: output matched reference"; \
	 else \
	   echo "Test failed: output differed from reference"; \
	   echo "  ASM:       $$ASM_OUT"; \
	   echo "  Reference: $$REF_OUT"; \
	   exit 1; \
	 fi

savings: hello-world reference
	@echo "Calculating space savings (Assembly vs. C reference)"
	@ASM_SIZE=$$(stat -c%s hello-world); \
	 REF_SIZE=$$(stat -c%s reference); \
	 DIFF=$$(($$REF_SIZE - $$ASM_SIZE)); \
	 PCT=$$(awk -v d=$$DIFF -v r=$$REF_SIZE 'BEGIN{printf "%.2f", d/r*100}'); \
	 echo "  asm:            $$ASM_SIZE bytes"; \
	 echo "  C reference:	  $$REF_SIZE bytes"; \
	 echo "  savings:        $$DIFF bytes ( $${PCT}% )"; \
	 rm -f reference.upx

clean:
	rm -f hello-world reference
