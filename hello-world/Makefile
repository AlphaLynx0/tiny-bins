.PHONY: all clean test

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

clean:
	rm -f hello-world reference
