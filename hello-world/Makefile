all: hello-world

hello-world: hello-world.asm
	nasm -f bin hello-world.asm -o hello-world
	chmod +x ./hello-world

clean:
	rm ./hello-world
